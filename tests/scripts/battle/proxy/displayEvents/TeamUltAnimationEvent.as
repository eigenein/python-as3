package battle.proxy.displayEvents
{
   import battle.Team;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class TeamUltAnimationEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "TeamUltAnimationEvent";
       
      
      public var team:Team;
      
      public var skillCast:SkillCast;
      
      public function TeamUltAnimationEvent(param1:Team = undefined, param2:SkillCast = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(TeamUltAnimationEvent.TYPE);
         team = param1;
         skillCast = param2;
      }
   }
}
