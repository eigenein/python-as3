package game.mechanics.titan_arena.mediator.reward
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.data.storage.titanarenaleague.TitanArenaTournamentReward;
   import game.mechanics.titan_arena.model.PlayerTitanArenaDailyNotFarmedRewardData;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaFarmDailyReward;
   import game.mechanics.titan_arena.popup.reward.TitanArenaPointsRewardPopup;
   import game.mechanics.titan_arena.popup.reward.TitanArenaRewardFarmPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.titanarena.TitanArenaRulesPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.reward.multi.MultiRewardGroupedPopup;
   
   public class TitanArenaPointsRewardPopupMediator extends PopupMediator
   {
       
      
      public function TitanArenaPointsRewardPopupMediator(param1:Player)
      {
         super(param1);
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
      
      public function get totalNotFarmedReward() : RewardData
      {
         var _loc2_:int = 0;
         var _loc1_:RewardData = new RewardData();
         if(player.titanArenaData.dailyRewardsData.notFarmedRewards && player.titanArenaData.dailyRewardsData.notFarmedRewards.length)
         {
            _loc2_ = 0;
            while(_loc2_ < player.titanArenaData.dailyRewardsData.notFarmedRewards.length)
            {
               _loc1_.add(player.titanArenaData.dailyRewardsData.notFarmedRewards[_loc2_].reward);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get dailyRewardList() : Vector.<TitanArenaReward>
      {
         return DataStorage.titanArena.getDailyRewardList();
      }
      
      public function get victoryRewardList() : Vector.<TitanArenaReward>
      {
         return DataStorage.titanArena.getVictoryRewardList();
      }
      
      public function get tournamentRewardList() : Vector.<TitanArenaTournamentReward>
      {
         return DataStorage.titanArena.getTournamentRewardList();
      }
      
      public function get timer_dayEnd() : String
      {
         return timeLeftString(player.titanArenaData.nextDayTs);
      }
      
      public function get timer_weekEnd() : String
      {
         return timeLeftString(player.titanArenaData.weekEndTs);
      }
      
      public function get string_status() : String
      {
         if(player.titanArenaData.property_status.value == "battle" || "not_prepared")
         {
            return Translate.translateArgs("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_TOURNAMENT_TIME",timer_weekEnd) + "\n" + Translate.translateArgs("UI_TITAN_ARENA_DEFENSE_UI_TF_LABEL_STATUS",timer_dayEnd);
         }
         return "";
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_arena"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("titan_token"));
         _loc1_.requre_consumable(DataStorage.consumable.getById(53) as ConsumableDescription);
         _loc1_.requre_starmoney();
         _loc1_.requre_gold();
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaPointsRewardPopup(this);
         return _popup;
      }
      
      public function action_farmDailyReward() : void
      {
         var _loc1_:* = null;
         if(firstNotFarmedReward)
         {
            _loc1_ = GameModel.instance.actionManager.titanArena.titanArenaFarmDailyReward();
            _loc1_.signal_complete.add(handler_farmDailyReward);
            close();
         }
      }
      
      public function action_rules_points() : void
      {
         var _loc1_:TitanArenaRulesPopupMediator = new TitanArenaRulesPopupMediator(player,"TAB_POINTS");
         _loc1_.open(Stash.click("rules",_popup.stashParams));
      }
      
      public function action_rules_cups() : void
      {
         var _loc1_:TitanArenaRulesPopupMediator = new TitanArenaRulesPopupMediator(player,"TAB_CUPS");
         _loc1_.open(Stash.click("rules",_popup.stashParams));
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
      
      private function handler_farmDailyReward(param1:CommandTitanArenaFarmDailyReward) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1.farmedRewards)
         {
            if(param1.farmedRewards.length == 1)
            {
               _loc2_ = new TitanArenaRewardFarmPopup(param1.farmedRewards[0]);
               _loc2_.stashSourceClick = _popup.stashParams;
               PopUpManager.addPopUp(_loc2_);
            }
            else
            {
               _loc3_ = new TitanArenaRewardValueObjectList(param1.farmedRewards);
               _loc4_ = new MultiRewardGroupedPopup(_loc3_,null);
               PopUpManager.addPopUp(_loc4_);
            }
         }
      }
   }
}
