package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandTowerGetInfo extends RPCCommandBase
   {
       
      
      public function CommandTowerGetInfo()
      {
         super();
         rpcRequest = new RpcRequest("towerGetInfo");
      }
   }
}
