package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanFind extends RPCCommandBase
   {
       
      
      public function CommandClanFind(param1:int = -1, param2:int = -1, param3:Boolean = true)
      {
         super();
         rpcRequest = new RpcRequest("clanFind");
         if(param1 != -1)
         {
            rpcRequest.writeParam("country",param1);
         }
         if(param2 != -1)
         {
            rpcRequest.writeParam("offset",param2);
         }
         rpcRequest.writeParam("active",param3);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
