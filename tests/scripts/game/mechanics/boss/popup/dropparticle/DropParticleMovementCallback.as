package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementCallback extends DropParticleMovement
   {
       
      
      private var callback:Function;
      
      private var args:Array;
      
      public function DropParticleMovementCallback(param1:Function, ... rest)
      {
         super();
         this.callback = param1;
         this.args = rest;
      }
      
      override public function complete() : void
      {
         callback.apply(null,args);
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
