package battle.proxy
{
   import battle.Hero;
   import battle.Team;
   import battle.logic.Disabler;
   import flash.Boot;
   
   public class CustomManualAction
   {
      
      public static var PRIORITY_ULT:int = 0;
       
      
      public var team:Team;
      
      public var priority:int;
      
      public var hero:Hero;
      
      public var fx:String;
      
      public var condition:Disabler;
      
      public var callback:Function;
      
      public var actionId:int;
      
      public function CustomManualAction(param1:Hero = undefined, param2:Team = undefined, param3:int = 0, param4:Disabler = undefined, param5:String = undefined, param6:int = 0, param7:Function = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         hero = param1;
         team = param2;
         actionId = param3;
         condition = param4;
         fx = param5;
         priority = param6;
         callback = param7;
      }
      
      public function manualTrigger() : void
      {
         if(hero != null)
         {
            hero.customActionUserInput(actionId);
         }
         else if(team != null)
         {
            team.customActionTeamInput(actionId);
         }
      }
      
      public function execute() : void
      {
         if(condition.enabled)
         {
            callback();
         }
      }
   }
}
