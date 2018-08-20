package game.command.rpc
{
   import com.progrestar.common.new_rpc.RpcRequestBase;
   
   public class RpcRequest extends RpcRequestBase
   {
      
      public static const IGNORE_ERROR_FLAG:uint = 1;
      
      public static const CRITICAL_ERROR_FLAG:uint = 2;
       
      
      private var _flagsByIdent:Object;
      
      public function RpcRequest(param1:String = null, param2:String = null)
      {
         _flagsByIdent = {};
         super(param1,param2);
      }
      
      public function get ignoreErrors() : Boolean
      {
         return isSubRequestFlaggedAsIgnoreErrors(ident);
      }
      
      public function set ignoreErrors(param1:Boolean) : void
      {
         var _loc2_:uint = getFlagsByIdent(ident);
         _flagsByIdent[ident] = _loc2_ | 1;
      }
      
      public function get critialError() : Boolean
      {
         return isSubRequestFlaggedAsCriticalError(ident);
      }
      
      public function set critialError(param1:Boolean) : void
      {
         var _loc2_:uint = getFlagsByIdent(ident);
         _flagsByIdent[ident] = _loc2_ | 2;
      }
      
      public function isSubRequestFlaggedAsIgnoreErrors(param1:String) : Boolean
      {
         return (getFlagsByIdent(param1) & 1) != 0;
      }
      
      public function isSubRequestFlaggedAsCriticalError(param1:String) : Boolean
      {
         return (getFlagsByIdent(param1) & 2) != 0;
      }
      
      public function getFlagsByIdent(param1:String) : uint
      {
         return !!_flagsByIdent.hasOwnProperty(param1)?_flagsByIdent[param1]:0;
      }
      
      override public function writeRequest(param1:RpcRequestBase, param2:String = null) : void
      {
         if(!param2)
         {
            param2 = param1.name;
         }
         super.writeRequest(param1,param2);
         var _loc3_:RpcRequest = param1 as RpcRequest;
         if(_loc3_ != null)
         {
            _flagsByIdent[param2] = _loc3_.getFlagsByIdent(_loc3_.ident);
         }
      }
      
      override public function concatRpcRequest(param1:RpcRequestBase, param2:String = "") : void
      {
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = 0;
         var _loc3_:RpcRequest = param1 as RpcRequest;
         if(_loc3_ == null)
         {
            super.concatRpcRequest(param1,param2);
            return;
         }
         var _loc5_:int = _loc3_._bodies.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc3_._bodies[_loc7_];
            _loc4_ = _loc8_["ident"];
            _loc9_ = param2 + _loc4_;
            addBody(_loc8_["name"],_loc9_,_loc8_["args"]);
            _loc6_ = uint(_loc3_.getFlagsByIdent(_loc4_));
            if(_loc6_ > 0)
            {
               _flagsByIdent[_loc9_] = _loc6_;
            }
            _loc7_++;
         }
      }
      
      override public function getData() : Object
      {
         var _loc4_:* = undefined;
         var _loc3_:int = 0;
         var _loc2_:Object = super.getData();
         var _loc1_:Array = _loc2_["calls"];
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_]["args"];
            if(_loc4_ is Function)
            {
               _loc1_[_loc3_]["args"] = _loc4_();
            }
            _loc3_++;
         }
         _loc2_["session"] = RpcClient.sessionData;
         return _loc2_;
      }
   }
}
