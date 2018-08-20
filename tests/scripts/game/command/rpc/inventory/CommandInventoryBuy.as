package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class CommandInventoryBuy extends CostCommand
   {
       
      
      private var item:InventoryItemDescription;
      
      private var amount:int;
      
      private var fragment:Boolean;
      
      public function CommandInventoryBuy(param1:InventoryItemDescription, param2:int, param3:Boolean)
      {
         super();
         this.fragment = param3;
         this.amount = param2;
         this.item = param1;
         rpcRequest = new RpcRequest("inventoryBuy");
         rpcRequest.writeParam("type",param1.type.type);
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         rpcRequest.writeParam("fragment",param3);
         _cost = param1.buyCost;
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData();
         if(fragment)
         {
            _reward.fragmentCollection.addItem(item,amount);
         }
         else
         {
            _reward.inventoryCollection.addItem(item,amount);
         }
         super.successHandler();
      }
   }
}
