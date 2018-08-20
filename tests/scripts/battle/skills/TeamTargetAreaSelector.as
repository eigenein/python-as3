package battle.skills
{
   import battle.Hero;
   import battle.Team;
   import battle.data.HeroState;
   import flash.Boot;
   
   public class TeamTargetAreaSelector extends TeamTargetSelector
   {
       
      
      public function TeamTargetAreaSelector(param1:Team = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      override public function heroIsNotAvailable(param1:Hero, param2:Hero) : Boolean
      {
         return !(param1 != param2 && (param1.state == null || param1.state.isDead == false) && param1.canBeTargeted.enabled);
      }
   }
}
