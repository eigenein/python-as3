package battle.skills
{
   import battle.BattleEngine;
   import battle.Hero;
   import battle.action.Action;
   import battle.data.BattleSkillDescription;
   import battle.timeline.Scheduler;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class SkillCastActor extends Scheduler
   {
       
      
      public var skill:BattleSkillDescription;
      
      public var hero:Hero;
      
      public var engine:BattleEngine;
      
      public function SkillCastActor(param1:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      public function hitDamage(param1:Hero, param2:Action) : int
      {
         return 0;
      }
   }
}
