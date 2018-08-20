package com.progrestar.common.new_rpc
{
   public class RpcRequestBase implements IrpcRequest
   {
       
      
      protected var _bodies:Array;
      
      private var _names:Array;
      
      public function RpcRequestBase(param1:String = null, param2:String = null)
      {
         super();
         _bodies = [];
         _names = [];
         if(param1 != null)
         {
            if(param2 == null)
            {
               param2 = "body";
            }
            addBody(param1,param2,{});
         }
      }
      
      public function get name() : String
      {
         return _bodies[0]["name"];
      }
      
      public function set name(param1:String) : void
      {
         _bodies[0]["name"] = param1;
      }
      
      public function get names() : Array
      {
         return _names;
      }
      
      public function get body() : Object
      {
         return _bodies[0]["args"];
      }
      
      public function set body(param1:Object) : void
      {
         _bodies[0]["args"] = param1;
      }
      
      public function get ident() : String
      {
         return _bodies[0]["ident"];
      }
      
      public function set ident(param1:String) : void
      {
         _bodies[0]["ident"] = param1;
      }
      
      public function getFormattedData() : Object
      {
         return JSON.stringify(getData());
      }
      
      public function getData() : Object
      {
         return {"calls":_bodies};
      }
      
      public function writeParam(param1:String, param2:*) : void
      {
         body[param1] = param2;
      }
      
      public function writeRequest(param1:RpcRequestBase, param2:String = null) : void
      {
         addBody(param1.name,param2,param1.body);
      }
      
      public function concatRpcRequest(param1:RpcRequestBase, param2:String = "") : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1._bodies.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            addBody(param1._bodies[_loc4_]["name"],param2 + param1._bodies[_loc4_]["ident"],param1._bodies[_loc4_]["args"]);
            _loc4_++;
         }
      }
      
      protected function addBody(param1:String, param2:String, param3:Object) : void
      {
         _bodies.push({
            "name":param1,
            "args":param3,
            "ident":param2
         });
         _names.push(param1);
      }
   }
}
