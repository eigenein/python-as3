package game.command.rpc.ny
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandNYGetInfo extends RPCCommandBase
   {
       
      
      private var resultData:Object;
      
      public function CommandNYGetInfo()
      {
         super();
         rpcRequest = new RpcRequest("newYearGetInfo");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.ny.update(resultData);
      }
      
      override protected function successHandler() : void
      {
         resultData = result.body;
         super.successHandler();
      }
   }
}
