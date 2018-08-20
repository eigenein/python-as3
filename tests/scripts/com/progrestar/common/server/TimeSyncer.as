package com.progrestar.common.server
{
   import com.progrestar.common.social.SocialAdapter;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class TimeSyncer
   {
      
      private static var delay:Number;
       
      
      private var url:String;
      
      private var totalRequestsAmount:int;
      
      private var iteration:int;
      
      private var requestSentTime:Number;
      
      private var prevRequestTime:Number;
      
      private var minPrevRequestTime:Number;
      
      private var minRequestInterval:Number;
      
      private var minServerTime:Number;
      
      private var statLoader:URLLoader;
      
      public function TimeSyncer(param1:String, param2:int = 3)
      {
         super();
         url = param1;
         totalRequestsAmount = param2;
         createLoader();
         sendRequest();
      }
      
      public static function get serverTime() : Number
      {
         var _loc1_:* = null;
         var _loc3_:Number = NaN;
         var _loc2_:* = 0;
         if(delay)
         {
            _loc1_ = new Date();
            _loc3_ = _loc1_.getTime() / 1000;
            _loc2_ = Number(_loc3_ + delay);
         }
         return _loc2_;
      }
      
      private function createLoader() : void
      {
         statLoader = new URLLoader();
         statLoader.addEventListener("complete",onComplete);
         statLoader.addEventListener("ioError",onError);
         statLoader.addEventListener("securityError",onError);
      }
      
      private function removeLoader() : void
      {
         statLoader.removeEventListener("complete",onComplete);
         statLoader.removeEventListener("ioError",onError);
         statLoader.removeEventListener("securityError",onError);
         statLoader = null;
      }
      
      private function sendRequest() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(url)
         {
            _loc3_ = url + "?t=" + timeStamp;
            if(prevRequestTime > 0)
            {
               _loc3_ = _loc3_ + ("&rtt=" + prevRequestTime);
            }
            _loc2_ = SocialAdapter.instance.uid;
            if(_loc2_)
            {
               _loc3_ = _loc3_ + ("&uid=" + _loc2_);
            }
            _loc1_ = new URLRequest(_loc3_);
            statLoader.load(_loc1_);
            requestSentTime = timeStamp;
         }
      }
      
      private function get timeStamp() : Number
      {
         var _loc1_:Date = new Date();
         var _loc2_:Number = _loc1_.getTime() / 1000;
         return _loc2_;
      }
      
      protected function onComplete(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:URLLoader = param1.target as URLLoader;
         if(_loc3_)
         {
            _loc2_ = timeStamp;
            prevRequestTime = _loc2_ - requestSentTime;
            if(prevRequestTime < minRequestInterval || !minRequestInterval)
            {
               minRequestInterval = prevRequestTime;
               minServerTime = Number(_loc3_.data);
               minPrevRequestTime = requestSentTime;
            }
            trySendRequest();
         }
      }
      
      protected function onError(param1:Event) : void
      {
         trySendRequest();
      }
      
      private function trySendRequest() : void
      {
         iteration = Number(iteration) + 1;
         if(iteration < totalRequestsAmount)
         {
            sendRequest();
         }
         else
         {
            finish();
         }
      }
      
      private function finish() : void
      {
         var _loc2_:Number = minRequestInterval / 2;
         var _loc1_:Number = minServerTime - _loc2_;
         delay = _loc1_ - minPrevRequestTime;
         removeLoader();
      }
   }
}
