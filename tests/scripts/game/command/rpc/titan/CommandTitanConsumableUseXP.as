package game.command.rpc.titan
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class CommandTitanConsumableUseXP extends CostCommand
   {
       
      
      private var titan:PlayerTitanEntry;
      
      private var consumable:ConsumableDescription;
      
      private var amount:int;
      
      public function CommandTitanConsumableUseXP(param1:PlayerTitanEntry, param2:ConsumableDescription, param3:int)
      {
         super();
         this.amount = param3;
         isImmediate = false;
         this.consumable = param2;
         this.titan = param1;
         rpcRequest = new RpcRequest("consumableUseTitanXp");
         rpcRequest.writeParam("titanId",param1.titan.id);
         rpcRequest.writeParam("libId",param2.id);
         rpcRequest.writeParam("amount",param3);
         _cost = new CostData();
         _cost.addInventoryItem(param2,param3);
         _reward = new RewardData();
         _reward.addTitanXp(param1.titan,param2.rewardAmount * param3);
         _reward.addInventoryItem(DataStorage.consumable.getTitanSparkDesc(),param1.getPowerNext(true) - param1.getPower());
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:CommandRequirement = super.prerequisiteCheck(param1);
         var _loc3_:int = param1.titans.getMaxTitanExp();
         if(titan.experience > _loc3_)
         {
            _loc2_.invalid = true;
         }
         return _loc2_;
      }
   }
}
