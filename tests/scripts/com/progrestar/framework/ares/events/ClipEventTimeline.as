package com.progrestar.framework.ares.events
{
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.extension.SoundDataExtension;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import flash.utils.Dictionary;
   
   public class ClipEventTimeline
   {
      
      private static var internalConstructor:Boolean = false;
       
      
      private var currentFrame:int = -1;
      
      private var currentEventIndex:int = 0;
      
      private var events:Vector.<IClipEvent>;
      
      private var eventHandlers:Dictionary;
      
      public function ClipEventTimeline(param1:Vector.<IClipEvent>, param2:Class = null, param3:Function = null)
      {
         eventHandlers = new Dictionary();
         super();
         assert(internalConstructor);
         internalConstructor = false;
         this.events = param1;
         if(param2 && param3)
         {
            eventHandlers[param2] = param3;
         }
      }
      
      public static function getSoundEventsTimeline(param1:ClipAsset, param2:Clip, param3:IClipSoundEventHandler) : ClipEventTimeline
      {
         var _loc4_:SoundDataExtension = SoundDataExtension.fromAsset(param1);
         if(!_loc4_)
         {
            return null;
         }
         var _loc5_:Vector.<IClipEvent> = _loc4_.getClipSoundEvents(param2);
         if(!_loc5_)
         {
            return null;
         }
         internalConstructor = true;
         return new ClipEventTimeline(_loc5_,ClipSoundEvent,param3.onSoundEvent);
      }
      
      public static function merge(param1:ClipEventTimeline, param2:ClipEventTimeline) : ClipEventTimeline
      {
         var _loc9_:int = 0;
         if(!param1)
         {
            return param2;
         }
         if(!param2)
         {
            return param1;
         }
         internalConstructor = true;
         var _loc7_:ClipEventTimeline = new ClipEventTimeline(new Vector.<IClipEvent>());
         var _loc11_:* = param1.events.length + param2.events.length;
         _loc7_.events.length = _loc11_;
         var _loc5_:int = _loc11_;
         var _loc3_:int = param1.events.length;
         var _loc4_:int = param2.events.length;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            if((_loc6_ >= _loc3_ || param1.events[_loc6_].frame > param2.events[_loc8_].frame) && _loc8_ < _loc4_)
            {
               _loc8_++;
               _loc7_.events[_loc9_] = param1.events[_loc8_];
            }
            else
            {
               _loc6_++;
               _loc7_.events[_loc9_] = param1.events[_loc6_];
            }
            _loc9_++;
         }
         var _loc13_:int = 0;
         var _loc12_:* = param1.eventHandlers;
         for(var _loc10_ in param1.eventHandlers)
         {
            _loc7_.eventHandlers[_loc10_] = param1.eventHandlers[_loc10_];
         }
         var _loc15_:int = 0;
         var _loc14_:* = param2.eventHandlers;
         for(_loc10_ in param2.eventHandlers)
         {
            _loc7_.eventHandlers[_loc10_] = param2.eventHandlers[_loc10_];
         }
         return _loc7_;
      }
      
      public static function playEvents(param1:Vector.<IClipEvent>, param2:int, param3:int, param4:Function) : void
      {
         var _loc6_:* = null;
         var _loc5_:int = 0;
         while(_loc5_ < param1.length && param1[_loc5_].frame <= param2)
         {
            _loc5_++;
         }
         if(param3 < param2)
         {
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_];
               param4(_loc6_);
               _loc5_++;
            }
            param2 = -1;
            _loc5_ = 0;
         }
         if(param3 > param2)
         {
            while(_loc5_ < param1.length && param1[_loc5_].frame <= param3)
            {
               _loc6_ = param1[_loc5_];
               param4(_loc6_);
               _loc5_++;
            }
            param2 = param3;
         }
      }
      
      public function skipTo(param1:int) : void
      {
         currentFrame = param1;
      }
      
      public function advanceFrame(param1:int) : void
      {
         var _loc2_:* = null;
         if(param1 < currentFrame)
         {
            while(currentEventIndex < events.length)
            {
               _loc2_ = events[currentEventIndex];
               eventHandlers[_loc2_.type](_loc2_);
               currentEventIndex = Number(currentEventIndex) + 1;
            }
            currentFrame = -1;
            currentEventIndex = 0;
         }
         if(param1 > currentFrame)
         {
            while(currentEventIndex < events.length && events[currentEventIndex].frame <= param1)
            {
               _loc2_ = events[currentEventIndex];
               eventHandlers[_loc2_.type](_loc2_);
               currentEventIndex = Number(currentEventIndex) + 1;
            }
            currentFrame = param1;
         }
      }
   }
}
