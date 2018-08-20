package com.progrestar.common.new_rpc
{
   public class RPCClientInitializerParams
   {
       
      
      public var url:String = "";
      
      public var auth_key:String = "";
      
      public var network_ident:String;
      
      public var application_id:String;
      
      public var user_id:String = "";
      
      public var player_id:String = "";
      
      public var client_session_key:String = "";
      
      public var network_session_key:String = "";
      
      public var log_api_url:String = "";
      
      public var log_secret:String = "";
      
      public var log_errors:Boolean;
      
      public var log_client_errors:Boolean;
      
      public var referrer_type:String;
      
      public function RPCClientInitializerParams()
      {
         super();
      }
      
      public function readPlayerId() : String
      {
         return null;
      }
      
      public function writePlayerId(param1:String) : void
      {
      }
   }
}
