package game.command.rpc.ny
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandNYGiftGet extends RPCCommandBase
   {
      
      public static const RECEIVED:uint = 0;
      
      public static const SENDED:uint = 1;
       
      
      public var requestType:uint;
      
      public function CommandNYGiftGet(param1:uint)
      {
         super();
         requestType = param1;
         rpcRequest = new RpcRequest("newYearGiftGet");
         rpcRequest.writeParam("type",param1);
      }
   }
}
