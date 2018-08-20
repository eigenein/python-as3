package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanIsTitleUnique extends RPCCommandBase
   {
       
      
      public function CommandClanIsTitleUnique(param1:String)
      {
         super();
         rpcRequest = new RpcRequest("clanIsTitleUnique");
         rpcRequest.writeParam("title",param1);
      }
   }
}
