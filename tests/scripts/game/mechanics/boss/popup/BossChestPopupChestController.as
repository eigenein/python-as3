package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.State;
   import engine.core.animation.ZSortedSprite;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipFactory;
   import engine.core.clipgui.GuiMarker;
   import engine.core.utils.MathUtil;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.mechanics.boss.mediator.BossChestPopupValueObject;
   import game.mechanics.boss.model.CommandBossOpenChest;
   import game.model.user.inventory.InventoryItem;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class BossChestPopupChestController implements IAnimatable
   {
      
      protected static const MOVEMENT_DELAY:Number = 1.5;
      
      protected static const MOVEMENT_DELAY_FAST:Number = 0.4;
      
      protected static const POSITION_TRANSITION_DURATION:Number = 1.1;
      
      protected static const POSITION_TRANSITION_DURATION_FAST:Number = 0.9;
       
      
      private const _isLocked:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const factory:GuiClipFactory = new GuiClipFactory();
      
      private const phaseOffsetInterval:Number = 2;
      
      private const wavingAmplitude:Number = 16;
      
      private const mainChestIndex:int = 4;
      
      private const staticChestsCount:int = 4;
      
      private var chestClip:Clip;
      
      private var tempKeyframe:BossChestAnimationKeyframe;
      
      private var points:Vector.<BossChestAnimationKeyframe>;
      
      private var chests:Vector.<BossChestAnimationView>;
      
      protected var fastMovement:Boolean = false;
      
      private var movementDelay:Number = 0;
      
      private var smoothPositionTarget:Number = 0;
      
      private var wavingPhase:Number = 0;
      
      private var smoothPosition:Number = 0;
      
      private var positionTransitionProgress:Number = 0;
      
      private var positionTransitionDuration:Number = 0;
      
      private var _items:Vector.<InventoryItem>;
      
      public const container:ZSortedSprite = new ZSortedSprite();
      
      public const openedChestsCount:int = 2;
      
      public const closedChestsCount:int = 4;
      
      public function BossChestPopupChestController(param1:Vector.<GuiMarker>, param2:Vector.<ClipSprite>)
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         tempKeyframe = new BossChestAnimationKeyframe();
         points = new Vector.<BossChestAnimationKeyframe>();
         chests = new Vector.<BossChestAnimationView>();
         _items = new Vector.<InventoryItem>();
         super();
         var _loc5_:int = param1.length;
         chestClip = param1[0].clip;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1[_loc6_].graphics;
            _loc7_ = param1[_loc6_].state;
            _loc8_ = new BossChestAnimationKeyframe();
            _loc8_.x = _loc7_.matrix.tx;
            _loc8_.y = _loc7_.matrix.ty;
            _loc8_.z = _loc3_.parent.getChildIndex(_loc3_);
            _loc8_.scale = _loc7_.matrix.a;
            points.push(_loc8_);
            _loc6_++;
         }
         _loc5_ = param2.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param2[_loc6_].graphics as ZSortedSprite;
            _loc4_.z = _loc4_.parent.getChildIndex(_loc4_);
            _loc6_++;
         }
         _loc5_ = param2.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            container.addChild(param2[_loc6_].graphics);
            _loc6_++;
         }
         Starling.juggler.add(this);
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
      
      public function get inMotion() : BooleanProperty
      {
         return _isLocked;
      }
      
      public function set position(param1:Number) : void
      {
         smoothPosition = param1;
         smoothPositionTarget = param1;
      }
      
      public function setupPositionOffset(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = NaN;
         container.resortChildren();
         wavingPhase = wavingPhase + param1 * 0.2;
         if(movementDelay > 0)
         {
            movementDelay = movementDelay - param1;
         }
         if(movementDelay <= 0)
         {
            if(positionTransitionDuration > 0)
            {
               positionTransitionProgress = positionTransitionProgress + param1;
               _loc3_ = positionTransitionProgress / positionTransitionDuration;
               if(_loc3_ > 1)
               {
                  stopMotion();
                  _loc2_ = 1;
               }
               else if(fastMovement)
               {
                  _loc2_ = Number(MathUtil.mapSin(_loc3_,0.9));
               }
               else
               {
                  _loc2_ = Number(MathUtil.mapSin(_loc3_,0.9));
               }
               setupPositionOffset(smoothPosition * (1 - _loc2_) + smoothPositionTarget * _loc2_);
            }
            else
            {
               setupPositionOffset(smoothPosition);
            }
         }
         else
         {
            setupPositionOffset(smoothPosition);
         }
      }
      
      public function setChestOpened(param1:CommandBossOpenChest) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function setCurrent(param1:int, param2:Boolean) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addChest(param1:BossChestPopupValueObject, param2:Boolean) : void
      {
         var _loc3_:BossChestAnimationView = createChest();
         _loc3_.vo = param1;
         _loc3_.phaseOffset = _loc3_.vo.chestNum * 2;
         _loc3_.clip.setValueObject(param1,param2);
         chests.unshift(_loc3_);
         var _loc5_:int = points.length;
         var _loc4_:int = chests.length;
         if(_loc4_ > _loc5_)
         {
            _loc4_--;
            while(_loc4_ < _loc5_)
            {
               chests[_loc4_].clip.dispose();
               _loc4_++;
            }
            chests.length = _loc5_;
         }
      }
      
      protected function createChest() : BossChestAnimationView
      {
         var _loc1_:BossChestAnimationView = new BossChestAnimationView();
         _loc1_.clip = new BossChestPanelClip();
         _loc1_.phaseOffset = chests.length * 2;
         _loc1_.pushOffset = 0;
         _loc1_.pushSpeed = 0;
         _loc1_.clip.signal_item.addOnce(handler_chestOpened);
         factory.create(_loc1_.clip,chestClip);
         container.addChild(_loc1_.clip.graphics);
         return _loc1_;
      }
      
      protected function getPosition(param1:Number) : BossChestAnimationKeyframe
      {
         var _loc7_:int = param1;
         var _loc5_:Number = param1 % 1;
         var _loc4_:BossChestAnimationKeyframe = points[_loc7_];
         var _loc2_:BossChestAnimationKeyframe = points[_loc7_ + 1];
         var _loc3_:BossChestAnimationKeyframe = points[_loc7_ + 2];
         var _loc6_:BossChestAnimationKeyframe = points[_loc7_ + 3];
         tempKeyframe.x = getSplineValue(_loc4_.x,_loc2_.x,_loc3_.x,_loc6_.x,_loc5_);
         tempKeyframe.y = getSplineValue(_loc4_.y,_loc2_.y,_loc3_.y,_loc6_.y,_loc5_);
         tempKeyframe.z = getSplineValue(_loc4_.z,_loc2_.z,_loc3_.z,_loc6_.z,_loc5_);
         tempKeyframe.scale = getSplineValue(_loc4_.scale,_loc2_.scale,_loc3_.scale,_loc6_.scale,_loc5_);
         return tempKeyframe;
      }
      
      protected function startMotion(param1:Number) : void
      {
         movementDelay = !!fastMovement?0.4:1.5;
         smoothPositionTarget = param1;
         positionTransitionProgress = 0;
         positionTransitionDuration = !!fastMovement?0.9:1.1;
         fastMovement = true;
      }
      
      protected function stopMotion() : void
      {
         positionTransitionDuration = 0;
         smoothPosition = smoothPositionTarget;
         _isLocked.value = false;
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
      
      private function pushChest(param1:BossChestAnimationView) : void
      {
         param1.pushSpeed = 8;
      }
      
      private function handler_chestOpened(param1:BossChestPanelClip) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}

import flash.geom.Point;

class BossChestAnimationKeyframe extends Point
{
    
   
   public var z:Number;
   
   public var scale:Number;
   
   function BossChestAnimationKeyframe()
   {
      super();
   }
}

import game.mechanics.boss.mediator.BossChestPopupValueObject;
import game.mechanics.boss.popup.BossChestPanelClip;

class BossChestAnimationView
{
    
   
   public var clip:BossChestPanelClip;
   
   public var phaseOffset:Number;
   
   public var pushOffset:Number;
   
   public var pushSpeed:Number;
   
   public var vo:BossChestPopupValueObject;
   
   function BossChestAnimationView()
   {
      super();
   }
}
