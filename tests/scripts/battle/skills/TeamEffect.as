package battle.skills
{
   import battle.Hero;
   import battle.Team;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   import flash.Boot;
   
   public class TeamEffect extends Effect
   {
       
      
      public var targetTeam:Team;
      
      public function TeamEffect(param1:Timeline = undefined, param2:String = undefined, param3:Array = undefined, param4:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2,param3,param4);
      }
      
      override public function targetToString() : String
      {
         return targetTeam.toString();
      }
      
      override public function sameTeam(param1:Hero) : Boolean
      {
         if(Version.current >= 137)
         {
            if(param1 == null)
            {
               return false;
            }
            return targetTeam == param1.team;
         }
         return Boolean(super.sameTeam(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         if(targetTeam != null)
         {
            targetTeam.effects.removeEffect(this);
         }
      }
      
      public function applyToTeam(param1:Team) : void
      {
         if(targetTeam != null)
         {
            return;
         }
         targetTeam = param1;
         init(param1.engine);
         skillCast.createdObjectsCount = skillCast.createdObjectsCount + 1;
      }
   }
}
