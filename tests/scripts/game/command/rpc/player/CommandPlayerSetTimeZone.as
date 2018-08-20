package game.command.rpc.player
{
   import engine.context.GameContext;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandPlayerSetTimeZone extends RPCCommandBase
   {
       
      
      private var newValue:int;
      
      public function CommandPlayerSetTimeZone(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("setTimeZone");
         rpcRequest.writeParam("timeZone",param1);
         this.newValue = param1;
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
         GameContext.instance.reloadGame();
      }
   }
}
