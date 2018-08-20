package battle.objects._ProjectileEntityCoupled
{
   import battle.objects.ProjectileEntityCoupled;
   import battle.timeline.Timeline;
   import battle.timeline.TimelineObject;
   import flash.Boot;
   
   public class ProjectileUncoupleTimeEvent extends TimelineObject
   {
       
      
      public var projectile:ProjectileEntityCoupled;
      
      public function ProjectileUncoupleTimeEvent(param1:ProjectileEntityCoupled = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         projectile = param1;
         time = Timeline.INFINITY_TIME;
      }
      
      override public function toString() : String
      {
         if((time == Timeline.INFINITY_TIME || time * 2 == time || time < 0) && time != 0)
         {
            return "ProjectileUncoupleTimeEvent" + "[inf]";
         }
         return "ProjectileUncoupleTimeEvent" + "[" + Timeline.stableRound(time) + "]";
      }
      
      override public function onTime(param1:Timeline) : void
      {
         projectile.uncouple();
      }
   }
}
