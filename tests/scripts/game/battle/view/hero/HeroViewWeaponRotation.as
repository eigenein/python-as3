package game.battle.view.hero
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   
   public class HeroViewWeaponRotation
   {
      
      protected static var tempMatrix:Matrix = new Matrix();
       
      
      private var lastJoint:Point;
      
      private var rotation:Number;
      
      private var oldRotation:Number;
      
      private var newRotation:Number;
      
      private var duration:Number;
      
      private var delay:Number = 0;
      
      private var timePassed:Number;
      
      private var fadePhase:Boolean = false;
      
      private var hasJoint:Boolean = false;
      
      private var tweenStyle:int = 0;
      
      private var mirrorMultiplier:int = 1;
      
      protected var _transform:Matrix;
      
      public function HeroViewWeaponRotation()
      {
         lastJoint = new Point();
         _transform = new Matrix();
         super();
      }
      
      public function get transform() : Matrix
      {
         if(hasJoint)
         {
            tempMatrix.a = _transform.a;
            tempMatrix.b = _transform.b * mirrorMultiplier;
            tempMatrix.c = _transform.c * mirrorMultiplier;
            tempMatrix.d = _transform.d;
            tempMatrix.tx = lastJoint.x;
            tempMatrix.ty = lastJoint.y;
            return tempMatrix;
         }
         return null;
      }
      
      public function setMirrored(param1:Boolean) : void
      {
         mirrorMultiplier = !!param1?-1:1;
      }
      
      public function setRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         if(param3 == 0)
         {
            this.rotation = param1;
            setupAngle(param1);
         }
         if(this.rotation == this.rotation)
         {
            oldRotation = this.rotation;
         }
         else
         {
            oldRotation = 0;
         }
         newRotation = param1;
         timePassed = 0;
         this.duration = param2;
         this.tweenStyle = param3;
         this.delay = param4;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(fadePhase)
         {
            rotation = rotation * 0.8;
         }
         else
         {
            if(tweenStyle == 0)
            {
               return;
            }
            if(delay > 0)
            {
               delay = delay - param1;
            }
            else
            {
               timePassed = timePassed + param1;
               _loc2_ = timePassed / duration;
               if(_loc2_ >= 1)
               {
                  rotation = newRotation;
               }
               else if(_loc2_ > 0)
               {
                  if(tweenStyle == 1)
                  {
                     rotation = oldRotation * (1 - _loc2_) + _loc2_ * newRotation;
                  }
               }
            }
         }
         if(rotation == rotation)
         {
            setupAngle(rotation);
         }
         else
         {
            setupAngle(0);
         }
      }
      
      public function registerWeaponJoint(param1:Matrix, param2:Boolean = false) : void
      {
         hasJoint = true;
         this.fadePhase = param2;
         if(param1)
         {
            lastJoint.x = param1.tx;
            lastJoint.y = param1.ty;
         }
         else
         {
            lastJoint.x = 0;
            lastJoint.y = 0;
         }
      }
      
      public function dropWeaponJoint() : void
      {
         hasJoint = false;
      }
      
      public function apply(param1:Matrix, param2:DisplayObject) : void
      {
         var _loc3_:Matrix = tempMatrix;
         _loc3_.a = param1.a;
         _loc3_.b = param1.b;
         _loc3_.c = param1.c;
         _loc3_.d = param1.d;
         _loc3_.tx = param1.tx - lastJoint.x;
         _loc3_.ty = param1.ty - lastJoint.y;
         _loc3_.concat(_transform);
         _loc3_.tx = _loc3_.tx + lastJoint.x;
         _loc3_.ty = _loc3_.ty + lastJoint.y;
         param2.transformationMatrix = _loc3_;
      }
      
      private function setupAngle(param1:Number) : void
      {
         _transform.a = Math.cos(param1);
         _transform.b = Math.sin(param1) * mirrorMultiplier;
         _transform.c = -Math.sin(param1) * mirrorMultiplier;
         _transform.d = Math.cos(param1);
      }
   }
}
