package battle.proxy.displayEvents
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleTextEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "BattleText";
       
      
      public var text:String;
      
      public var hero:Hero;
      
      public function BattleTextEvent(param1:Hero = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(BattleTextEvent.TYPE);
         hero = param1;
         text = param2;
      }
   }
}
