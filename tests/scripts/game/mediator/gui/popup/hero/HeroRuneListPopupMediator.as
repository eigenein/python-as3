package game.mediator.gui.popup.hero
{
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.HeroRuneListPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroRuneListPopupMediator extends PopupMediator
   {
      
      public static const TAB_SYMBOLS:String = "tab_symbols";
      
      public static const TAB_ELEMENTS:String = "tab_elements";
       
      
      private var _selectedTabIndex:int;
      
      private var titanGiftLevelUpAvaliable:Boolean;
      
      private var _data:Vector.<PlayerHeroListValueObject>;
      
      private var _tabs:Vector.<String>;
      
      private var _signal_updateData:Signal;
      
      private var _signal_tabChange:Signal;
      
      private var _signal_updateTitanGiftLevelUpAvaliable:Signal;
      
      public function HeroRuneListPopupMediator(param1:Player, param2:String = "tab_symbols")
      {
         var _loc3_:int = 0;
         _signal_updateTitanGiftLevelUpAvaliable = new Signal();
         super(param1);
         _tabs = new Vector.<String>();
         _tabs[0] = "tab_symbols";
         _tabs[1] = "tab_elements";
         _loc3_ = 0;
         while(_loc3_ < _tabs.length)
         {
            if(_tabs[_loc3_] == param2)
            {
               selectedTabIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
         _signal_updateData = new Signal();
         _signal_tabChange = new Signal();
         filterData();
         param1.heroes.watcher.signal_update.add(handler_heroesWatcherUpdate);
         handler_heroesWatcherUpdate();
      }
      
      override protected function dispose() : void
      {
         player.heroes.watcher.signal_update.remove(handler_heroesWatcherUpdate);
         var _loc3_:int = 0;
         var _loc2_:* = _data;
         for each(var _loc1_ in _data)
         {
            _loc1_.dispose();
         }
         _data = null;
         super.dispose();
      }
      
      public function get selectedTabIndex() : int
      {
         return _selectedTabIndex;
      }
      
      public function set selectedTabIndex(param1:int) : void
      {
         _selectedTabIndex = param1;
      }
      
      public function get data() : Vector.<PlayerHeroListValueObject>
      {
         return _data;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get signal_updateData() : Signal
      {
         return _signal_updateData;
      }
      
      public function get signal_tabChange() : Signal
      {
         return _signal_tabChange;
      }
      
      public function get signal_updateTitanGiftLevelUpAvaliable() : Signal
      {
         return _signal_updateTitanGiftLevelUpAvaliable;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroRuneListPopup(this);
         return _popup;
      }
      
      override public function close() : void
      {
         super.close();
      }
      
      public function getTabVisibleByID(param1:String) : Boolean
      {
         if(param1 == "tab_symbols")
         {
            return false;
         }
         if(param1 == "tab_elements")
         {
            return titanGiftLevelUpAvaliable;
         }
         return false;
      }
      
      public function action_select(param1:PlayerHeroListValueObject) : void
      {
         if(selectedTabIndex == 0)
         {
            PopupList.instance.dialog_runes(param1.hero,Stash.click("hero_runes",_popup.stashParams));
         }
         else if(selectedTabIndex == 1)
         {
            PopupList.instance.dialog_elements(param1.hero,Stash.click("hero_elements",_popup.stashParams));
         }
      }
      
      private function filterData() : void
      {
         var _loc3_:int = 0;
         if(_data)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _data;
            for each(var _loc2_ in _data)
            {
               _loc2_.dispose();
            }
         }
         _data = new Vector.<PlayerHeroListValueObject>();
         var _loc4_:Vector.<PlayerHeroEntry> = player.heroes.getList();
         var _loc1_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _data.push(new PlayerHeroRuneListValueObject(_loc4_[_loc3_].hero,player));
            _loc3_++;
         }
         _data.sort(PlayerHeroListValueObject.sort);
      }
      
      private function handler_heroesWatcherUpdate() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = titanGiftLevelUpAvaliable;
         titanGiftLevelUpAvaliable = false;
         _loc1_ = 0;
         while(_loc1_ < _data.length)
         {
            if(!titanGiftLevelUpAvaliable)
            {
               titanGiftLevelUpAvaliable = _data[_loc1_].titanGiftLevelUpAvaliable;
            }
            _loc1_++;
         }
         if(_loc2_ != titanGiftLevelUpAvaliable)
         {
            signal_updateTitanGiftLevelUpAvaliable.dispatch();
         }
      }
      
      public function action_tabSelect(param1:int) : void
      {
         selectedTabIndex = param1;
         signal_tabChange.dispatch();
      }
   }
}
