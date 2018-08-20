package battle.logic
{
   import battle.signals.SignalNotifier;
   import flash.Boot;
   
   public class MovingBody
   {
      
      public static var INVALID_POSITION:Number = -1.0e100;
       
      
      public var x:Number;
      
      public var vx:Number;
      
      public var time:Number;
      
      public var size:Number;
      
      public var onMove:SignalNotifier;
      
      public function MovingBody(param1:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         size = param1;
         var _loc2_:* = 0;
         vx = _loc2_;
         x = _loc2_;
         onMove = new SignalNotifier(this,"object onMove");
      }
      
      public function toString() : String
      {
         return "battle.logic.MovingBody";
      }
      
      public function setX(param1:Number) : void
      {
         x = param1;
         onMove.fire();
      }
      
      public function setVelocity(param1:Number, param2:Number) : void
      {
         vx = param1;
      }
      
      public function setSize(param1:Number) : void
      {
         size = param1;
         onMove.fire();
      }
   }
}
