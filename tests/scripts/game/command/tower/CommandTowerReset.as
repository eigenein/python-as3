package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandTowerReset extends RPCCommandBase
   {
       
      
      public function CommandTowerReset()
      {
         super();
         rpcRequest = new RpcRequest("towerReset");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
