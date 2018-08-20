package battle.logic
{
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class ImpactRange extends RangeBase
   {
      
      public static var OCCUPATION_DELAY:Number = 0.01;
       
      
      public var occupator:MovingBody;
      
      public var objects:Vector.<MovingBody>;
      
      public var inputTime:Number;
      
      public function ImpactRange(param1:Timeline = undefined, param2:MovingBody = undefined, param3:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         objects = new Vector.<MovingBody>();
         super(param1,param2,param3);
      }
      
      public function updateAll(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:* = null as MovingBody;
         var _loc2_:MovingBody = base;
         var _loc3_:Number = timeline.time;
         inputTime = Timeline.INFINITY_TIME;
         var _loc5_:int = objects.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = objects[_loc5_];
            if(!(Number(Number(_loc6_.x + _loc6_.size) + r) > base.x - 1.0e-12 && _loc6_.x - _loc6_.size - r < Number(base.x + 1.0e-12)))
            {
               if(base.vx < _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (Number(Number(_loc6_.x - base.x + _loc6_.size) + r)) / (base.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else if(base.vx > _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (_loc6_.x - base.x - _loc6_.size - r) / (base.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  _loc4_ = Timeline.INFINITY_TIME;
               }
               if(inputTime > _loc4_ && timeline.time < _loc4_)
               {
                  occupator = _loc6_;
                  inputTime = _loc4_;
               }
            }
         }
         updateRangeEvent(inputTime);
      }
      
      public function unsafeInRange(param1:MovingBody) : Boolean
      {
         return Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-12 && param1.x - param1.size - r < Number(base.x + 1.0e-12);
      }
      
      override public function setTargets(param1:Vector.<MovingBody>) : void
      {
         objects = param1;
         updateAll(1);
      }
      
      override public function setRadius(param1:Number) : void
      {
         r = param1;
         updateAll(0);
      }
      
      override public function removeObject(param1:MovingBody) : void
      {
         var _loc2_:int = objects.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:Vector.<MovingBody> = objects;
         var _loc4_:* = int(_loc3_.length) - 1;
         if(_loc4_ >= 0)
         {
            _loc3_[_loc2_] = _loc3_[_loc4_];
            _loc3_.length = _loc4_;
         }
         if(param1 == occupator)
         {
            updateAll(2);
         }
      }
      
      override public function onRangeCrossed() : void
      {
         onOccupied.fire(occupator);
         objectOnRange(occupator);
      }
      
      public function onMove(param1:MovingBody) : void
      {
         var _loc2_:Number = NaN;
         if(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-12 && param1.x - param1.size - r < Number(base.x + 1.0e-12))
         {
            null;
         }
         else
         {
            if(base.vx < param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else if(base.vx > param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else
            {
               _loc2_ = Timeline.INFINITY_TIME;
            }
            if(inputTime > _loc2_ && timeline.time < _loc2_)
            {
               occupator = param1;
               inputTime = _loc2_;
               updateRangeEvent(_loc2_);
            }
            else if(param1 == occupator)
            {
               updateAll(5);
            }
         }
      }
      
      public function onBaseMove(param1:MovingBody) : void
      {
         updateAll(4);
      }
      
      public function objectOnRange(param1:MovingBody) : void
      {
         updateAll(3);
      }
      
      override public function isOccupied() : Boolean
      {
         return false;
      }
      
      override public function init() : void
      {
         base.onMove.add(onBaseMove);
         inputTime = Timeline.INFINITY_TIME;
      }
      
      override public function hasNoObjects() : Boolean
      {
         return int(objects.length) == 0;
      }
      
      public function getNextTime() : Number
      {
         return inputTime;
      }
      
      public function getNextTarget() : MovingBody
      {
         return occupator;
      }
      
      public function getInputTime(param1:MovingBody) : Number
      {
         if(base.vx < param1.vx)
         {
            return Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         if(base.vx > param1.vx)
         {
            return Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function getCollisionTime(param1:MovingBody) : Number
      {
         if(base.vx < param1.vx)
         {
            return Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         if(base.vx > param1.vx)
         {
            return Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function computeObjectCore(param1:MovingBody) : void
      {
         var _loc2_:Number = NaN;
         if(!(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-12 && param1.x - param1.size - r < Number(base.x + 1.0e-12)))
         {
            if(base.vx < param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else if(base.vx > param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else
            {
               _loc2_ = Timeline.INFINITY_TIME;
            }
            if(inputTime > _loc2_ && timeline.time < _loc2_)
            {
               occupator = param1;
               inputTime = _loc2_;
               updateRangeEvent(_loc2_);
            }
            else if(param1 == occupator)
            {
               updateAll(5);
            }
         }
      }
      
      override public function addObject(param1:MovingBody) : void
      {
         var _loc2_:Number = NaN;
         objects.push(param1);
         param1.onMove.add(onMove);
         if(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-12 && param1.x - param1.size - r < Number(base.x + 1.0e-12))
         {
            null;
         }
         else
         {
            if(base.vx < param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else if(base.vx > param1.vx)
            {
               _loc2_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
            }
            else
            {
               _loc2_ = Timeline.INFINITY_TIME;
            }
            if(inputTime > _loc2_ && timeline.time < _loc2_)
            {
               occupator = param1;
               inputTime = _loc2_;
               updateRangeEvent(_loc2_);
            }
            else if(param1 == occupator)
            {
               updateAll(5);
            }
         }
      }
   }
}
