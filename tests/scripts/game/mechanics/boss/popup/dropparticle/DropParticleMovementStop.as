package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementStop extends DropParticleMovement
   {
       
      
      public function DropParticleMovementStop(param1:Number)
      {
         super();
         _duration = param1;
      }
      
      override public function getPosition(param1:Number) : Point
      {
         return _prev.getPosition(1);
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         return _prev.getVelocity(1);
      }
   }
}
