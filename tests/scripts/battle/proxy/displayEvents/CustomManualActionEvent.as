package battle.proxy.displayEvents
{
   import battle.data.BattleHeroDescription;
   import battle.proxy.CustomManualAction;
   import flash.Boot;
   
   public class CustomManualActionEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "CustomManualAcion";
       
      
      public var hero:BattleHeroDescription;
      
      public var action:CustomManualAction;
      
      public function CustomManualActionEvent(param1:CustomManualAction = undefined, param2:BattleHeroDescription = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(CustomManualActionEvent.TYPE);
         action = param1;
         hero = param2;
      }
   }
}
