package game.command.rpc
{
   import com.progrestar.common.new_rpc.RpcResponseBase;
   
   public class RpcResponse extends RpcResponseBase
   {
       
      
      public function RpcResponse(param1:String)
      {
         super(param1);
      }
      
      public function get session() : Object
      {
         return _body["session"];
      }
      
      public function get errorRequestIdent() : String
      {
         var _loc1_:String = null;
         var _loc2_:Object = error;
         if(_loc2_ != null && _loc2_.hasOwnProperty("call"))
         {
            _loc1_ = _loc2_["call"]["ident"];
         }
         return _loc1_;
      }
   }
}
