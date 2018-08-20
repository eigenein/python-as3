package game.mechanics.titan_arena.mediator
{
   import feathers.core.PopUpManager;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndBattle;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class TitanArenaRoundEndPopupMeditatorBase extends PopupMediator
   {
      
      public static const STATE_REWARD:int = 1;
      
      public static const STATE_REWARD_IMPROVE:int = 2;
      
      public static const STATE_NO_REWARD:int = 3;
       
      
      public const signal_closed:Signal = new Signal();
      
      protected var _cmd:CommandTitanArenaEndBattle;
      
      private var _roundResult:TitanArenaRoundResultValueObject;
      
      protected var _user_me:UserInfo;
      
      protected var _user_them:PlayerTitanArenaEnemy;
      
      private var _reward:RewardData;
      
      private var _reward_attackPoints:InventoryItem;
      
      private var _reward_defensePoints:InventoryItem;
      
      private var _state:int;
      
      public function TitanArenaRoundEndPopupMeditatorBase(param1:Player, param2:CommandTitanArenaEndBattle)
      {
         super(param1);
         this._cmd = param2;
         _user_me = param1.getUserInfo();
         _user_them = param2.enemy;
         _roundResult = param2.result_attack;
         _reward = param2.reward;
         if(param2.pointsEarned_attack == 0)
         {
            _state = 3;
         }
         else
         {
            _reward_attackPoints = new InventoryItem(DataStorage.pseudo.TITAN_TOURNAMENT_POINT,param2.pointsEarned_attack);
            if(param2.pointsEarned_attack == param2.pointsEarned_attack_total)
            {
               _state = 1;
            }
            else
            {
               _state = 2;
            }
         }
         if(param2.pointsEarned_defense)
         {
            _reward_defensePoints = new InventoryItem(DataStorage.pseudo.TITAN_TOURNAMENT_POINT,param2.pointsEarned_defense);
         }
      }
      
      override public function close() : void
      {
         super.close();
         signal_closed.dispatch();
      }
      
      public function get cmd() : CommandTitanArenaEndBattle
      {
         return _cmd;
      }
      
      public function get roundResult() : TitanArenaRoundResultValueObject
      {
         return _roundResult;
      }
      
      public function get user_me() : UserInfo
      {
         return _user_me;
      }
      
      public function get user_them() : PlayerTitanArenaEnemy
      {
         return _user_them;
      }
      
      public function get victory() : Boolean
      {
         return _cmd.victory;
      }
      
      public function get pointsEarned() : int
      {
         return _cmd.pointsEarned_attack;
      }
      
      public function get pointsTotal() : int
      {
         return _cmd.enemy.property_points.value;
      }
      
      public function get pointsResultImproved() : Boolean
      {
         return pointsEarned != pointsTotal;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get reward_attackPoints() : InventoryItem
      {
         return _reward_attackPoints;
      }
      
      public function get reward_defensePoints() : InventoryItem
      {
         return _reward_defensePoints;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function action_showStats() : void
      {
         var _loc1_:BattleStatisticsPopup = new BattleStatisticsPopup(cmd.battleResultValueObject.attackerTeamStats,cmd.battleResultValueObject.defenderTeamStats);
         _loc1_.addEventListener("removed",handler_statisticsPopupRemoved);
         PopUpManager.addPopUp(_loc1_);
         Game.instance.screen.hideNotDisposedBattle();
      }
      
      private function handler_statisticsPopupRemoved(param1:Event) : void
      {
         Game.instance.screen.showNotDisposedBattle();
      }
   }
}
