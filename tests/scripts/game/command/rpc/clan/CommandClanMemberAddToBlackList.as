package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanMemberAddToBlackList extends RPCCommandBase
   {
       
      
      private var ids:Array;
      
      public function CommandClanMemberAddToBlackList(param1:Array)
      {
         super();
         this.ids = param1;
         rpcRequest = new RpcRequest("clanAddToBlackList");
         rpcRequest.writeParam("ids",param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < ids.length)
         {
            param1.clan.clan.blackList.list[ids[_loc2_]] = 0;
            _loc2_++;
         }
         param1.clan.clan.blackList.signal_blackListUpdate.dispatch();
         super.clientExecute(param1);
      }
   }
}
