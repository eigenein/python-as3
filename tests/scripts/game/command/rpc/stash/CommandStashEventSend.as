package game.command.rpc.stash
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandStashEventSend extends RPCCommandBase
   {
       
      
      public function CommandStashEventSend(param1:Vector.<StashEventDescription>)
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super();
         isImmediate = false;
         rpcRequest = new RpcRequest("stashClient");
         var _loc3_:Array = [];
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = param1[_loc4_];
            _loc3_.push({
               "type":_loc5_.type,
               "params":_loc5_.paramsSerialized
            });
            _loc4_++;
         }
         rpcRequest.writeParam("data",_loc3_);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
      }
   }
}
