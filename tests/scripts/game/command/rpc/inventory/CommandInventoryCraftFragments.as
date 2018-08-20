package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class CommandInventoryCraftFragments extends CostCommand
   {
       
      
      private var item:InventoryItemDescription;
      
      private var amount:int;
      
      public function CommandInventoryCraftFragments(param1:InventoryItemDescription, param2:int = 1)
      {
         super();
         this.amount = param2;
         this.item = param1;
         rpcRequest = new RpcRequest("inventoryCraftFragments");
         rpcRequest.writeParam("type",param1.type.type);
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         _cost = param1.fragmentMergeCost.clone() as CostData;
         _cost.multiply(param2);
         _reward = new RewardData();
         _reward.inventoryCollection.addItem(param1,param2);
      }
   }
}
