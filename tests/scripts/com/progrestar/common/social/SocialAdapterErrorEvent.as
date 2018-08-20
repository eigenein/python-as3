package com.progrestar.common.social
{
   import flash.events.Event;
   
   public class SocialAdapterErrorEvent extends Event
   {
      
      public static const SOCIAL_NETWORK_API_ERROR:String = "socialNetworkApiError";
       
      
      private var _request:String;
      
      private var _response:Object;
      
      public function SocialAdapterErrorEvent(param1:String, param2:String, param3:Object)
      {
         super(param1);
         _request = param2;
         _response = param3;
      }
      
      public function get request() : String
      {
         return _request;
      }
      
      public function get response() : Object
      {
         return _response;
      }
   }
}
