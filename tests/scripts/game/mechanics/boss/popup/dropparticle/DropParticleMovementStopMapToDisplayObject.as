package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class DropParticleMovementStopMapToDisplayObject extends DropParticleMovement
   {
       
      
      private var object:DisplayObject;
      
      private var parent:DisplayObjectContainer;
      
      public function DropParticleMovementStopMapToDisplayObject(param1:Number, param2:DisplayObject, param3:DisplayObjectContainer)
      {
         super();
         _duration = param1;
         this.object = param2;
         this.parent = param3;
      }
      
      override public function getPosition(param1:Number) : Point
      {
         var _loc2_:Point = _prev.getPosition(1);
         var _loc4_:Point = parent.localToGlobal(_loc2_,point());
         object.parent.globalToLocal(_loc4_,_loc2_);
         var _loc3_:Point = object.transformationMatrix.transformPoint(_loc2_);
         object.parent.localToGlobal(_loc3_,_loc4_);
         parent.globalToLocal(_loc4_,_loc2_);
         pool(_loc4_);
         return _loc2_;
      }
      
      override public function getVelocity(param1:Number) : Point
      {
         return _prev.getVelocity(1);
      }
   }
}
