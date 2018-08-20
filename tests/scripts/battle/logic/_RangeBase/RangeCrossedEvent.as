package battle.logic._RangeBase
{
   import battle.logic.RangeBase;
   import battle.timeline.Timeline;
   import battle.timeline.TimelineObject;
   import flash.Boot;
   
   public class RangeCrossedEvent extends TimelineObject
   {
       
      
      public var range:RangeBase;
      
      public function RangeCrossedEvent(param1:RangeBase = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         range = param1;
      }
      
      override public function toString() : String
      {
         var _loc2_:Number = range.getRadius();
         var _loc1_:String = "RangeCrossedEvent[" + int(range.base.x) + "]" + int(_loc2_);
         if((time == Timeline.INFINITY_TIME || time * 2 == time || time < 0) && time != 0)
         {
            return _loc1_ + "[inf]";
         }
         return _loc1_ + "[" + Timeline.stableRound(time) + "]";
      }
      
      override public function onTime(param1:Timeline) : void
      {
         range.onRangeCrossed();
      }
   }
}
