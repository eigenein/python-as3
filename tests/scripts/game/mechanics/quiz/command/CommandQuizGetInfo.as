package game.mechanics.quiz.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.enum.RpcCommandName;
   import game.model.GameModel;
   
   public class CommandQuizGetInfo extends RPCCommandBase
   {
       
      
      public function CommandQuizGetInfo()
      {
         super();
         rpcRequest = new RpcRequest(RpcCommandName.QUIZ_GET_INFO);
         rpcRequest.writeParam("locale",GameModel.instance.context.locale.id);
      }
   }
}
