package game.model.user.refillable
{
   import game.command.rpc.refillable.AlchemyRewardValueObject;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   
   public class PlayerAlchemyRefillableEntry extends PlayerRefillableEntry
   {
       
      
      private var _sessionRewards:Vector.<AlchemyRewardValueObject>;
      
      public function PlayerAlchemyRefillableEntry(param1:Object, param2:RefillableDescription, param3:PlayerRefillableVIPSource)
      {
         _sessionRewards = new Vector.<AlchemyRewardValueObject>();
         super(param1,param2,param3);
      }
      
      override public function get refillCost() : CostData
      {
         return DataStorage.level.getAlchemyLevel(refillCount + 1).cost;
      }
      
      public function getCostForAttempt(param1:int) : CostData
      {
         return DataStorage.level.getAlchemyLevel(param1).cost;
      }
      
      public function addRewards(param1:Vector.<AlchemyRewardValueObject>) : void
      {
         _sessionRewards = param1.concat().reverse().concat(_sessionRewards);
      }
      
      public function get sessionRewards() : Vector.<AlchemyRewardValueObject>
      {
         return _sessionRewards;
      }
   }
}
