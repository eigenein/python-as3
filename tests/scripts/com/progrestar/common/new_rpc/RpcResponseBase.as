package com.progrestar.common.new_rpc
{
   import flash.utils.getTimer;
   
   public class RpcResponseBase
   {
      
      public static const INVALID_SIGNATURE:String = "invalid_signature";
      
      public static const INVALID_SIGNATURE_SERVER:String = "Invalid signature";
      
      public static const INVALID_SESSION:String = "common\\rpc\\exception\\InvalidSession";
       
      
      protected var _body:Object;
      
      protected var _timestamp:int;
      
      public function RpcResponseBase(param1:String)
      {
         super();
         createBody(param1);
         _timestamp = getTimer();
      }
      
      protected function createBody(param1:String) : void
      {
         if(param1 != "Invalid signature")
         {
            try
            {
               this._body = JSON.parse(param1);
            }
            catch(e:Error)
            {
               this._body = {"error":{
                  "name":"invalid_signature",
                  "description":e.message
               }};
            }
         }
         else
         {
            this._body = {"error":{
               "name":"Invalid signature",
               "description":""
            }};
         }
         if(this._body == null)
         {
            this._body = {};
         }
      }
      
      public function get formattedResults() : Object
      {
         var _loc2_:int = 0;
         if(_body == null)
         {
            return {};
         }
         var _loc3_:Array = results as Array;
         if(_loc3_ == null)
         {
            return {};
         }
         var _loc1_:Object = {};
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_[_loc3_[_loc2_]["ident"]] = _loc3_[_loc2_]["result"];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get body() : Object
      {
         return _body;
      }
      
      public function get date() : Number
      {
         return !!_body.date?body.date:0;
      }
      
      public function get error() : Object
      {
         if(!_body || !_body.hasOwnProperty("error"))
         {
            return null;
         }
         return _body["error"];
      }
      
      public function get results() : Object
      {
         return _body["results"];
      }
      
      public function get timestamp() : int
      {
         return _timestamp;
      }
   }
}
