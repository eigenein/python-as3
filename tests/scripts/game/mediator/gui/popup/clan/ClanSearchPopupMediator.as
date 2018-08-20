package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.clan.CommandClanFindByTitle;
   import game.command.rpc.clan.CommandClanGetInfo;
   import game.command.rpc.clan.CommandClanGetRecommended;
   import game.command.rpc.clan.CommandClanJoin;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanSearchPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanSearchPopupMediator extends PopupMediator
   {
       
      
      private var _data_recommendedResult:ListCollection;
      
      private var _data_searchResults:ListCollection;
      
      private var _data_friendClans:ListCollection;
      
      private var _signal_updateSearchResult:Signal;
      
      private var _signal_updateFriendClans:Signal;
      
      private var _signal_updateRecommendedResults:Signal;
      
      public function ClanSearchPopupMediator(param1:Player)
      {
         _signal_updateRecommendedResults = new Signal();
         super(param1);
         _signal_updateFriendClans = new Signal();
         _signal_updateSearchResult = new Signal();
      }
      
      public function get data_recommendedResult() : ListCollection
      {
         return _data_recommendedResult;
      }
      
      public function get data_searchResults() : ListCollection
      {
         return _data_searchResults;
      }
      
      public function get data_friendClans() : ListCollection
      {
         return _data_friendClans;
      }
      
      public function get signal_updateSearchResult() : Signal
      {
         return _signal_updateSearchResult;
      }
      
      public function get signal_updateFriendClans() : Signal
      {
         return _signal_updateFriendClans;
      }
      
      public function get signal_updateRecommendedResults() : Signal
      {
         return _signal_updateRecommendedResults;
      }
      
      public function get promptSearch() : String
      {
         return Translate.translate("UI_DIALOG_CLAN_SEARCH_PROMPT");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanSearchPopup(this);
         return _popup;
      }
      
      public function action_getData() : void
      {
         var _loc1_:CommandClanGetRecommended = GameModel.instance.actionManager.clan.clanGetRecommended(player.serverId);
         _loc1_.onClientExecute(handler_getRecommendedDataComplete);
      }
      
      private function handler_getRecommendedDataComplete(param1:CommandClanGetRecommended) : void
      {
         _data_recommendedResult = new ListCollection(convertServerResult(param1.result_recommended));
         _signal_updateRecommendedResults.dispatch();
         if(param1.result_friendClans)
         {
            _data_friendClans = new ListCollection(convertServerFriendDataResult(param1.result_friendClans));
            _signal_updateFriendClans.dispatch();
         }
      }
      
      public function action_search(param1:String) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = GameModel.instance.actionManager.clan.clanFindByTitle(param1);
            _loc2_.onClientExecute(handler_searchByTitleComplete);
         }
         else
         {
            _signal_updateRecommendedResults.dispatch();
         }
      }
      
      public function action_selectClan(param1:ClanValueObject) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:RefillableDescription = DataStorage.refillable.getByIdent("clanReenter_cooldown");
         var _loc2_:PlayerRefillableEntry = player.refillable.getById(_loc5_.id);
         if(_loc2_.value > 0)
         {
            _loc4_ = GameModel.instance.actionManager.clan.clanJoin(param1.id);
            _loc4_.onClientExecute(handler_onClanJoin);
         }
         else
         {
            _loc3_ = PopupList.instance.popup_clan_enter_cooldown(param1,_popup.stashParams);
            _loc3_.signal_cooldownSkipped.addOnce(handler_cooldownSkipped);
         }
      }
      
      public function action_selectClanProfile(param1:ClanValueObject) : void
      {
         var _loc2_:CommandClanGetInfo = GameModel.instance.actionManager.clan.clanGetInfo(param1.id);
         _loc2_.onClientExecute(handler_clanProfileResult);
      }
      
      public function action_selectFriendList(param1:FriendClanValueObject) : void
      {
         var _loc2_:ClanFriendListPopupMediator = new ClanFriendListPopupMediator(player,param1.friends,param1);
         _loc2_.open(Stash.click("clan_friends",_popup.stashParams));
      }
      
      public function action_createClan() : void
      {
         var _loc1_:ClanCreatePopupMediator = new ClanCreatePopupMediator(player);
         _loc1_.open(Stash.click("create_clan",_popup.stashParams));
         close();
      }
      
      private function convertServerResult(param1:Vector.<ClanPublicInfoValueObject>) : Vector.<ClanValueObject>
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Vector.<ClanValueObject> = new Vector.<ClanValueObject>();
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = new ClanValueObject(param1[_loc4_],player);
            _loc3_.push(_loc5_);
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function convertServerFriendDataResult(param1:Vector.<ClanPublicInfoValueObject>) : Vector.<FriendClanValueObject>
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Vector.<PlayerFriendEntry> = player.friends.getAppFriends();
         var _loc4_:Vector.<FriendClanValueObject> = new Vector.<FriendClanValueObject>();
         var _loc3_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = new FriendClanValueObject(param1[_loc5_],player);
            _loc2_ = _loc8_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               if(_loc8_[_loc7_].serverUserClanId == _loc6_.id)
               {
                  _loc6_.addFriend(_loc8_[_loc7_]);
               }
               _loc7_++;
            }
            _loc4_.push(_loc6_);
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function handler_cooldownSkipped(param1:ClanEnterCooldownPopupMediator) : void
      {
         action_selectClan(param1.clan);
      }
      
      private function handler_searchByTitleComplete(param1:CommandClanFindByTitle) : void
      {
         _data_searchResults = new ListCollection(convertServerResult(param1.searchResult));
         _signal_updateSearchResult.dispatch();
      }
      
      private function handler_onClanJoin(param1:CommandClanJoin) : void
      {
         if(param1.isSucceeded)
         {
            Game.instance.navigator.navigateToClan(Stash.click("clan_screen",_popup.stashParams));
            close();
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_CLAN_JOIN_MESSAGE_FULL"));
         }
      }
      
      private function handler_clanJoinedFromProfile() : void
      {
         close();
      }
      
      private function handler_clanProfileResult(param1:CommandClanGetInfo) : void
      {
         var _loc2_:ClanPublicInfoPopupMediator = new ClanPublicInfoPopupMediator(param1.clanValueObject,player);
         _loc2_.signal_clanJoin.addOnce(handler_clanJoinedFromProfile);
         _loc2_.open(Stash.click("clan_public_profile",_popup.stashParams));
      }
   }
}
