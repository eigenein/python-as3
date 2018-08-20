package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovementPoint extends DropParticleMovement
   {
       
      
      private var x:Number;
      
      private var y:Number;
      
      private var vx:Number;
      
      private var vy:Number;
      
      public function DropParticleMovementPoint(param1:Number, param2:Number, param3:Number = 0, param4:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.vx = param3;
         this.vy = param4;
      }
      
      override public function getPosition(param1:Number) : Point
      {
         return point(x,y);
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         return point(vx,vy);
      }
   }
}
