package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandInventoryExchangeTitanStones extends CostCommand
   {
       
      
      public function CommandInventoryExchangeTitanStones()
      {
         super();
         rpcRequest = new RpcRequest("inventoryExchangeTitanStones");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _cost = new CostData(result.body.cost);
         _reward = new RewardData(result.body.reward);
         super.clientExecute(param1);
      }
   }
}
