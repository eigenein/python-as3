package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandClanSendGifts extends RPCCommandBase
   {
       
      
      public function CommandClanSendGifts(param1:Vector.<String>)
      {
         var _loc4_:int = 0;
         super();
         var _loc3_:Array = [];
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(param1[_loc4_]);
            _loc4_++;
         }
         rpcRequest = new RpcRequest("clanSendGifts");
         rpcRequest.writeParam("ids",_loc3_);
      }
   }
}
