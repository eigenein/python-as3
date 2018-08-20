package battle.proxy.displayEvents
{
   import flash.Boot;
   
   public class SmashGroundEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "SmashGround";
       
      
      public var x:Number;
      
      public var r:Number;
      
      public var direction:Number;
      
      public function SmashGroundEvent(param1:Number = 0.0, param2:Number = 0.0, param3:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(SmashGroundEvent.TYPE);
         x = param1;
         r = param2;
         direction = param3;
      }
   }
}
