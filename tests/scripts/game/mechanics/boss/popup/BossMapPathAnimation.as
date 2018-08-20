package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Clip;
   import engine.core.animation.Animation;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class BossMapPathAnimation
   {
      
      private static const TWEEN_ALPHA_ON_SCREEN_EDGES:Boolean = false;
       
      
      private var animations:Vector.<BossMapPathAnimationParticle>;
      
      private var _p:Point;
      
      private var points:Vector.<Point>;
      
      private var alphaPhase:Number = 0;
      
      public const graphics:Sprite = new Sprite();
      
      public function BossMapPathAnimation(param1:Vector.<Point>, param2:Clip)
      {
         var _loc3_:* = NaN;
         animations = new Vector.<BossMapPathAnimationParticle>();
         _p = new Point();
         super();
         this.points = param1;
         var _loc5_:int = param1.length + 1;
         var _loc6_:* = 0.07;
         addEdgePoints(200,350);
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            animations.push(createParticle(_loc3_,param2));
            _loc3_ = Number(_loc3_ + Math.random() * _loc6_);
         }
         alphaPhase = 0;
         graphics.addEventListener("enterFrame",onEnterFrame);
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function createParticle(param1:Number, param2:Clip) : BossMapPathAnimationParticle
      {
         var _loc3_:BossMapPathAnimationParticle = new BossMapPathAnimationParticle();
         _loc3_.time = param1;
         _loc3_.animation = new Animation(param2);
         _loc3_.alphaPhaseOffset = Math.random() * 3.14159265358979 * 2;
         var _loc4_:DisplayObject = _loc3_.animation.graphics;
         var _loc5_:* = 0.2 + Math.random() * 0.7;
         _loc4_.scaleY = _loc5_;
         _loc4_.scaleX = _loc5_;
         _loc4_.rotation = Math.random() * 3.14159265358979 * 2;
         graphics.addChild(_loc4_);
         return _loc3_;
      }
      
      protected function updateParticle(param1:BossMapPathAnimationParticle, param2:Number) : void
      {
         param1.animation.advanceTime(param2);
         var _loc7_:Point = getDerivative(int(param1.time),param1.time % 1);
         param1.time = param1.time + 20 * param2 / Math.sqrt(_loc7_.x * _loc7_.x + _loc7_.y * _loc7_.y);
         var _loc4_:Number = points.length - 3;
         if(param1.time > _loc4_)
         {
            param1.time = param1.time - _loc4_;
         }
         var _loc5_:DisplayObject = param1.animation.graphics;
         var _loc3_:Point = getValue(int(param1.time),param1.time % 1);
         var _loc6_:Number = 1 + Math.cos(alphaPhase + param1.alphaPhaseOffset);
         _loc5_.x = _loc3_.x;
         _loc5_.y = _loc3_.y;
         _loc5_.alpha = _loc6_;
         _loc5_.rotation = _loc5_.rotation + param2 * 0.3;
      }
      
      private function addEdgePoints(param1:Number, param2:Number) : void
      {
         if(points.length == 0)
         {
            return;
         }
         var _loc4_:Point = points[0];
         var _loc3_:Point = points[points.length - 1];
         points.unshift(new Point(_loc4_.x - param1,_loc4_.y));
         points.unshift(new Point(_loc4_.x - param2,_loc4_.y));
         points.push(new Point(_loc3_.x + param1,_loc3_.y));
         points.push(new Point(_loc3_.x + param2,_loc3_.y));
      }
      
      private function getValue(param1:int, param2:Number) : Point
      {
         var _loc5_:Point = points[param1];
         var _loc3_:Point = points[param1 + 1];
         var _loc4_:Point = points[param1 + 2];
         var _loc6_:Point = points[param1 + 3];
         _p.x = getSplineValue(_loc5_.x,_loc3_.x,_loc4_.x,_loc6_.x,param2);
         _p.y = getSplineValue(_loc5_.y,_loc3_.y,_loc4_.y,_loc6_.y,param2);
         return _p;
      }
      
      private function getDerivative(param1:int, param2:Number) : Point
      {
         var _loc5_:Point = points[param1];
         var _loc3_:Point = points[param1 + 1];
         var _loc4_:Point = points[param1 + 2];
         var _loc6_:Point = points[param1 + 3];
         _p.x = getSplineDerivative(_loc5_.x,_loc3_.x,_loc4_.x,_loc6_.x,param2);
         _p.y = getSplineDerivative(_loc5_.y,_loc3_.y,_loc4_.y,_loc6_.y,param2);
         return _p;
      }
      
      private function getSplineValue(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         var _loc6_:Number = (param2 - param3) * 1.5 + (param4 - param1) * 0.5;
         var _loc7_:Number = param3 * 2 - param2 * 2.5 - param4 * 0.5 + param1;
         var _loc8_:Number = (param3 - param1) * 0.5;
         var _loc9_:* = param2;
         return _loc6_ * param5 * param5 * param5 + _loc7_ * param5 * param5 + _loc8_ * param5 + _loc9_;
      }
      
      private function getSplineDerivative(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number
      {
         var _loc6_:Number = (param2 - param3) * 1.5 + (param4 - param1) * 0.5;
         var _loc7_:Number = param3 * 2 - param2 * 2.5 - param4 * 0.5 + param1;
         var _loc8_:Number = (param3 - param1) * 0.5;
         return 3 * _loc6_ * param5 * param5 + 2 * _loc7_ * param5 + _loc8_;
      }
   }
}

import engine.core.animation.Animation;

class BossMapPathAnimationParticle
{
    
   
   public var time:Number;
   
   public var animation:Animation;
   
   public var alphaPhaseOffset:Number;
   
   function BossMapPathAnimationParticle()
   {
      super();
   }
}
