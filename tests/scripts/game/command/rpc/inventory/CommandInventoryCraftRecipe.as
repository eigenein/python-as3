package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.gear.GearItemDescription;
   
   public class CommandInventoryCraftRecipe extends CostCommand
   {
       
      
      private var item:GearItemDescription;
      
      private var amount:int;
      
      public function CommandInventoryCraftRecipe(param1:GearItemDescription, param2:int)
      {
         super();
         this.amount = param2;
         this.item = param1;
         rpcRequest = new RpcRequest("inventoryCraftRecipe");
         rpcRequest.writeParam("type",param1.type.type);
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         _cost = param1.craftRecipe.clone() as CostData;
         _cost.multiply(param2);
         _reward = new RewardData();
         _reward.inventoryCollection.addItem(param1,param2);
      }
   }
}
