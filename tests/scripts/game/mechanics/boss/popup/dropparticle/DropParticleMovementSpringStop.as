package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementSpringStop extends DropParticleMovement
   {
       
      
      private var oscillationsCount:Number;
      
      private var elasticityPower:Number;
      
      public function DropParticleMovementSpringStop(param1:Number, param2:Number, param3:Number = 0.5)
      {
         this.oscillationsCount = param1;
         this._duration = param2;
         this.elasticityPower = param3;
         super();
      }
      
      override public function getPosition(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc5_:Point = _prev.getVelocity(1);
         var _loc3_:Point = point();
         var _loc4_:Number = oscillationsCount * 3.14159265358979;
         var _loc6_:Number = Math.sin(param1 * _loc4_) * (1 - Math.pow(param1,elasticityPower)) / _loc4_;
         _loc3_.x = _loc2_.x + _loc5_.x * _loc6_;
         _loc3_.y = _loc2_.y + _loc5_.y * _loc6_;
         return _loc3_;
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc5_:Point = _prev.getVelocity(1);
         var _loc3_:Point = point();
         var _loc4_:Number = oscillationsCount * 3.14159265358979;
         var _loc6_:Number = (_loc4_ * (1 - Math.pow(param1,elasticityPower)) * Math.cos(_loc4_ * param1) - Math.sin(_loc4_ * param1) * elasticityPower * Math.pow(param1,elasticityPower - 1)) / _loc4_;
         _loc3_.x = _loc5_.x * _loc6_;
         _loc3_.y = _loc5_.y * _loc6_;
         return _loc3_;
      }
   }
}
