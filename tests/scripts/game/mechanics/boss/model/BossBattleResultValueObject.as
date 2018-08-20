package game.mechanics.boss.model
{
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   
   public class BossBattleResultValueObject extends BattleResultValueObject
   {
       
      
      private var _bossLevel:int;
      
      public var firstWinReward:RewardData;
      
      public var everyWinReward:RewardData;
      
      public function BossBattleResultValueObject(param1:int)
      {
         super();
         this._bossLevel = param1;
      }
      
      public function get bossLevel() : int
      {
         return _bossLevel;
      }
   }
}
