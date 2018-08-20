package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandTowerNextFloor extends RPCCommandBase
   {
       
      
      public function CommandTowerNextFloor()
      {
         super();
         rpcRequest = new RpcRequest("towerNextFloor");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.tower.parseNewState(result.body);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
