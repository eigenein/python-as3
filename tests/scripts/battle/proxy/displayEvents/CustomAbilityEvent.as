package battle.proxy.displayEvents
{
   import battle.proxy.CustomAbilityProxy;
   import flash.Boot;
   
   public class CustomAbilityEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "CustomAbility";
       
      
      public var ability:CustomAbilityProxy;
      
      public function CustomAbilityEvent(param1:CustomAbilityProxy = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(CustomAbilityEvent.TYPE);
         ability = param1;
      }
   }
}
