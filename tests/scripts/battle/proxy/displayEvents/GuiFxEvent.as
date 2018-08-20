package battle.proxy.displayEvents
{
   import battle.Hero;
   import battle.Team;
   import flash.Boot;
   
   public class GuiFxEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "GuiFxEvent";
       
      
      public var team:Team;
      
      public var location:String;
      
      public var hero:Hero;
      
      public var fx:String;
      
      public function GuiFxEvent(param1:String = undefined, param2:String = undefined, param3:Team = undefined, param4:Hero = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(GuiFxEvent.TYPE);
         location = param1;
         fx = param2;
         team = param3;
         hero = param4;
      }
   }
}
