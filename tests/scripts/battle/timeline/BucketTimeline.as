package battle.timeline
{
   import battle.skills.Context;
   import flash.Boot;
   
   public class BucketTimeline extends Timeline
   {
      
      public static var MAX_ITERATIONS:int = 2000000;
       
      
      public var updateTimeManager:IUpdateable;
      
      public var name:String;
      
      public var frontTime:Number;
      
      public var count:int;
      
      public var closeTime:Number;
      
      public var closeCount:int;
      
      public var close:Vector.<TimelineObject>;
      
      public var all:Vector.<TimelineObject>;
      
      public function BucketTimeline(param1:String = undefined, param2:IUpdateable = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         closeTime = 1.5;
         all = new Vector.<TimelineObject>();
         close = new Vector.<TimelineObject>();
         super();
         name = param1;
         updateTimeManager = param2;
         time = 0;
         frontTime = Number(time + closeTime);
         count = 0;
         closeCount = 0;
         eventIndex = 0;
      }
      
      override public function update(param1:TimelineObject, param2:Number) : void
      {
         var _loc3_:* = 0;
         if(param1.timelinePosition != -1 && param1.timelinePosition < closeCount)
         {
            if(param2 > frontTime && close[param1.timelinePosition] == param1)
            {
               _loc3_ = closeCount - 1;
               closeCount = _loc3_;
               close[param1.timelinePosition] = close[_loc3_];
               close[param1.timelinePosition].timelinePosition = param1.timelinePosition;
               param1.timelinePosition = -1;
            }
         }
         else if(param2 <= frontTime)
         {
            param1.timelinePosition = closeCount;
            _loc3_ = int(closeCount);
            closeCount = closeCount + 1;
            close[_loc3_] = param1;
         }
         param1.time = param2;
      }
      
      override public function setupTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as TimelineObject;
         var _loc7_:int = 0;
         time = param1;
         if(param1 < Timeline.INFINITY_TIME)
         {
            while(param1 >= frontTime)
            {
               frontTime = Number(frontTime + closeTime);
               closeCount = 0;
               _loc2_ = 0;
               _loc3_ = 0;
               _loc4_ = count;
               while(_loc3_ < _loc4_)
               {
                  _loc3_++;
                  _loc5_ = _loc3_;
                  _loc6_ = all[_loc5_];
                  if(_loc6_.time < frontTime)
                  {
                     _loc6_.timelinePosition = closeCount;
                     _loc7_ = closeCount;
                     closeCount = closeCount + 1;
                     close[_loc7_] = _loc6_;
                  }
                  else if(_loc6_.time == Timeline.INFINITY_TIME)
                  {
                     _loc2_++;
                  }
               }
               _loc2_;
            }
         }
      }
      
      override public function remove(param1:TimelineObject) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(param1.timelinePosition != -1)
         {
            _loc2_ = closeCount - 1;
            closeCount = _loc2_;
            if(param1.timelinePosition < _loc2_)
            {
               close[param1.timelinePosition] = close[closeCount];
               close[param1.timelinePosition].timelinePosition = param1.timelinePosition;
            }
            param1.timelinePosition = -1;
         }
         _loc2_ = int(all.indexOf(param1));
         if(_loc2_ != -1)
         {
            _loc3_ = count - 1;
            count = _loc3_;
            if(_loc2_ < _loc3_)
            {
               all[_loc2_] = all.pop();
            }
            else
            {
               all.pop();
            }
         }
      }
      
      override public function interruptTimeAdvancement() : void
      {
         timeAdvancementInterrupted = true;
      }
      
      public function increaseFront() : int
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as TimelineObject;
         var _loc6_:int = 0;
         frontTime = Number(frontTime + closeTime);
         closeCount = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = count;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            _loc5_ = all[_loc4_];
            if(_loc5_.time < frontTime)
            {
               _loc5_.timelinePosition = closeCount;
               _loc6_ = closeCount;
               closeCount = closeCount + 1;
               close[_loc6_] = _loc5_;
            }
            else if(_loc5_.time == Timeline.INFINITY_TIME)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      override public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = count;
         while(_loc1_ < _loc2_)
         {
            _loc1_++;
            _loc3_ = _loc1_;
            all[_loc3_].timelinePosition = -1;
         }
         close = new Vector.<TimelineObject>();
         all = new Vector.<TimelineObject>();
         _loc1_ = 0;
         count = _loc1_;
         closeCount = _loc1_;
      }
      
      override public function advanceTime(param1:Number, param2:int = 999000000) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:* = null as TimelineObject;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as TimelineObject;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(param2 != 999000000)
         {
            param1 = param1 + 0.00001;
         }
         timeAdvancementInterrupted = false;
         var _loc3_:int = 2000000;
         while(time <= param1 && eventIndex < param2)
         {
            _loc3_--;
            if(_loc3_ == 0)
            {
               throw "infinite loop in battles";
            }
            if(!timeAdvancementInterrupted)
            {
               _loc4_ = frontTime + 1;
               _loc5_ = null;
               _loc6_ = 0;
               _loc7_ = closeCount;
               while(_loc6_ < _loc7_)
               {
                  _loc6_++;
                  _loc8_ = _loc6_;
                  _loc9_ = close[_loc8_];
                  if(_loc9_.time < _loc4_)
                  {
                     _loc5_ = _loc9_;
                     _loc4_ = _loc5_.time;
                  }
               }
               if(_loc4_ > frontTime && frontTime <= param1)
               {
                  frontTime = Number(frontTime + closeTime);
                  closeCount = 0;
                  _loc6_ = 0;
                  _loc7_ = 0;
                  _loc8_ = count;
                  while(_loc7_ < _loc8_)
                  {
                     _loc7_++;
                     _loc10_ = _loc7_;
                     _loc9_ = all[_loc10_];
                     if(_loc9_.time < frontTime)
                     {
                        _loc9_.timelinePosition = closeCount;
                        _loc11_ = closeCount;
                        closeCount = closeCount + 1;
                        close[_loc11_] = _loc9_;
                     }
                     else if(_loc9_.time == Timeline.INFINITY_TIME)
                     {
                        _loc6_++;
                     }
                  }
                  if(_loc6_ != count)
                  {
                     continue;
                  }
                  break;
               }
               if(_loc4_ <= param1)
               {
                  time = _loc4_;
                  Context.scene.setSceneTimeOffset(param1 - time);
                  updateTimeManager.update(this);
                  _loc5_.onTime(this);
                  eventIndex = eventIndex + 1;
                  continue;
               }
               break;
            }
            break;
         }
         if(timeAdvancementInterrupted == true || eventIndex == param2)
         {
            return;
         }
         if(time != param1)
         {
            time = param1;
         }
      }
      
      override public function add(param1:TimelineObject) : void
      {
         var _loc2_:int = 0;
         if(param1.time < frontTime)
         {
            param1.timelinePosition = closeCount;
            _loc2_ = closeCount;
            closeCount = closeCount + 1;
            close[_loc2_] = param1;
         }
         else
         {
            param1.timelinePosition = -1;
         }
         _loc2_ = count;
         count = count + 1;
         all[_loc2_] = param1;
      }
   }
}
