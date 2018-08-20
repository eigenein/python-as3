package game.command.rpc.clan
{
   import flash.utils.Dictionary;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandClanMemberRemoveFromBlackList extends RPCCommandBase
   {
       
      
      private var ids:Array;
      
      public function CommandClanMemberRemoveFromBlackList(param1:Array)
      {
         super();
         this.ids = param1;
         rpcRequest = new RpcRequest("clanRemoveFromBlackList");
         rpcRequest.writeParam("ids",param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         _loc2_ = 0;
         while(_loc2_ < ids.length)
         {
            _loc3_ = param1.clan.clan.blackList.list;
            delete _loc3_[ids[_loc2_]];
            _loc2_++;
         }
         param1.clan.clan.blackList.signal_blackListUpdate.dispatch();
         super.clientExecute(param1);
      }
   }
}
