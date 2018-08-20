package game.battle.view
{
   import flash.geom.Point;
   
   public class CameraSineMotion
   {
       
      
      private var position:Point;
      
      private const startPosition:Point = new Point();
      
      private const endPosition:Point = new Point();
      
      private var _timeLeft:Number = 0;
      
      private var duration:Number;
      
      public function CameraSineMotion(param1:Point)
      {
         super();
         this.position = param1;
      }
      
      public function get completed() : Boolean
      {
         return _timeLeft <= 0;
      }
      
      public function get timeLeft() : Number
      {
         return _timeLeft;
      }
      
      public function interrupt() : void
      {
         _timeLeft = 0;
      }
      
      public function start(param1:Point, param2:Number, param3:Number) : void
      {
         this.duration = param2;
         _timeLeft = param2 + param3;
         startPosition.x = position.x;
         startPosition.y = position.y;
         endPosition.x = param1.x;
         endPosition.y = param1.y;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         _timeLeft = _timeLeft - param1;
         if(_timeLeft > 0)
         {
            _loc2_ = _timeLeft / duration;
            if(_loc2_ < 1 && _loc2_ > 0)
            {
               _loc2_ = 0.5 - 0.5 * Math.sin((_loc2_ - 0.5) * 3.14159265358979);
               position.x = startPosition.x * (1 - _loc2_) + endPosition.x * _loc2_;
               position.y = startPosition.y * (1 - _loc2_) + endPosition.y * _loc2_;
            }
         }
         else
         {
            _timeLeft = 0;
            position.x = endPosition.x;
            position.y = endPosition.y;
         }
      }
   }
}
