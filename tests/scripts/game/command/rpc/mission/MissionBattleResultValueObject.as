package game.command.rpc.mission
{
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   
   public class MissionBattleResultValueObject extends BattleResultValueObject
   {
       
      
      public var reward:RewardData;
      
      public function MissionBattleResultValueObject()
      {
         super();
      }
   }
}
