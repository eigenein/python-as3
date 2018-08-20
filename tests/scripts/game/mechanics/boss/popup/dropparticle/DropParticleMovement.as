package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleMovement
   {
      
      public static var POOL:PointPool = new PointPool();
       
      
      protected var _prev:DropParticleMovement;
      
      protected var _next:DropParticleMovement;
      
      protected var _duration:Number = 0;
      
      public function DropParticleMovement()
      {
         super();
      }
      
      public function set prev(param1:DropParticleMovement) : void
      {
         _prev = param1;
      }
      
      public function set next(param1:DropParticleMovement) : void
      {
         _next = param1;
      }
      
      public function get duration() : Number
      {
         return _duration;
      }
      
      public function getPosition(param1:Number) : Point
      {
         return point();
      }
      
      public function getVelocity(param1:Number) : Point
      {
         return point();
      }
      
      public function complete() : void
      {
      }
      
      public final function pool(param1:Point) : void
      {
         POOL.pool(param1);
      }
      
      public final function point(param1:Number = 0, param2:Number = 0) : Point
      {
         return POOL.point(param1,param2);
      }
   }
}
