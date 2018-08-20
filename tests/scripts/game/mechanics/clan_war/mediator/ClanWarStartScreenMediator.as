package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mechanics.clan_war.mediator.log.ClanWarLogPopupMediator;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.PlayerClanWarData;
   import game.mechanics.clan_war.model.command.CommandClanWarGetAvailableHistory;
   import game.mechanics.clan_war.model.command.CommandClanWarSetDefenceTeam;
   import game.mechanics.clan_war.popup.start.ClanWarStartScreen;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class ClanWarStartScreenMediator extends ClanPopupMediatorBase
   {
       
      
      private var timer:Timer;
      
      private var playerDefender_heroes:ClanWarDefenderValueObject;
      
      private var playerDefender_titans:ClanWarDefenderValueObject;
      
      private var _tries_me:IntProperty;
      
      private var _tries_clan:IntProperty;
      
      private var _property_serverDataReady:BooleanPropertyWriteable;
      
      private var _signal_updatePlayerSlotPosition:Signal;
      
      private var _signal_updateDefenseTeams:Signal;
      
      private var _signal_timer:Signal;
      
      private var _signal_updateOccupiedSlotsCount:Signal;
      
      public function ClanWarStartScreenMediator(param1:Player)
      {
         timer = new Timer(1000);
         _property_serverDataReady = new BooleanPropertyWriteable();
         _signal_updatePlayerSlotPosition = new Signal();
         _signal_updateDefenseTeams = new Signal();
         _signal_timer = new Signal();
         _signal_updateOccupiedSlotsCount = new Signal();
         super(param1);
         param1.clan.clanWarData.action_getStatus();
         param1.clan.clanWarData.signal_currentWarGetInfo.add(handler_currentWarGetInfo);
         param1.clan.clanWarData.signal_occupiedSlotsCountUpdate.add(handler_occupiedSlotCountUpdate);
         timer.addEventListener("timer",handler_timer);
      }
      
      override protected function dispose() : void
      {
         unsubsciribeFromPlayerSlots();
         timer.stop();
         player.clan.clanWarData.signal_currentWarGetInfo.remove(handler_currentWarGetInfo);
         player.clan.clanWarData.signal_occupiedSlotsCountUpdate.remove(handler_occupiedSlotCountUpdate);
         super.dispose();
      }
      
      public function get tries_me() : IntProperty
      {
         return _tries_me;
      }
      
      public function get tries_clan() : IntProperty
      {
         return _tries_clan;
      }
      
      public function get participant_us() : ClanWarParticipantValueObject
      {
         return !!player.clan.clanWarData.currentWar?player.clan.clanWarData.currentWar.participant_us:null;
      }
      
      public function get participant_them() : ClanWarParticipantValueObject
      {
         return !!player.clan.clanWarData.currentWar?player.clan.clanWarData.currentWar.participant_them:null;
      }
      
      public function get property_serverDataReady() : BooleanProperty
      {
         return _property_serverDataReady;
      }
      
      public function get defenders_hero() : Vector.<UnitEntryValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get defenders_titan() : Vector.<UnitEntryValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get playerHeroTeamPositionString() : String
      {
         var _loc1_:ClanWarDefenderValueObject = player.clan.clanWarData.getPlayerTeam(true);
         if(_loc1_ && _loc1_.currentSlot)
         {
            return _loc1_.currentSlotDesc.fortificationDesc.name;
         }
         return Translate.translate("UI_CLAN_WAR_POSITION_NONE");
      }
      
      public function get playerTitanTeamPositionString() : String
      {
         var _loc1_:ClanWarDefenderValueObject = player.clan.clanWarData.getPlayerTeam(false);
         if(_loc1_ && _loc1_.currentSlot)
         {
            return _loc1_.currentSlotDesc.fortificationDesc.name;
         }
         return Translate.translate("UI_CLAN_WAR_POSITION_NONE");
      }
      
      public function get signal_updatePlayerSlotPosition() : Signal
      {
         return _signal_updatePlayerSlotPosition;
      }
      
      public function get signal_updateDefenseTeams() : Signal
      {
         return _signal_updateDefenseTeams;
      }
      
      public function get signal_timer() : Signal
      {
         return _signal_timer;
      }
      
      public function get signal_updateOccupiedSlotsCount() : Signal
      {
         return _signal_updateOccupiedSlotsCount;
      }
      
      public function get signal_attackAvaliableForMeUpdate() : Signal
      {
         return player.clan.clanWarData.signal_attackAvaliableForMeUpdate;
      }
      
      public function get signal_setDefenseAvaliableUpdate() : Signal
      {
         return player.clan.clanWarData.signal_setDefenseAvaliableUpdate;
      }
      
      public function get occupiedSlotCount_enough() : Boolean
      {
         if(!Translate.has("UI_CLAN_WAR_START_VIEW_TF_NO_WAR_NO_DEFENDERS_HEADER"))
         {
            return true;
         }
         var _loc1_:ClanWarLeagueDescription = DataStorage.clanWar.getLeagueById(player.clan.clanWarData.leagueId);
         if(!_loc1_ || _loc1_.divisionSize == 0)
         {
            return occupiedSlotCount_current >= occupiedSlotCount_min;
         }
         return true;
      }
      
      public function get occupiedSlotCount_min() : int
      {
         return DataStorage.rule.clanWarRule.matchmakingMinOccupiedSlots;
      }
      
      public function get occupiedSlotCount_current() : int
      {
         return player.clan.clanWarData.countOccupiedDefenseSlots();
      }
      
      public function get timeLeft_warEnd() : String
      {
         if(!player.clan.clanWarData || !player.clan.clanWarData.currentWar)
         {
            return timeLeftString(0);
         }
         return timeLeftString(player.clan.clanWarData.currentWar.endTime);
      }
      
      public function get timeLeft_warStart() : String
      {
         if(!player.clan.clanWarData)
         {
            return timeLeftString(0);
         }
         return timeLeftString(player.clan.clanWarData.time_nextWar);
      }
      
      public function get timeLeft_defenseLock() : String
      {
         var _loc2_:int = 0;
         if(player.clan.clanWarData)
         {
            _loc2_ = player.clan.clanWarData.time_nextWar;
         }
         var _loc1_:int = _loc2_ - GameTimer.instance.currentServerTime;
         if(_loc1_ <= 0)
         {
            _loc1_ = 0;
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get defenseLocked() : Boolean
      {
         var _loc1_:* = null;
         if(!player.clan.clanWarData)
         {
            return false;
         }
         _loc1_ = player.clan.clanWarData;
         return _loc1_.time_nextWar < _loc1_.time_nextLock;
      }
      
      public function get showClanTries() : Boolean
      {
         return player.clan.clanWarData.currentWar.showClanTries;
      }
      
      public function get redMarkerState_attackAvaliableForMe() : Boolean
      {
         return player && player.clan.clanWarData && player.clan.clanWarData.attackAvaliableForMe;
      }
      
      public function get redMarkerState_setDefenseAvaliable() : Boolean
      {
         return player && player.clan.clanWarData && player.clan.clanWarData.setDefenseAvaliable;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarStartScreen(this);
         return _popup;
      }
      
      public function action_shop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_GUILDWAR_SHOP);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_openMemberList_our() : void
      {
         var _loc1_:ActiveClanWarMembersPopupMediator = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,true);
         _loc1_.open(Stash.click("members_our",_popup.stashParams));
      }
      
      public function action_openMemberList_enemy() : void
      {
         var _loc1_:ActiveClanWarMembersPopupMediator = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,false);
         _loc1_.open(Stash.click("members_their",_popup.stashParams));
      }
      
      public function action_navigateToWar() : void
      {
         var _loc1_:ClanWarScreenMediator = new ClanWarScreenMediator(player);
         _loc1_.open(Stash.click("button_war",_popup.stashParams));
      }
      
      public function action_navigateToPlan() : void
      {
         var _loc1_:ClanWarPlanScreenMediator = new ClanWarPlanScreenMediator(player);
         _loc1_.open(Stash.click("button_plan",_popup.stashParams));
      }
      
      public function action_gatherHeroTeam() : void
      {
         var _loc1_:ClanWarDefenderTeamGatherPopupMediator = new ClanWarDefenderTeamGatherPopupMediator(player,player.heroes.teamData.getClanWarTeam(true,false),false);
         _loc1_.open(Stash.click("action_gatherHeroTeam",_popup.stashParams));
         _loc1_.signal_teamGatherComplete.add(handler_setDefenseTeam);
      }
      
      public function action_gatherTitanTeam() : void
      {
         var _loc1_:ClanWarDefenderTeamGatherPopupMediator = new ClanWarDefenderTeamGatherPopupMediator(player,player.heroes.teamData.getClanWarTeam(true,true),true);
         _loc1_.open(Stash.click("action_gatherHeroTeam",_popup.stashParams));
         _loc1_.signal_teamGatherComplete.add(handler_setDefenseTeam);
      }
      
      public function action_navigateToLeagues() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(Translate.has("UI_DIALOG_CLAN_WAR_LEAGUES_TITLE"))
         {
            _loc2_ = new ClanWarLeaguesPopupMediator(player);
            _loc2_.open(Stash.click("button_leagues",_popup.stashParams));
         }
         else
         {
            _loc1_ = new ClanWarLeaguesAndRewardsPopupMediator(GameModel.instance.player);
            _loc1_.open(Stash.click("button_leagues",_popup.stashParams));
         }
      }
      
      public function action_navigateToLog() : void
      {
         var _loc1_:CommandClanWarGetAvailableHistory = GameModel.instance.actionManager.clanWar.clanWarGetAvailableHistory();
         _loc1_.onClientExecute(handler_commandClanWarGetAvailableHistory);
      }
      
      private function subsciribeToPlayerSlots() : void
      {
         unsubsciribeFromPlayerSlots();
         playerDefender_heroes = player.clan.clanWarData.getPlayerTeam(true);
         if(playerDefender_heroes)
         {
            playerDefender_heroes.signal_updateCurrentSlot.add(handler_updatePlayerSlot);
         }
         playerDefender_titans = player.clan.clanWarData.getPlayerTeam(false);
         if(playerDefender_titans)
         {
            playerDefender_titans.signal_updateCurrentSlot.add(handler_updatePlayerSlot);
         }
      }
      
      private function unsubsciribeFromPlayerSlots() : void
      {
         if(playerDefender_heroes)
         {
            playerDefender_heroes.signal_updateCurrentSlot.remove(handler_updatePlayerSlot);
         }
         if(playerDefender_titans)
         {
            playerDefender_titans.signal_updateCurrentSlot.remove(handler_updatePlayerSlot);
         }
      }
      
      private function timeLeftString(param1:int) : String
      {
         var _loc2_:int = param1 - GameTimer.instance.currentServerTime;
         if(_loc2_ <= 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 86400)
         {
            return TimeFormatter.toDH(_loc2_,"{d} {h} {m}"," ",true);
         }
         return TimeFormatter.toMS2(_loc2_);
      }
      
      private function handler_commandClanWarGetAvailableHistory(param1:CommandClanWarGetAvailableHistory) : void
      {
         var _loc2_:ClanWarLogPopupMediator = new ClanWarLogPopupMediator(player,param1.logs,param1.lastSeasonResult);
         _loc2_.open(Stash.click("button_log",_popup.stashParams));
      }
      
      private function handler_setDefenseTeam(param1:ClanWarDefenderTeamGatherPopupMediator) : void
      {
         subsciribeToPlayerSlots();
         var _loc2_:CommandClanWarSetDefenceTeam = GameModel.instance.actionManager.clanWar.clanWarSetDefenceTeam(param1.descriptionList,param1.isTitanTeam);
         _signal_updateDefenseTeams.dispatch();
         param1.close();
      }
      
      private function handler_occupiedSlotCountUpdate() : void
      {
         _signal_updateOccupiedSlotsCount.dispatch();
      }
      
      private function handler_currentWarGetInfo() : void
      {
         if(player.clan.clanWarData.currentWar)
         {
            _tries_me = player.clan.clanWarData.currentWar.myTries;
            _tries_clan = player.clan.clanWarData.currentWar.ourClanTries.displayValue_triesLeft;
         }
         timer.start();
         subsciribeToPlayerSlots();
         _property_serverDataReady.value = true;
      }
      
      protected function handler_timer(param1:TimerEvent) : void
      {
         _signal_timer.dispatch();
      }
      
      private function handler_updatePlayerSlot(param1:ClanWarDefenderValueObject) : void
      {
         _signal_updatePlayerSlotPosition.dispatch();
      }
   }
}
