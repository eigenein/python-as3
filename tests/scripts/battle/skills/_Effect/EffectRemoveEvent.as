package battle.skills._Effect
{
   import battle.skills.Effect;
   import battle.timeline.Timeline;
   import battle.timeline.TimelineObject;
   import flash.Boot;
   
   public class EffectRemoveEvent extends TimelineObject
   {
       
      
      public var effect:Effect;
      
      public function EffectRemoveEvent(param1:Effect = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         time = Timeline.INFINITY_TIME;
         effect = param1;
      }
      
      override public function toString() : String
      {
         if((time == Timeline.INFINITY_TIME || time * 2 == time || time < 0) && time != 0)
         {
            return "EffectRemoveEvent" + "[inf]";
         }
         return "EffectRemoveEvent" + "[" + Timeline.stableRound(time) + "]";
      }
      
      override public function onTime(param1:Timeline) : void
      {
         effect.remove();
      }
   }
}
