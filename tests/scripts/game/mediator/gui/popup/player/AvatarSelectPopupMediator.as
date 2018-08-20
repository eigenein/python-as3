package game.mediator.gui.popup.player
{
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.MessagePopup;
   import game.view.popup.PopupBase;
   import game.view.popup.player.AvatarSelectPopup;
   import idv.cjcat.signals.Signal;
   
   public class AvatarSelectPopupMediator extends PopupMediator
   {
      
      public static const TAB_ALL:String = "TAB_ALL";
      
      public static const TAB_CAMPAIGN:String = "TAB_CAMPAIGN";
      
      public static const TAB_HEROES:String = "TAB_HEROES";
      
      public static const TAB_SKINS:String = "TAB_SKINS";
      
      public static const TAB_TITANS:String = "TAB_TITANS";
      
      public static const TAB_UNIQUE:String = "TAB_UNIQUE";
       
      
      private var list:Vector.<AvatarSelectValueObject>;
      
      private var _signal_recreateTabs:Signal;
      
      private var _tabs:Vector.<String>;
      
      private var _tabSelected:String;
      
      private var _dataProvider:ListCollection;
      
      private var _signal_tabUpdate:Signal;
      
      private var _signal_dataReady:Signal;
      
      public function AvatarSelectPopupMediator(param1:Player)
      {
         _signal_recreateTabs = new Signal();
         super(param1);
         _tabs = new Vector.<String>();
         _tabs.push("TAB_ALL");
         _tabs.push("TAB_CAMPAIGN");
         _tabs.push("TAB_HEROES");
         _tabs.push("TAB_TITANS");
         _tabs.push("TAB_SKINS");
         _tabSelected = tabs[0];
         _signal_tabUpdate = new Signal();
         _signal_dataReady = new Signal();
         GameModel.instance.actionManager.playerCommands.avatarsGetUnlocked();
         param1.avatarData.signal_updateAvailableAvatars.add(handler_updateUnlockedList);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new AvatarSelectPopup(this);
         return _popup;
      }
      
      override protected function dispose() : void
      {
         player.avatarData.signal_updateAvailableAvatars.remove(handler_updateUnlockedList);
         super.dispose();
      }
      
      public function get signal_recreateTabs() : Signal
      {
         return _signal_recreateTabs;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get tabSelected() : String
      {
         return _tabSelected;
      }
      
      public function set tabSelected(param1:String) : void
      {
         if(_tabSelected != param1)
         {
            _tabSelected = param1;
         }
      }
      
      public function get selectedTabIndex() : uint
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < tabs.length)
         {
            if(tabs[_loc1_] == tabSelected)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function get dataProvider() : ListCollection
      {
         return _dataProvider;
      }
      
      public function get signal_tabUpdate() : Signal
      {
         return _signal_tabUpdate;
      }
      
      public function get signal_dataReady() : Signal
      {
         return _signal_dataReady;
      }
      
      public function action_tabSelect(param1:int) : void
      {
         _tabSelected = tabs[param1];
         var _loc2_:Vector.<AvatarSelectValueObject> = list.filter(filterItems);
         _loc2_.sort(_sortAvailable);
         _dataProvider = new ListCollection(_loc2_);
         _signal_tabUpdate.dispatch();
      }
      
      public function action_selectAvatar(param1:AvatarSelectValueObject) : void
      {
         if(param1.available)
         {
            GameModel.instance.actionManager.playerCommands.changeAvatar(param1.desc.id);
            close();
         }
         else
         {
            PopUpManager.addPopUp(new MessagePopup(param1.taskDescription,""));
         }
      }
      
      public function getTabMarkerVisibleByID(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         if(!list)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            if(list[_loc2_].justUnlocked)
            {
               if(param1 == "TAB_ALL")
               {
                  return true;
               }
               if(param1 == "TAB_CAMPAIGN" && isCampaignGroup(list[_loc2_]))
               {
                  return true;
               }
               if(param1 == "TAB_HEROES" && isHeroesGroup(list[_loc2_]))
               {
                  return true;
               }
               if(param1 == "TAB_SKINS" && isSkinsGroup(list[_loc2_]))
               {
                  return true;
               }
               if(param1 == "TAB_UNIQUE" && isUniqueGroup(list[_loc2_]))
               {
                  return true;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function filterItems(param1:AvatarSelectValueObject, param2:int, param3:Vector.<AvatarSelectValueObject>) : Boolean
      {
         if(tabSelected == "TAB_ALL" || tabSelected == "TAB_CAMPAIGN" && isCampaignGroup(param1) || tabSelected == "TAB_HEROES" && isHeroesGroup(param1) || tabSelected == "TAB_SKINS" && isSkinsGroup(param1) || tabSelected == "TAB_TITANS" && isTitansGroup(param1) || tabSelected == "TAB_UNIQUE" && isUniqueGroup(param1))
         {
            return true;
         }
         return false;
      }
      
      private function isCampaignGroup(param1:AvatarSelectValueObject) : Boolean
      {
         return param1.desc.translationMethod.length == 0 || param1.desc.translationMethod.indexOf("missionCompleteName") >= 0 || param1.desc.translationMethod.indexOf("heroAmount") >= 0;
      }
      
      private function isHeroesGroup(param1:AvatarSelectValueObject) : Boolean
      {
         return param1.desc.translationMethod.indexOf("heroByName") >= 0;
      }
      
      private function isTitansGroup(param1:AvatarSelectValueObject) : Boolean
      {
         return param1.desc.assetType == "titan_icon";
      }
      
      private function isSkinsGroup(param1:AvatarSelectValueObject) : Boolean
      {
         return param1.desc.translationMethod.indexOf("heroSkinLevelById") >= 0;
      }
      
      private function isUniqueGroup(param1:AvatarSelectValueObject) : Boolean
      {
         return param1.desc.hidden;
      }
      
      private function _sortAvailable(param1:AvatarSelectValueObject, param2:AvatarSelectValueObject) : int
      {
         var _loc3_:int = (!!param1.desc.name?0:1) * 10000 + int(!param1.available) * 100000 + param1.desc.id;
         var _loc4_:int = (!!param2.desc.name?0:1) * 10000 + int(!param2.available) * 100000 + param2.desc.id;
         return _loc3_ - _loc4_;
      }
      
      private function handler_updateUnlockedList() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         var _loc2_:* = null;
         list = new Vector.<AvatarSelectValueObject>();
         var _loc6_:PlayerAvatarDescription = player.avatarData.avatarDesc;
         var _loc1_:Vector.<PlayerAvatarDescription> = DataStorage.playerAvatar.getVisibleList();
         _loc3_ = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            list[_loc4_] = new AvatarSelectValueObject(_loc1_[_loc4_],player.avatarData.isAvailable(_loc1_[_loc4_]),_loc6_ == _loc1_[_loc4_]);
            _loc4_++;
         }
         var _loc5_:Boolean = false;
         _loc1_ = DataStorage.playerAvatar.getHiddenList();
         _loc3_ = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(player.avatarData.isAvailable(_loc1_[_loc4_]))
            {
               list[list.length] = new AvatarSelectValueObject(_loc1_[_loc4_],true,_loc6_ == _loc1_[_loc4_]);
               if(_tabs.indexOf("TAB_UNIQUE") == -1)
               {
                  _tabs.push("TAB_UNIQUE");
                  _loc5_ = true;
               }
            }
            _loc4_++;
         }
         if(_loc5_)
         {
            _signal_recreateTabs.dispatch();
         }
         _loc3_ = list.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = list[_loc4_] as AvatarSelectValueObject;
            if(player.avatarData.recentlyUnlockedAvatars[_loc2_.desc.id])
            {
               _loc2_.unlock();
            }
            _loc4_++;
         }
         player.avatarData.action_clearRecentlyUnlockedAvatars();
         signal_dataReady.dispatch();
      }
   }
}
