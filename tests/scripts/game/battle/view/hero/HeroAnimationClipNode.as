package game.battle.view.hero
{
   import battle.BattleEngine;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class HeroAnimationClipNode extends StarlingClipNode
   {
       
      
      const layerContainers:Vector.<ZSortedSprite> = new Vector.<ZSortedSprite>();
      
      private const layerIndices:Vector.<int> = new Vector.<int>();
      
      private var zPosition:Number;
      
      private var zRadius:Number;
      
      public const weaponTransform:HeroViewWeaponRotation = new HeroViewWeaponRotation();
      
      public var shadowAlpha:Number = 1;
      
      public function HeroAnimationClipNode(param1:Sprite)
      {
         super(param1);
      }
      
      override public final function get graphics() : Sprite
      {
         if(layerContainers.length > 0)
         {
            return layerContainers[0];
         }
         return view;
      }
      
      public function get lastClip() : Clip
      {
         return clip;
      }
      
      public function updateLayersState(param1:State) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function setTransformationMatrix(param1:Matrix = null) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function updateLayersZ(param1:Number, param2:Number) : void
      {
      }
      
      public function setClip(param1:Clip) : void
      {
         var _loc5_:int = 0;
         var _loc7_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = null;
         layerIndices.length = 0;
         var _loc3_:Vector.<Node> = (param1.timeLine[0] as Container).nodes;
         var _loc4_:int = _loc3_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = _loc3_[_loc5_];
            if(_loc7_.clip.marker)
            {
               if(_loc7_.clip.className == "MARKER_ZSPLIT" || _loc7_.clip.className == "MARKER_RECT_MASK" || _loc7_.clip.className == "MARKER_NO_MASK")
               {
                  layerIndices.push(_loc7_.layer);
               }
            }
            _loc5_++;
         }
         _loc4_ = layerIndices.length;
         _loc5_ = layerContainers.length;
         while(_loc5_ < _loc4_)
         {
            layerContainers[_loc5_] = new ZSortedSprite();
            _loc5_++;
         }
         layerContainers[_loc5_] = new ZSortedSprite();
         layerContainers.length = _loc4_ + 1;
         var _loc8_:int = 0;
         var _loc6_:int = layerIndices.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = layerIndices[_loc5_];
            if(_loc4_ <= children.length)
            {
               _loc2_ = layerContainers[_loc5_];
               while(_loc8_ < _loc4_)
               {
                  _loc9_ = children[_loc8_];
                  if(_loc9_)
                  {
                     _loc2_.addChild(_loc9_.graphics);
                  }
                  _loc8_++;
               }
               _loc5_++;
               continue;
            }
            break;
         }
         _loc4_ = children.length;
         _loc2_ = layerContainers[_loc5_];
         while(_loc8_ < _loc4_)
         {
            _loc9_ = children[_loc8_];
            if(_loc9_)
            {
               _loc2_.addChild(_loc9_.graphics);
            }
            _loc8_++;
         }
      }
      
      override protected function setContainer(param1:Container, param2:int, param3:ClipSkin) : void
      {
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc7_:* = null;
         var _loc14_:* = null;
         super.setContainer(param1,param2,param3);
         weaponTransform.dropWeaponJoint();
         var _loc8_:Vector.<Node> = param1.nodes;
         var _loc9_:uint = _loc8_.length;
         if(_loc9_ == 0)
         {
            return;
         }
         var _loc13_:Boolean = true;
         var _loc12_:int = 0;
         var _loc10_:* = false;
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc9_)
         {
            _loc7_ = _loc8_[_loc11_];
            if(_loc7_.clip.className == "MARKER_ZSPLIT")
            {
               layerContainers[_loc6_].clipRect = _loc5_;
               _loc6_++;
               _loc12_ = 0;
            }
            else if(_loc7_.clip.className == "MARKER_RECT_MASK")
            {
               layerContainers[_loc6_].clipRect = _loc5_;
               _loc6_++;
               _loc12_ = 0;
               layerContainers[_loc6_].clipRect = _loc7_.clip.bounds;
               _loc5_ = layerContainers[_loc6_].clipRect;
               _loc5_.width = _loc5_.width * (_loc7_.state.matrix.a * BattleEngine.ASSET_SCALE);
               _loc5_.height = _loc5_.height * (_loc7_.state.matrix.d * BattleEngine.ASSET_SCALE);
               _loc5_.x = _loc5_.x * BattleEngine.ASSET_SCALE + _loc7_.state.matrix.tx;
               _loc5_.y = _loc5_.y * BattleEngine.ASSET_SCALE + _loc7_.state.matrix.ty;
            }
            else if(_loc7_.clip.className == "MARKER_NO_MASK")
            {
               layerContainers[_loc6_].clipRect = _loc5_;
               _loc6_++;
               _loc12_ = 0;
               _loc5_ = null;
            }
            else if(_loc7_.clip.className == "MARKER_WEAPON_JOINT")
            {
               _loc10_ = !_loc10_;
               if(_loc10_)
               {
                  weaponTransform.registerWeaponJoint(_loc7_.state.matrix);
               }
            }
            else if(_loc7_.clip.className == "MARKER_WEAPON_JOINT_FADE")
            {
               _loc10_ = !_loc10_;
               if(_loc10_)
               {
                  weaponTransform.registerWeaponJoint(_loc7_.state.matrix,true);
               }
            }
            else
            {
               _loc14_ = children[_loc7_.layer].graphics;
               if(_loc10_)
               {
                  weaponTransform.apply(_loc7_.state.matrix,_loc14_);
               }
               layerContainers[_loc6_].addChild(_loc14_);
               if(_loc7_.clip.className == "shadow")
               {
                  _loc14_.alpha = shadowAlpha;
               }
               _loc12_++;
            }
            _loc11_++;
         }
         layerContainers[_loc6_].clipRect = _loc5_;
      }
      
      override protected function createLayer(param1:uint) : StarlingClipNode
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(children.length <= param1)
         {
            children.length = param1 + 1;
         }
         var _loc6_:* = createInternal(param1);
         children[param1] = _loc6_;
         var _loc5_:StarlingClipNode = _loc6_;
         var _loc4_:int = layerIndices.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = layerIndices[_loc2_];
            if(param1 < _loc3_)
            {
               layerContainers[_loc2_].addChild(_loc5_.graphics);
               break;
            }
            if(param1 != _loc3_)
            {
               _loc2_++;
               continue;
            }
            break;
         }
         if(_loc2_ == _loc4_)
         {
            layerContainers[_loc2_].addChild(_loc5_.graphics);
         }
         childrenCount = Number(childrenCount) + 1;
         return _loc5_;
      }
   }
}
