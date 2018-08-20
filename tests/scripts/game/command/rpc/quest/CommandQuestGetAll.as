package game.command.rpc.quest
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandQuestGetAll extends RPCCommandBase
   {
       
      
      public function CommandQuestGetAll()
      {
         super();
         rpcRequest = new RpcRequest("questGetAll");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.questData.reset(result.body as Array);
      }
   }
}
