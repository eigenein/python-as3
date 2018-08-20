package game.util
{
   import com.progrestar.common.error.ISessionStateInfoProvider;
   import flash.system.System;
   import flash.utils.getTimer;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class SessionStateInfoProvider implements ISessionStateInfoProvider
   {
       
      
      private var _starling:Starling;
      
      private var contextCreatedTimes:int = 0;
      
      public function SessionStateInfoProvider(param1:Starling)
      {
         super();
         _starling = param1;
         _starling.addEventListener("context3DCreate",handler_context3DCreate);
      }
      
      public function getState() : String
      {
         var _loc2_:Number = System.totalMemory / 1024 / 1024;
         var _loc1_:String = _loc2_.toFixed(_loc2_ < 100?1:0) + "m " + int(getTimer() / 1000) + "s";
         if(!_starling.contextValid)
         {
            _loc1_ = _loc1_ + " cLost";
         }
         if(contextCreatedTimes > 1)
         {
            _loc1_ = _loc1_ + (" cRestored:" + (contextCreatedTimes - 1));
         }
         return _loc1_;
      }
      
      private function handler_context3DCreate(param1:Event) : void
      {
         contextCreatedTimes = Number(contextCreatedTimes) + 1;
      }
   }
}
