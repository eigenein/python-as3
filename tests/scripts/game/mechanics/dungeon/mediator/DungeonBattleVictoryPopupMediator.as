package game.mechanics.dungeon.mediator
{
   import game.mechanics.dungeon.model.command.CommandDungeonEndBattle;
   import game.mechanics.dungeon.popup.battle.DungeonBattleVictoryPopup;
   import game.mediator.gui.component.RewardPopupStarAnimator;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class DungeonBattleVictoryPopupMediator extends PopupMediator
   {
       
      
      private var cmd:CommandDungeonEndBattle;
      
      private var starTimer:RewardPopupStarAnimator;
      
      private var _signal_complete:Signal;
      
      private var _result:DungeonBattleResultValueObject;
      
      private var _itemRewardList:Vector.<InventoryItem>;
      
      private var _reward_starCount:int;
      
      public const signal_closed:Signal = new Signal();
      
      public function DungeonBattleVictoryPopupMediator(param1:Player, param2:CommandDungeonEndBattle = null)
      {
         _signal_complete = new Signal(CommandDungeonEndBattle);
         super(param1);
         this.cmd = param2;
         if(param2)
         {
            _result = param2.commandResult;
            _reward_starCount = result.stars;
            _itemRewardList = param2.reward.outputDisplay;
         }
         else
         {
            _result = null;
            _reward_starCount = 3;
            _itemRewardList = new Vector.<InventoryItem>();
         }
         starTimer = new RewardPopupStarAnimator(400,reward_starCount);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _signal_complete.dispatch(cmd);
         cmd = null;
      }
      
      public function get rewardMultiplier() : int
      {
         return cmd.rewardMultiplier;
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      public function get result() : DungeonBattleResultValueObject
      {
         return _result;
      }
      
      public function get itemRewardList() : Vector.<InventoryItem>
      {
         return _itemRewardList;
      }
      
      public function get reward_starCount() : int
      {
         return _reward_starCount;
      }
      
      public function get signal_starAnimation() : Signal
      {
         return starTimer.signal_onElement;
      }
      
      public function action_animateStars() : void
      {
         starTimer.start();
      }
      
      public function action_showStats() : void
      {
         var _loc1_:BattleStatisticsPopup = new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats);
         _loc1_.addEventListener("removed",handler_statisticsPopupRemoved);
         _loc1_.open();
         Game.instance.screen.hideNotDisposedBattle();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonBattleVictoryPopup(this);
         return _popup;
      }
      
      override public function close() : void
      {
         super.close();
         signal_closed.dispatch();
      }
      
      private function handler_statisticsPopupRemoved(param1:Event) : void
      {
         Game.instance.screen.showNotDisposedBattle();
      }
   }
}
