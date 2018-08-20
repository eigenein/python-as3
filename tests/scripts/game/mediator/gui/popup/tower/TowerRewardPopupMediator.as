package game.mediator.gui.popup.tower
{
   import feathers.core.PopUpManager;
   import game.command.tower.CommandTowerEndBattle;
   import game.mediator.gui.component.RewardPopupStarAnimator;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.fightresult.pve.TowerRewardPopup;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   
   public class TowerRewardPopupMediator extends PopupMediator
   {
       
      
      private var result:TowerBattleResultValueObject;
      
      private var starTimer:RewardPopupStarAnimator;
      
      private var _reward_pointsTotal:int;
      
      private var _reward_skullsTotal:int;
      
      private var _reward_starCount:int;
      
      public function TowerRewardPopupMediator(param1:Player, param2:CommandTowerEndBattle = null)
      {
         super(param1);
         if(param2)
         {
            result = param2.commandResult;
            _reward_pointsTotal = param2.towerPoint;
            _reward_skullsTotal = param2.reward.inventoryCollection.getItemCount(param1.tower.skullCoin);
            _reward_starCount = result.stars;
         }
         else
         {
            result = null;
            _reward_pointsTotal = 0;
            _reward_skullsTotal = 0;
            _reward_starCount = 3;
         }
         starTimer = new RewardPopupStarAnimator(400,reward_starCount);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         starTimer.dispose();
      }
      
      public function get signal_starAnimation() : Signal
      {
         return starTimer.signal_onElement;
      }
      
      public function get reward_pointsBase() : int
      {
         return _reward_pointsTotal / _reward_starCount;
      }
      
      public function get reward_skullsBase() : int
      {
         return _reward_skullsTotal / _reward_starCount;
      }
      
      public function get reward_pointsTotal() : int
      {
         return _reward_pointsTotal;
      }
      
      public function get reward_skullsTotal() : int
      {
         return _reward_skullsTotal;
      }
      
      public function get reward_starCount() : int
      {
         return _reward_starCount;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerRewardPopup(this);
         return _popup;
      }
      
      public function action_showStats() : void
      {
         PopUpManager.addPopUp(new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats));
      }
      
      public function action_animateStars() : void
      {
         starTimer.start();
      }
   }
}
