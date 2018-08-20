package game.battle.view.hero
{
   import battle.proxy.ViewTransform;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.State;
   import engine.core.animation.FastColorMatrix;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.view.animation.ContainerBattleFx;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class HeroViewTransformManager
   {
      
      private static const COLOR_TRANSFORM_ALPHA:int = 1;
      
      private static const COLOR_TRANSFORM_MULTIPLIER:int = 2;
      
      private static const COLOR_TRANSFORM_MATRIX:int = 4;
      
      private static const COLOR_TRANSFORM_NONE:int = 8;
      
      private static const camera0:Point = new Point();
      
      private static const tempMatrix:Matrix = new Matrix();
       
      
      private var lastClip:Clip;
      
      private var _parent:DisplayObjectContainer;
      
      private var _containerFx:Vector.<ContainerBattleFx>;
      
      private var _containerColorTransformIntensity:Number = 1;
      
      private const colorTransform:FastColorMatrix = FastColorMatrix.IDENTITY();
      
      private const resultTransform:ViewTransform = new ViewTransform();
      
      private var layers:Vector.<ZSortedSprite>;
      
      private var blendMode:String;
      
      private var colorTransformMinMode:int;
      
      public var effectsAlpha:Number = 1;
      
      public var scale:Number = 1;
      
      private var animation:HeroAnimationRsx;
      
      public const location:ViewTransform = new ViewTransform();
      
      public const containerTransform:ViewTransform = new ViewTransform();
      
      public function HeroViewTransformManager()
      {
         _containerFx = new Vector.<ContainerBattleFx>();
         super();
      }
      
      public function dispose() : void
      {
         removeFromParent();
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return _parent;
      }
      
      public function set shadowAlpha(param1:Number) : void
      {
         animation.rootNode.shadowAlpha = param1;
      }
      
      public function get visible() : Boolean
      {
         if(colorTransformMinMode & 8 || _parent == null || layers == null || layers.length == 0)
         {
            return false;
         }
         return true;
      }
      
      public function get firstLayer() : ZSortedSprite
      {
         if(layers.length > 0)
         {
            return layers[0];
         }
         return null;
      }
      
      public function setAnimation(param1:HeroAnimationRsx) : void
      {
         this.animation = param1;
      }
      
      public function setParent(param1:DisplayObjectContainer) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this._parent = param1;
         if(layers)
         {
            _loc2_ = layers.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               param1.addChild(layers[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function removeFromParent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_parent)
         {
            if(layers)
            {
               _loc1_ = layers.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _parent.removeChild(layers[_loc2_]);
                  _loc2_++;
               }
            }
            this._parent = null;
         }
      }
      
      public function addContainerAnimation(param1:ContainerBattleFx) : void
      {
         _containerFx.push(param1);
      }
      
      public function removeContainerAnimation(param1:ContainerBattleFx) : void
      {
         var _loc2_:int = _containerFx.indexOf(param1);
         if(_loc2_ != -1)
         {
            _containerFx.splice(_loc2_,1);
         }
      }
      
      public function removeAllContainerAnimations() : void
      {
         _containerFx.length = 0;
      }
      
      public function setPosition(param1:HeroViewPositionValue, param2:Point = null) : void
      {
         if(!param2)
         {
            param2 = camera0;
         }
         if(lastClip != animation.rootNode.lastClip)
         {
            lastClip = animation.rootNode.lastClip;
            updateLayers();
         }
         if(animation)
         {
            animation.direction = param1.direction;
            animation.graphics.visible = param1.visible;
            if(param1.scale != animation.scale)
            {
               animation.scale = param1.scale;
            }
         }
         resultTransform.copyFrom(animation.transformationMatrix);
         applyNestedContainers();
         var _loc4_:* = scale;
         location.d = _loc4_;
         location.a = _loc4_;
         _loc4_ = 0;
         location.tz = _loc4_;
         _loc4_ = _loc4_;
         location.ty = _loc4_;
         _loc4_ = _loc4_;
         location.tx = _loc4_;
         _loc4_ = _loc4_;
         location.c = _loc4_;
         location.b = _loc4_;
         location.concat(containerTransform);
         location.tx = location.tx + (param1.x + param2.x);
         location.ty = location.ty + (param1.y + param2.y);
         location.tz = location.tz + param1.z;
         resultTransform.concat(location);
         resultTransform.tz = resultTransform.tz + location.tz;
         if(layers)
         {
            updateZ(param1.z,param1.size);
         }
         var _loc3_:State = animation.resultState;
         _loc3_.matrix = resultTransform;
         _loc3_.blendMode = blendMode;
         setupStateColor(_loc3_);
      }
      
      public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc4_:* = NaN;
         var _loc3_:* = NaN;
         var _loc8_:int = 0;
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         var _loc7_:int = layers.length;
         if(_loc7_ == 0)
         {
            layers[0].getTransformationMatrix(param1,tempMatrix);
            param2.setTo(tempMatrix.tx,tempMatrix.ty,0,0);
         }
         else if(_loc7_ == 1)
         {
            layers[0].getBounds(param1,param2);
         }
         else
         {
            _loc4_ = 1.79769313486232e308;
            var _loc6_:* = -1.79769313486232e308;
            _loc3_ = 1.79769313486232e308;
            var _loc5_:* = -1.79769313486232e308;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               layers[_loc8_].getBounds(param1,param2);
               if(_loc4_ > param2.x)
               {
                  _loc4_ = Number(param2.x);
               }
               if(_loc6_ < param2.right)
               {
                  _loc6_ = Number(param2.right);
               }
               if(_loc3_ > param2.y)
               {
                  _loc3_ = Number(param2.y);
               }
               if(_loc5_ < param2.bottom)
               {
                  _loc5_ = Number(param2.bottom);
               }
               _loc8_++;
            }
            param2.setTo(_loc4_,_loc3_,_loc6_ - _loc4_,_loc5_ - _loc3_);
         }
         return param2;
      }
      
      private function updateLayers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         layers = animation.rootNode.layerContainers;
         if(_parent)
         {
            _loc1_ = layers.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _parent.addChild(layers[_loc2_]);
               _loc2_++;
            }
         }
      }
      
      private function updateZ(param1:Number, param2:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function applyNestedContainers() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function setupStateColor(param1:State) : void
      {
         var _loc2_:Boolean = colorTransformMinMode & 8;
         if(_loc2_)
         {
            param1.colorMode = 1;
            param1.colorAlpha = 0;
         }
         else if(_containerColorTransformIntensity == 0)
         {
            param1.colorMode = 0;
         }
         else if(colorTransformMinMode & 4)
         {
            param1.colorMode = 3;
            param1.colorMatrix = colorTransform.getVector();
         }
         else if(colorTransformMinMode & 2)
         {
            param1.colorMode = 2;
            param1.colorMultiplier = colorTransform.colorMultiplier;
         }
         else if(colorTransformMinMode & 1)
         {
            param1.colorMode = 1;
            param1.colorAlpha = colorTransform.mA3;
         }
         else
         {
            param1.colorMode = 0;
         }
      }
   }
}
