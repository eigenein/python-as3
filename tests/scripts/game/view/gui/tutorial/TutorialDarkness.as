package game.view.gui.tutorial
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class TutorialDarkness extends TutorialDarknessFragmentCircle implements IAnimatable
   {
      
      private static const MAX_RADIUS:Number = 600;
      
      private static const INITIAL_ALPHA:Number = 0;
      
      private static const FINAL_ALPHA:Number = 0.65;
      
      private static const FOCUS_DURATION:Number = 1;
       
      
      private var focusDuration:Number = 1.3;
      
      private var focusProgress:Number = 0;
      
      private var isFocusing:Boolean = false;
      
      private var targetR:Number = 0;
      
      private var target:ITutorialButton;
      
      private var targetRectangle:Rectangle;
      
      private var tempLocal00:Point;
      
      private var tempGlobal:Point;
      
      public function TutorialDarkness()
      {
         targetRectangle = new Rectangle();
         tempLocal00 = new Point();
         tempGlobal = new Point();
         super(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight,4278190080);
         touchable = false;
      }
      
      public function get focus() : ITutorialButton
      {
         return target;
      }
      
      public function flatScreen() : void
      {
         if(target)
         {
            removeCurrentTarget();
         }
         circleR = 0;
         isFocusing = false;
         visible = true;
         alpha = 0.65;
      }
      
      public function focusOn(param1:ITutorialButton) : void
      {
         if(this.target == param1)
         {
            return;
         }
         setTarget(param1);
         startFocusing();
      }
      
      public function getTargetBounds() : Rectangle
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         if(!target)
         {
            return null;
         }
         var _loc4_:DisplayObject = target.graphics;
         if(target is ITutorialButtonBoundsProvider)
         {
            _loc1_ = new Rectangle();
            _loc4_.localToGlobal(tempLocal00,tempGlobal);
            _loc3_ = target as ITutorialButtonBoundsProvider;
            _loc2_ = _loc3_.tutorialButtonRadius;
            _loc1_.x = tempGlobal.x - _loc2_;
            _loc1_.y = tempGlobal.y - _loc2_;
            _loc1_.width = _loc2_ * 2;
            _loc1_.height = _loc2_ * 2;
            return _loc1_;
         }
         return _loc4_.getBounds(_loc4_.stage);
      }
      
      public function updateTargetSize() : void
      {
         var _loc1_:* = null;
         if(!target)
         {
            return;
         }
         var _loc2_:DisplayObject = target.graphics;
         if(target is ITutorialButtonBoundsProvider)
         {
            _loc2_.localToGlobal(tempLocal00,tempGlobal);
            _loc1_ = target as ITutorialButtonBoundsProvider;
            circleCenterX = tempGlobal.x + _loc1_.tutorialButtonOffsetX;
            circleCenterY = tempGlobal.y + _loc1_.tutorialButtonOffsetY;
            targetR = _loc1_.tutorialButtonRadius;
         }
         else
         {
            _loc2_.getBounds(_loc2_.stage,targetRectangle);
            circleCenterX = targetRectangle.x + targetRectangle.width * 0.5;
            circleCenterY = targetRectangle.y + targetRectangle.height * 0.5;
            targetR = Math.sqrt(targetRectangle.width * targetRectangle.width + targetRectangle.height * targetRectangle.height) / 2;
         }
      }
      
      public function hide() : void
      {
         setTarget(null);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(!visible)
         {
            return;
         }
         if(isFocusing)
         {
            updateTargetSize();
            if(focusProgress < 1)
            {
               focusProgress = focusProgress + param1 / 1;
            }
            else
            {
               focusProgress = 1;
               isFocusing = false;
               Starling.juggler.remove(this);
            }
            _loc2_ = 1 - focusProgress;
            _loc2_ = 1 - _loc2_ * _loc2_;
            circleR = (1 - _loc2_) * 600 + _loc2_ * targetR;
            alpha = (1 - _loc2_) * 0 + _loc2_ * 0.65;
         }
      }
      
      protected function setTarget(param1:ITutorialButton) : void
      {
         if(target)
         {
            removeCurrentTarget();
         }
         target = param1;
         if(!target)
         {
            return;
         }
         if(target.graphics.stage)
         {
            visible = true;
            target.graphics.addEventListener("removedFromStage",onRemovedFromStage);
         }
         else
         {
            visible = false;
            target.graphics.addEventListener("addedToStage",onAddedToStage);
         }
      }
      
      protected function onAddedToStage() : void
      {
         startFocusing();
         target.graphics.removeEventListener("addedToStage",onAddedToStage);
         target.graphics.addEventListener("removedFromStage",onRemovedFromStage);
         visible = true;
      }
      
      protected function onRemovedFromStage() : void
      {
         target.graphics.removeEventListener("removedFromStage",onRemovedFromStage);
         target.graphics.addEventListener("addedToStage",onAddedToStage);
         visible = false;
      }
      
      protected function startFocusing() : void
      {
         circleR = 600;
         alpha = 0;
         focusProgress = 0;
         if(!isFocusing)
         {
            isFocusing = true;
            Starling.juggler.add(this);
         }
      }
      
      protected function removeCurrentTarget() : void
      {
         if(target)
         {
            target.graphics.removeEventListener("removedFromStage",onRemovedFromStage);
            target.graphics.removeEventListener("addedToStage",onAddedToStage);
            target = null;
         }
      }
   }
}
