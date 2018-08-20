package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class CommandInventoryUseStamina extends CostCommand
   {
       
      
      private var item:InventoryItemDescription;
      
      private var amount:int;
      
      public function CommandInventoryUseStamina(param1:ConsumableDescription, param2:int)
      {
         super();
         this.amount = param2;
         this.item = param1;
         rpcRequest = new RpcRequest("consumableUseStamina");
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         _cost = new CostData();
         _reward = new RewardData();
         _cost.inventoryCollection.addItem(param1,param2);
         _reward.stamina = param1.rewardAmount * param2;
      }
   }
}
