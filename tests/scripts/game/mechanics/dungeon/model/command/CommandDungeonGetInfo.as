package game.mechanics.dungeon.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandDungeonGetInfo extends RPCCommandBase
   {
       
      
      public function CommandDungeonGetInfo()
      {
         super();
         rpcRequest = new RpcRequest("dungeonGetInfo");
      }
   }
}
