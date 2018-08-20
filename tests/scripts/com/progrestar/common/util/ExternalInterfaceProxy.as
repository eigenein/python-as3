package com.progrestar.common.util
{
   import com.progrestar.common.error.ClientErrorManager;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class ExternalInterfaceProxy
   {
      
      private static var registeredClosures:Dictionary = new Dictionary();
       
      
      public function ExternalInterfaceProxy()
      {
         super();
      }
      
      public static function get available() : Boolean
      {
         return ExternalInterface.available;
      }
      
      public static function call(param1:String, ... rest) : *
      {
         try
         {
            rest.unshift(param1);
            var _loc4_:* = ExternalInterface.call.apply(null,rest);
            return _loc4_;
         }
         catch(error:*)
         {
            if(error is Error)
            {
               ClientErrorManager.action_handleError(error);
            }
            else
            {
               ClientErrorManager.action_handleError(new Error(error));
            }
            var _loc5_:* = null;
            return _loc5_;
         }
      }
      
      public static function addCallback(param1:String, param2:Function) : void
      {
         functionName = param1;
         closure = param2;
         closureWrapper = function(... rest):void
         {
            internalClosureHandler(functionName,rest);
         };
         registeredClosures[functionName] = closure;
         ExternalInterface.addCallback(functionName,closureWrapper);
      }
      
      private static function internalClosureHandler(param1:String, param2:Array) : void
      {
         var _loc3_:Function = registeredClosures[param1];
         if(_loc3_)
         {
            try
            {
               _loc3_.apply(null,param2);
               return;
            }
            catch(error:*)
            {
               if(error is Error)
               {
                  ClientErrorManager.action_handleError(error);
               }
               else
               {
                  ClientErrorManager.action_handleError(new Error(error));
               }
               return;
            }
         }
      }
   }
}
