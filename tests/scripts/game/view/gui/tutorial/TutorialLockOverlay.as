package game.view.gui.tutorial
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Sprite;
   
   public class TutorialLockOverlay extends Sprite
   {
       
      
      public const targetUpdated:Signal = new Signal();
      
      private var targets:Vector.<ITutorialButton>;
      
      private var helperLocalPoint:Point;
      
      private var helperGlobalPoint:Point;
      
      private var helperPointResult:Point;
      
      private var container:DisplayObjectContainer;
      
      private var hasVisibleTargets:Boolean = false;
      
      private var hidden:Boolean = true;
      
      private var darkLayer:TutorialDarkness;
      
      private var _lockAll:Boolean;
      
      public function TutorialLockOverlay(param1:DisplayObjectContainer)
      {
         targets = new Vector.<ITutorialButton>();
         helperLocalPoint = new Point();
         helperGlobalPoint = new Point();
         helperPointResult = new Point();
         darkLayer = new TutorialDarkness();
         super();
         this.container = param1;
         addChild(darkLayer);
      }
      
      public function get isEnabled() : Boolean
      {
         return targets.length;
      }
      
      public function get inputIsBlocked() : Boolean
      {
         return _lockAll || hasVisibleTargets;
      }
      
      public function getTargetBounds() : Rectangle
      {
         if(!inputIsBlocked)
         {
            return null;
         }
         return darkLayer.getTargetBounds();
      }
      
      public function setTargets(param1:Vector.<ITutorialButton>) : void
      {
         this.targets = param1;
         updateVisibleTargets();
      }
      
      public function lockAll() : void
      {
         _lockAll = true;
         updateVisibleTargets();
      }
      
      public function unlockAll() : void
      {
         _lockAll = false;
         updateVisibleTargets();
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateVisibleTargets() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateHidden() : void
      {
         var _loc1_:Boolean = !_lockAll && !hasVisibleTargets;
         if(hidden != _loc1_)
         {
            hidden = _loc1_;
            if(hidden)
            {
               container.removeChild(this);
            }
            else
            {
               container.addChildAt(this,0);
            }
         }
         if(_lockAll)
         {
            darkLayer.flatScreen();
         }
         targetUpdated.dispatch();
      }
      
      protected function isVisible(param1:DisplayObject) : Boolean
      {
         return param1.stage && param1.visible;
      }
   }
}
