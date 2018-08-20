package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class CommandInventorySell extends CostCommand
   {
       
      
      private var item:InventoryItemDescription;
      
      private var amount:int;
      
      private var fragment:Boolean;
      
      public function CommandInventorySell(param1:InventoryItemDescription, param2:int, param3:Boolean)
      {
         super();
         this.fragment = param3;
         this.amount = param2;
         this.item = param1;
         rpcRequest = new RpcRequest("inventorySell");
         rpcRequest.writeParam("type",param1.type.type);
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         rpcRequest.writeParam("fragment",param3);
         _cost = new CostData();
         _reward = new RewardData();
         if(param3)
         {
            _cost.fragmentCollection.addItem(param1,param2);
            _reward = param1.fragmentSellCost.clone() as RewardData;
            _reward.multiply(param2);
         }
         else
         {
            _cost.inventoryCollection.addItem(param1,param2);
            _reward = param1.sellCost.clone() as RewardData;
            _reward.multiply(param2);
         }
      }
   }
}
