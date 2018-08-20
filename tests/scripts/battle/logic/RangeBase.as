package battle.logic
{
   import battle.logic._RangeBase.RangeCrossedEvent;
   import battle.signals.SignalNotifier;
   import battle.timeline.Timeline;
   import battle.timeline.TimelineObject;
   import flash.Boot;
   
   public class RangeBase extends TimelineObject
   {
       
      
      public var timeline:Timeline;
      
      public var rangeCrossedEvent:RangeCrossedEvent;
      
      public var r:Number;
      
      public var onOccupied:SignalNotifier;
      
      public var onEmpty:SignalNotifier;
      
      public var base:MovingBody;
      
      public function RangeBase(param1:Timeline = undefined, param2:MovingBody = undefined, param3:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onEmpty = new SignalNotifier(null,"Range.onEmpty");
         onOccupied = new SignalNotifier(null,"Range.onOccupied");
         super();
         timeline = param1;
         base = param2;
         r = param3;
         init();
      }
      
      public function verify(param1:Boolean = false) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as MovingBody;
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<MovingBody> = this.objects;
         var _loc4_:int = 0;
         var _loc5_:int = _loc3_.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = _loc3_[_loc6_];
            if(base != _loc7_ && (Number(Number(_loc7_.x + _loc7_.size) + r) > base.x - 1.0e-12 && _loc7_.x - _loc7_.size - r < Number(base.x + 1.0e-12)))
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      public function updateRangeEvent(param1:Number) : void
      {
         if(rangeCrossedEvent == null)
         {
            rangeCrossedEvent = new RangeCrossedEvent(this);
            rangeCrossedEvent.time = param1;
            timeline.add(rangeCrossedEvent);
         }
         else if(param1 != rangeCrossedEvent.time)
         {
            timeline.update(rangeCrossedEvent,param1);
         }
      }
      
      public function test() : void
      {
      }
      
      public function setTargets(param1:Vector.<MovingBody>) : void
      {
      }
      
      public function setRadius(param1:Number) : void
      {
         r = param1;
      }
      
      public function removeObject(param1:MovingBody) : void
      {
      }
      
      public function onRangeCrossed() : void
      {
      }
      
      public function isOccupied() : Boolean
      {
         return false;
      }
      
      public function init() : void
      {
      }
      
      public function inRangeStrict(param1:MovingBody) : Boolean
      {
         return Number(Number(param1.x + param1.size) + r) > base.x && param1.x - param1.size - r < base.x;
      }
      
      public function inRange(param1:MovingBody) : Boolean
      {
         return Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-12 && param1.x - param1.size - r < Number(base.x + 1.0e-12);
      }
      
      public function hasNoObjects() : Boolean
      {
         return true;
      }
      
      public function getRadius() : Number
      {
         return r;
      }
      
      public function dispose() : void
      {
         if(rangeCrossedEvent != null)
         {
            timeline.remove(rangeCrossedEvent);
         }
      }
      
      public function addObject(param1:MovingBody) : void
      {
      }
   }
}
