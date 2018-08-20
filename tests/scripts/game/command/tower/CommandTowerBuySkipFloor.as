package game.command.tower
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   
   public class CommandTowerBuySkipFloor extends CostCommand
   {
       
      
      public function CommandTowerBuySkipFloor(param1:CostData)
      {
         super();
         rpcRequest = new RpcRequest("towerBuySkip");
         _cost = param1;
      }
   }
}
