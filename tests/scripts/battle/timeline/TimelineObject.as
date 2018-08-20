package battle.timeline
{
   public class TimelineObject extends TimeObject
   {
       
      
      public var timelinePosition:int;
      
      public function TimelineObject()
      {
      }
      
      public function toString() : String
      {
         var _loc1_:String = Type.getClassName(Type.getClass(this));
         if((time == Timeline.INFINITY_TIME || time * 2 == time || time < 0) && time != 0)
         {
            return _loc1_ + "[inf]";
         }
         return _loc1_ + "[" + Timeline.stableRound(time) + "]";
      }
      
      public function onTime(param1:Timeline) : void
      {
         param1.update(this,Number(Number(time + 1) + Math.random() * Math.random() * 20));
      }
      
      public function _toString(param1:String) : String
      {
         if((time == Timeline.INFINITY_TIME || time * 2 == time || time < 0) && time != 0)
         {
            return param1 + "[inf]";
         }
         return param1 + "[" + Timeline.stableRound(time) + "]";
      }
   }
}
