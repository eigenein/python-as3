package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.ShopDescriptionStorage;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.mechanics.titan_arena.mediator.raid.TitanArenaRaidStartPopupMediator;
   import game.mechanics.titan_arena.mediator.rating.TitanArenaRatingPopupMediator;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaPointsRewardPopupMediator;
   import game.mechanics.titan_arena.model.PlayerTitanArenaDailyNotFarmedRewardData;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaStartBattle;
   import game.mechanics.titan_arena.popup.TitanArenaPopup;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titanarena.TitanArenaRulesPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanArenaPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _teamGatherPopup:TitanArenaAttackTeamGatherPopupMediator;
      
      private var _status_peace:BooleanPropertyWriteable;
      
      private var _signal_updateRivals:Signal;
      
      private var _signal_updateDefenseTeam:Signal;
      
      private var _signal_pointsUpdate:Signal;
      
      private var _property_serverDataReady:BooleanPropertyWriteable;
      
      private var _property_playerReady:BooleanPropertyWriteable;
      
      private var _property_canRaid:BooleanPropertyWriteable;
      
      private var _signal_farmReward:Signal;
      
      private var _status_canUpdateDefense:BooleanPropertyWriteable;
      
      private var _property_stage:IntPropertyWriteable;
      
      public function TitanArenaPopupMediator(param1:Player)
      {
         _status_peace = new BooleanPropertyWriteable();
         _signal_updateRivals = new Signal();
         _signal_updateDefenseTeam = new Signal();
         _signal_pointsUpdate = new Signal();
         _property_serverDataReady = new BooleanPropertyWriteable();
         _property_playerReady = new BooleanPropertyWriteable();
         _property_canRaid = new BooleanPropertyWriteable();
         _signal_farmReward = new Signal();
         _status_canUpdateDefense = new BooleanPropertyWriteable();
         _property_stage = new IntPropertyWriteable();
         super(param1);
         _status_canUpdateDefense.value = param1.titanArenaData.canUpdateDefenders.value;
         _property_stage.value = param1.titanArenaData.property_tier.value;
         param1.titanArenaData.action_commandGetStatus();
         param1.titanArenaData.property_score.signal_update.add(handler_pointsUpdate);
         param1.titanArenaData.property_status.signal_update.add(handler_getStatus);
         param1.titanArenaData.signal_defenderTeamUpdate.add(handler_defenderTeamUpdate);
         param1.titanArenaData.signal_enemiesUpdate.add(handler_enemiesUpdate);
         param1.titanArenaData.property_tier.signal_update.add(handler_tierUpdate);
         param1.titanArenaData.canUpdateDefenders.signal_update.add(handler_canUpdateDefenders);
         param1.titanArenaData.dailyRewardsData.signal_farmReward.add(handler_farmReward);
         param1.titanArenaData.canRaid.onValue(handler_canRaid);
      }
      
      override protected function dispose() : void
      {
         player.titanArenaData.property_score.signal_update.remove(handler_pointsUpdate);
         player.titanArenaData.property_status.signal_update.remove(handler_getStatus);
         player.titanArenaData.signal_defenderTeamUpdate.remove(handler_defenderTeamUpdate);
         player.titanArenaData.signal_enemiesUpdate.remove(handler_enemiesUpdate);
         player.titanArenaData.property_tier.signal_update.remove(handler_tierUpdate);
         player.titanArenaData.canUpdateDefenders.signal_update.remove(handler_canUpdateDefenders);
         player.titanArenaData.dailyRewardsData.signal_farmReward.remove(handler_farmReward);
         player.titanArenaData.canRaid.unsubscribe(handler_canRaid);
         super.dispose();
      }
      
      public function get status_peace() : BooleanProperty
      {
         return _status_peace;
      }
      
      public function get signal_updateRivals() : Signal
      {
         return _signal_updateRivals;
      }
      
      public function get signal_updateDefenseTeam() : Signal
      {
         return _signal_updateDefenseTeam;
      }
      
      public function get signal_pointsUpdate() : Signal
      {
         return _signal_pointsUpdate;
      }
      
      public function get property_serverDataReady() : BooleanProperty
      {
         return _property_serverDataReady;
      }
      
      public function get property_playerReady() : BooleanProperty
      {
         return _property_playerReady;
      }
      
      public function get property_canRaid() : BooleanProperty
      {
         return _property_canRaid;
      }
      
      public function get signal_farmReward() : Signal
      {
         return _signal_farmReward;
      }
      
      public function get points() : int
      {
         return player.titanArenaData.property_score.value;
      }
      
      public function get string_place() : String
      {
         var _loc1_:* = null;
         if(player.titanArenaData.property_rank.value > 0)
         {
            _loc1_ = ColorUtils.hexToRGBFormat(16777215) + String(player.titanArenaData.property_rank.value);
            return Translate.translateArgs("UI_DIALOG_TITAN_ARENA_PLACE",_loc1_);
         }
         return Translate.translate("UI_CLAN_WAR_POSITION_NONE");
      }
      
      public function get string_status() : String
      {
         if(player.titanArenaData.property_status.value == "battle" || player.titanArenaData.property_status.value == "not_prepared")
         {
            return Translate.translateArgs("UI_TITAN_ARENA_DEFENSE_UI_TF_LABEL_STATUS",timer_dayEnd);
         }
         if(player.titanArenaData.property_status.value == "peace_time")
         {
            return Translate.translateArgs("UI_PEACE_TIME_CLIP_TF_LABEL_STATUS",timer_dayStart);
         }
         return "";
      }
      
      public function get playerTeam() : Vector.<UnitEntryValueObject>
      {
         return player.titanArenaData.defenders;
      }
      
      public function get enemies() : Vector.<PlayerTitanArenaEnemy>
      {
         return player.titanArenaData.rivals;
      }
      
      public function get timer_dayStart() : String
      {
         return timeLeftString(player.titanArenaData.battleStartTs);
      }
      
      public function get timer_dayEnd() : String
      {
         return timeLeftString(player.titanArenaData.nextDayTs);
      }
      
      public function get status_canUpdateDefense() : BooleanProperty
      {
         return _status_canUpdateDefense;
      }
      
      public function get property_stage() : IntProperty
      {
         return _property_stage;
      }
      
      public function get isFinalStage() : Boolean
      {
         return player.titanArenaData.isFinalStage;
      }
      
      public function get place() : uint
      {
         return player.titanArenaData.dailyRewardsData.place;
      }
      
      public function get dailyScore() : uint
      {
         return player.titanArenaData.dailyRewardsData.dailyScore;
      }
      
      public function get weeklyScore() : uint
      {
         return player.titanArenaData.dailyRewardsData.weeklyScore;
      }
      
      public function get firstNotFarmedReward() : PlayerTitanArenaDailyNotFarmedRewardData
      {
         return player.titanArenaData.dailyRewardsData.firstNotFarmedReward;
      }
      
      public function get dailyRewardList() : Vector.<TitanArenaReward>
      {
         return DataStorage.titanArena.getDailyRewardList();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaPopup(this);
         return _popup;
      }
      
      public function action_chest() : void
      {
         new TitanArenaPointsRewardPopupMediator(GameModel.instance.player).open(Stash.click("points_reward",_popup.stashParams));
      }
      
      public function action_rating() : void
      {
         var _loc1_:TitanArenaRatingPopupMediator = new TitanArenaRatingPopupMediator(player);
         _loc1_.open(Stash.click("rating",_popup.stashParams));
      }
      
      public function action_shop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(ShopDescriptionStorage.IDENT_TITAN_ARTIFACT_SHOP);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_rules() : void
      {
         var _loc1_:TitanArenaRulesPopupMediator = new TitanArenaRulesPopupMediator(player);
         _loc1_.open(Stash.click("rules",_popup.stashParams));
      }
      
      public function action_raid() : void
      {
         new TitanArenaRaidStartPopupMediator(player).open(Stash.click("raid",_popup.stashParams));
      }
      
      public function action_defense() : void
      {
         action_defenseTeamWarning_defense();
      }
      
      public function action_select(param1:PlayerTitanArenaEnemy) : void
      {
         if(!playerTeam.length)
         {
            action_defenseTeamWarning_attack();
            return;
         }
         _action_select(param1);
      }
      
      public function action_defenseTeamWarning_attack() : void
      {
         var _loc1_:TitanArenaDefenseWarningPopupMediator = new TitanArenaDefenseWarningPopupMediator(player,Translate.translate("UI_SPECIALOFFER_ATTENTION"),Translate.translate("UI_TITAN_ARENA_WARNING_ATTACK"),Translate.translate("UI_TITAN_ARENA_WARNING_LABEL_ASSEMBLE"));
         _loc1_.open(Stash.click("attack",_popup.stashParams));
         _loc1_.signal_ok.add(handler_defenseWarning_attack_ok);
      }
      
      public function action_defenseTeamWarning_defense() : void
      {
         var _loc1_:TitanArenaDefenseWarningPopupMediator = new TitanArenaDefenseWarningPopupMediator(player,Translate.translate("UI_SPECIALOFFER_ATTENTION"),Translate.translate("UI_TITAN_ARENA_WARNING_ATTACK"),!!playerTeam.length?Translate.translate("UI_TITAN_ARENA_WARNING_LABEL_MODIFY"):Translate.translate("UI_TITAN_ARENA_WARNING_LABEL_ASSEMBLE"));
         _loc1_.open(Stash.click("defense",_popup.stashParams));
         _loc1_.signal_ok.add(handler_defenseWarning_defense_ok);
      }
      
      public function action_checkForNextRound() : void
      {
         if(!status_peace.value)
         {
            player.titanArenaData.action_checkForNextRound();
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
      
      private function _action_select(param1:PlayerTitanArenaEnemy) : void
      {
         var _loc2_:TitanArenaEnemyPopupMediator = new TitanArenaEnemyPopupMediator(player,param1);
         _loc2_.open(Stash.click("enemy",_popup.stashParams));
         _loc2_.signal_attack.add(handler_attack);
      }
      
      private function handler_attack(param1:PlayerTitanArenaEnemy) : void
      {
         var _loc2_:TitanArenaAttackTeamGatherPopupMediator = new TitanArenaAttackTeamGatherPopupMediator(param1,player);
         _loc2_.open(Stash.click("enemy",_popup.stashParams));
         _loc2_.signal_teamGatherComplete.add(handler_attackTeamGatherComplete);
      }
      
      private function handler_getStatus(param1:String) : void
      {
         _status_peace.value = player.titanArenaData.property_status.value == "peace_time";
         _property_playerReady.value = player.titanArenaData.property_status.value == "battle";
         _property_serverDataReady.value = true;
      }
      
      private function handler_attackTeamGatherComplete(param1:TitanArenaAttackTeamGatherPopupMediator) : void
      {
         this._teamGatherPopup = param1;
         var _loc2_:CommandTitanArenaStartBattle = player.titanArenaData.action_startBattle(param1.enemy,param1.descriptionList);
         _loc2_.onClientExecute(handler_startBattle);
      }
      
      private function handler_startBattle(param1:CommandTitanArenaStartBattle) : void
      {
         if(_teamGatherPopup)
         {
            _teamGatherPopup.close();
         }
         _teamGatherPopup = null;
      }
      
      private function handler_defenseWarning_attack_ok() : void
      {
         player.titanArenaData.action_updateDefenders();
      }
      
      private function handler_defenseWarning_defense_ok() : void
      {
         player.titanArenaData.action_updateDefenders();
      }
      
      private function handler_defenderTeamUpdate() : void
      {
         _signal_updateDefenseTeam.dispatch();
      }
      
      private function handler_pointsUpdate(param1:int) : void
      {
         _signal_pointsUpdate.dispatch();
      }
      
      private function handler_enemiesUpdate() : void
      {
         _signal_updateRivals.dispatch();
      }
      
      private function handler_tierUpdate(param1:int) : void
      {
         _property_stage.value = param1;
      }
      
      private function handler_canUpdateDefenders(param1:Boolean) : void
      {
         _status_canUpdateDefense.value = param1;
      }
      
      private function handler_canRaid(param1:Boolean) : void
      {
         _property_canRaid.value = param1;
      }
      
      private function handler_farmReward() : void
      {
         signal_farmReward.dispatch();
      }
   }
}
