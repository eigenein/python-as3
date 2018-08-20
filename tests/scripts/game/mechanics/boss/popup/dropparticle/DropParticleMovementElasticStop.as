package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementElasticStop extends DropParticleMovement
   {
       
      
      private var elasticityPower:Number;
      
      private var stopDuration:Number;
      
      public function DropParticleMovementElasticStop(param1:Number, param2:Number, param3:Number = -1)
      {
         this._duration = param1;
         this.elasticityPower = param2;
         if(param3 == -1)
         {
            param3 = param1;
         }
         this.stopDuration = param3;
         super();
      }
      
      override public function getPosition(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc4_:Point = _prev.getVelocity(1);
         var _loc3_:Point = point();
         param1 = param1 > stopDuration / _duration?1:Number(param1 / stopDuration * _duration);
         var _loc5_:Number = (1 - Math.pow(1 - param1,1 + elasticityPower)) / (1 + elasticityPower) * stopDuration;
         _loc3_.x = _loc2_.x + _loc4_.x * _loc5_;
         _loc3_.y = _loc2_.y + _loc4_.y * _loc5_;
         return _loc3_;
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         var _loc3_:Point = _prev.getVelocity(1);
         var _loc2_:Point = point();
         param1 = param1 > stopDuration / _duration?1:Number(param1 / stopDuration * _duration);
         var _loc4_:Number = Math.pow(1 - param1,elasticityPower);
         _loc2_.x = _loc3_.x * _loc4_;
         _loc2_.y = _loc3_.y * _loc4_;
         return _loc2_;
      }
   }
}
