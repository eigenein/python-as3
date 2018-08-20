package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandBundleGetAllAvailableId extends RPCCommandBase
   {
       
      
      private var minIdIndex:int;
      
      private var ids:Array;
      
      public function CommandBundleGetAllAvailableId()
      {
         super();
         rpcRequest = new RpcRequest("bundleGetAllAvailableId");
      }
      
      public function getBundleIdIndex(param1:int) : int
      {
         var _loc2_:int = ids.indexOf(param1) - minIdIndex;
         if(_loc2_ < 0)
         {
            _loc2_ = _loc2_ + ids.length;
         }
         return _loc2_;
      }
      
      public function getCount() : int
      {
         return ids.length;
      }
      
      override protected function successHandler() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
