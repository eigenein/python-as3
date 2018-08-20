package game.command.rpc.mail
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandMailGet extends RPCCommandBase
   {
       
      
      public function CommandMailGet()
      {
         super();
         rpcRequest = new RpcRequest("mailGetAll");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.mail.update(result.body);
      }
   }
}
