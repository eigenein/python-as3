package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementToPointInTime extends DropParticleMovement
   {
       
      
      private var x:Number;
      
      private var y:Number;
      
      public function DropParticleMovementToPointInTime(param1:Number, param2:Number, param3:Number)
      {
         super();
         this.x = param1;
         this.y = param2;
         this._duration = param3;
      }
      
      override public function getPosition(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc6_:Point = _prev.getVelocity(1);
         var _loc4_:Number = (x - _loc2_.x - _loc6_.x * duration) / duration / duration * 2;
         var _loc5_:Number = (y - _loc2_.y - _loc6_.y * duration) / duration / duration * 2;
         var _loc3_:Point = point();
         _loc3_.x = _loc2_.x + _loc6_.x * param1 * duration + _loc4_ * param1 * param1 * duration * duration / 2;
         _loc3_.y = _loc2_.y + _loc6_.y * param1 * duration + _loc5_ * param1 * param1 * duration * duration / 2;
         return _loc3_;
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc6_:Point = _prev.getVelocity(1);
         var _loc4_:Number = (x - _loc2_.x - _loc6_.x * duration) / duration / duration * 2;
         var _loc5_:Number = (y - _loc2_.y - _loc6_.y * duration) / duration / duration * 2;
         var _loc3_:Point = point();
         _loc3_.x = _loc6_.x + _loc4_ * param1 * duration;
         _loc3_.y = _loc6_.y + _loc5_ * param1 * duration;
         return _loc3_;
      }
   }
}
