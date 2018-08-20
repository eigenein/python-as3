package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticlePosition
   {
       
      
      public var t:Number = 0;
      
      public var step:int = 0;
      
      public var view:IDropParticleView;
      
      public var route:Vector.<DropParticleMovement>;
      
      public const position:Point = new Point();
      
      public function DropParticlePosition()
      {
         super();
      }
   }
}
