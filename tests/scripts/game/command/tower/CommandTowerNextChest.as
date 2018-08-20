package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandTowerNextChest extends RPCCommandBase
   {
       
      
      public function CommandTowerNextChest()
      {
         super();
         rpcRequest = new RpcRequest("towerNextChest");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.tower.parseNewState(result.body);
      }
   }
}
