package game.mediator.gui.homescreen
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.RedMarkerState;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.chat.ChatPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.homescreen.HomeScreenClanMenu;
   import idv.cjcat.signals.Signal;
   
   public class HomeScreenClanMenuMediator
   {
       
      
      private var player:Player;
      
      private var stashParams:PopupStashEventParams;
      
      private var _property_iconRequiresAttention:BooleanPropertyWriteable;
      
      private var _panel:HomeScreenClanMenu;
      
      private var _signal_clanUpdate:Signal;
      
      private var _signal_iconUpdate:Signal;
      
      private var _chatRedMarkerState:RedMarkerState;
      
      private var _clanRedMarkerState:RedMarkerState;
      
      private var _clanWarRedMarkerState:RedMarkerState;
      
      private var _titanArenaRewardRedMarkerState:RedMarkerState;
      
      private var _titanArenaPointsRewardRedMarkerState:RedMarkerState;
      
      public function HomeScreenClanMenuMediator(param1:Player)
      {
         _property_iconRequiresAttention = new BooleanPropertyWriteable();
         _signal_clanUpdate = new Signal();
         _signal_iconUpdate = new Signal();
         super();
         this.player = param1;
         _panel = new HomeScreenClanMenu(this);
         stashParams = new PopupStashEventParams();
         stashParams.windowName = "global";
         _chatRedMarkerState = new RedMarkerState("homeScreenClan_chat");
         _clanRedMarkerState = new RedMarkerState("homeScreenClan_clan");
         _clanWarRedMarkerState = new RedMarkerState("homeScreenClan_clanWar");
         _titanArenaRewardRedMarkerState = RedMarkerGlobalMediator.instance.titan_arena_reward;
         _titanArenaPointsRewardRedMarkerState = RedMarkerGlobalMediator.instance.titan_arena_points_reward;
         if(param1.isInited)
         {
            handler_playerInit();
         }
         else
         {
            param1.signal_update.initSignal.add(handler_playerInit);
         }
         updateIconHighlight();
         param1.titans.signal_newTitanObtained.add(handler_titanAmountUpdate);
         if(param1.levelData.level.level < MechanicStorage.TITAN_VALLEY.teamLevel)
         {
            param1.levelData.signal_levelUp.add(handler_playerLevelUp);
         }
         _clanWarRedMarkerState.signal_update.add(handle_clanMarkerUpdate);
         _titanArenaRewardRedMarkerState.signal_update.add(handle_clanMarkerUpdate);
         _titanArenaPointsRewardRedMarkerState.signal_update.add(handle_clanMarkerUpdate);
      }
      
      public function get property_iconRequiresAttention() : BooleanProperty
      {
         return _property_iconRequiresAttention;
      }
      
      public function get panel() : HomeScreenClanMenu
      {
         return _panel;
      }
      
      public function get signal_clanUpdate() : Signal
      {
         return _signal_clanUpdate;
      }
      
      public function get signal_iconUpdate() : Signal
      {
         return _signal_iconUpdate;
      }
      
      public function get chatRedMarkerState() : RedMarkerState
      {
         return _chatRedMarkerState;
      }
      
      public function get clanRedMarkerState() : RedMarkerState
      {
         return _clanRedMarkerState;
      }
      
      public function get clanWarRedMarkerState() : RedMarkerState
      {
         return _clanWarRedMarkerState;
      }
      
      public function get titanArenaRewardRedMarkerState() : RedMarkerState
      {
         return _titanArenaRewardRedMarkerState;
      }
      
      public function get titanArenaPointsRewardRedMarkerState() : RedMarkerState
      {
         return _titanArenaPointsRewardRedMarkerState;
      }
      
      public function get property_isOnClanScreen() : BooleanProperty
      {
         return Game.instance.screen.getMainScreen().isOnClanScreen;
      }
      
      public function get property_transitionIsInProgress() : BooleanProperty
      {
         return Game.instance.screen.getMainScreen().transitionInProgress;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return !!player.clan.clan?player.clan.clan.icon:null;
      }
      
      public function action_clickClan() : void
      {
         if(property_isOnClanScreen.value)
         {
            Game.instance.screen.getMainScreen().toHomeScreen();
         }
         else
         {
            Game.instance.navigator.navigateToClan(Stash.click("clan_screen",stashParams));
         }
         handle_clanMarkerUpdate();
      }
      
      public function action_clickChat() : void
      {
         var _loc1_:ChatPopupMediator = new ChatPopupMediator(player);
         _loc1_.open(Stash.click("clan_chat",stashParams));
      }
      
      public function initialize() : void
      {
         player.clan.signal_clanUpdate.add(handler_updateClan);
         if(player.clan.clan)
         {
            player.clan.clan.signal_iconUpdated.add(handler_iconUpdated);
         }
         _signal_clanUpdate.dispatch();
      }
      
      private function updateIconHighlight() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Boolean = true;
         var _loc1_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc2_:int = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_].artifacts.list;
            _loc7_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               if(_loc3_[_loc5_].currentEvolutionStar)
               {
                  _loc6_ = false;
                  break;
               }
               _loc5_++;
            }
            if(_loc6_)
            {
               _loc4_++;
               continue;
            }
            break;
         }
         _property_iconRequiresAttention.value = player.titans.getAmount() <= 2 || player.titans.getAmount() >= 5 && player.levelData.level.level >= MechanicStorage.TITAN_VALLEY.teamLevel && _loc6_;
      }
      
      private function handle_playerChatUpdate(param1:Boolean = false) : void
      {
         _chatRedMarkerState.value = player.chat.hasUnreadMessage || player.clan.clan != null && player.clan.clan.hasUnreadNews;
      }
      
      private function handle_redMarkerClanTriesUpdate(param1:int = -1) : void
      {
         handle_clanWarUpdate();
      }
      
      private function handle_redMarkerArePointsMaxUpdate(param1:Boolean = false) : void
      {
         handle_clanWarUpdate();
      }
      
      private function handle_setDefenseAvaliableUpdate() : void
      {
         handle_clanWarUpdate();
      }
      
      private function handle_clanWarUpdate(param1:int = -1) : void
      {
         _clanWarRedMarkerState.value = player.clan.clanWarData.property_redMarkerClanTries.value > 0 && !player.clan.clanWarData.property_redMarkerArePointsMax.value || player.clan.clanWarData.setDefenseAvaliable;
      }
      
      private function handle_clanMarkerUpdate() : void
      {
         var _loc1_:Boolean = !!Game.instance.screen.getMainScreen()?property_isOnClanScreen.value:false;
         _clanRedMarkerState.value = player.clan.clan && !_loc1_ && (_clanWarRedMarkerState.value || _titanArenaRewardRedMarkerState.value || _titanArenaPointsRewardRedMarkerState.value);
      }
      
      private function handler_playerInit() : void
      {
         player.chat.signal_hasUnreadMessage.add(handle_playerChatUpdate);
         if(player.clan.clan != null)
         {
            player.clan.clan.signal_hasUnreadNews.add(handle_playerChatUpdate);
            player.clan.clanWarData.property_redMarkerClanTries.signal_update.add(handle_redMarkerClanTriesUpdate);
            player.clan.clanWarData.property_redMarkerArePointsMax.signal_update.add(handle_redMarkerArePointsMaxUpdate);
            player.clan.clanWarData.signal_setDefenseAvaliableUpdate.add(handle_setDefenseAvaliableUpdate);
            handle_clanWarUpdate();
         }
         handle_playerChatUpdate();
         handle_clanMarkerUpdate();
      }
      
      private function handler_updateClan() : void
      {
         if(player.clan.clan)
         {
            player.clan.clan.signal_iconUpdated.add(handler_iconUpdated);
            player.clan.clan.signal_hasUnreadNews.add(handle_playerChatUpdate);
            player.clan.clanWarData.property_redMarkerClanTries.signal_update.add(handle_redMarkerClanTriesUpdate);
            player.clan.clanWarData.property_redMarkerArePointsMax.signal_update.add(handle_redMarkerArePointsMaxUpdate);
            player.clan.clanWarData.signal_setDefenseAvaliableUpdate.add(handle_setDefenseAvaliableUpdate);
            handle_clanWarUpdate();
         }
         _signal_clanUpdate.dispatch();
         handle_clanMarkerUpdate();
      }
      
      private function handler_iconUpdated() : void
      {
         _signal_iconUpdate.dispatch();
      }
      
      private function handler_titanAmountUpdate(param1:PlayerTitanEntry) : void
      {
         updateIconHighlight();
      }
      
      private function handler_playerLevelUp(param1:PlayerTeamLevel) : void
      {
         updateIconHighlight();
      }
   }
}
