package game.mechanics.grand.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import engine.core.utils.MathUtil;
   import flash.geom.Point;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.DataClipButton;
   import game.view.popup.team.GrandTeamSelectorClip;
   import starling.core.Starling;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class GrandSelectorButton extends DataClipButton
   {
       
      
      private var inDrag:Boolean;
      
      private var dragWasApplied:Boolean;
      
      private var dragPosition:Point;
      
      private var dragTargetY:Number;
      
      public var block_number:GrandTeamGatherTeamNumber;
      
      public var tf_label:ClipLabel;
      
      public var tf_count:ClipLabel;
      
      public var glow:GuiClipScale9Image;
      
      public var selector:GuiClipScale9Image;
      
      private var selectorBlock:GrandTeamSelectorClip;
      
      private var snapPositions:Vector.<Number>;
      
      private var buttons:Vector.<GrandSelectorButton>;
      
      private var _snapIndex:int;
      
      private var xInitial:Number;
      
      private var xDragSnap:Number;
      
      public function GrandSelectorButton()
      {
         super(int);
      }
      
      public function set snapIndex(param1:int) : void
      {
         _snapIndex = param1;
         block_number.text = String(param1 + 1);
      }
      
      public function animate() : void
      {
         Starling.juggler.removeTweens(glow.graphics);
         Starling.juggler.tween(glow.graphics,0.25,{
            "alpha":1,
            "transition":"easeOut"
         });
         Starling.juggler.tween(glow.graphics,0.4,{
            "alpha":0,
            "transition":"easeIn",
            "delay":0.25
         });
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         glow.graphics.alpha = 0;
         glow.graphics.blendMode = "add";
         graphics.addEventListener("enterFrame",handler_enterFrame);
         xInitial = graphics.x;
         xDragSnap = xInitial + 20;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         if(param1 == "down")
         {
            startDrag();
         }
      }
      
      public function setButtonPositions(param1:GrandTeamSelectorClip, param2:Vector.<Number>, param3:Vector.<GrandSelectorButton>, param4:int) : void
      {
         this.selectorBlock = param1;
         this.snapPositions = param2;
         this.buttons = param3;
         this._snapIndex = param4;
      }
      
      override protected function getClickData() : *
      {
         return _snapIndex;
      }
      
      protected function startDrag() : void
      {
         inDrag = true;
         graphics.stage.addEventListener("touch",handler_updateMousePosition);
      }
      
      protected function stopDrag() : void
      {
         inDrag = false;
         _snapIndex = getSnapIndex(dragTargetY);
         graphics.stage.removeEventListener("touch",handler_updateMousePosition);
         dragPosition = null;
         dragWasApplied = false;
      }
      
      private function handler_updateMousePosition(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Touch = param1.getTouch(graphics.stage);
         if(_loc3_)
         {
            if(_loc3_.phase == "ended")
            {
               stopDrag();
               return;
            }
            _loc2_ = graphics.parent.globalToLocal(new Point(_loc3_.globalX,_loc3_.globalY));
            if(dragPosition == null)
            {
               dragPosition = _loc2_.clone();
               dragPosition.x = dragPosition.x - graphics.x;
               dragPosition.y = dragPosition.y - graphics.y;
            }
            if(dragPosition.x != _loc2_.x - graphics.x || dragPosition.y != _loc2_.y - graphics.y)
            {
               dragWasApplied = true;
            }
            dragTargetY = MathUtil.clamp(_loc2_.y - dragPosition.y,snapPositions[0],snapPositions[snapPositions.length - 1]);
         }
      }
      
      protected function getSnapIndex(param1:Number) : Number
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!inDrag)
         {
            graphics.x = graphics.x * 0.5 + 0.5 * xInitial;
            graphics.y = graphics.y * 0.65 + 0.35 * snapPositions[_snapIndex];
         }
         else if(dragPosition)
         {
            _loc2_ = getSnapIndex(dragTargetY);
            if(_snapIndex != _loc2_)
            {
               selectorBlock.changeButtonIndices(_snapIndex,_loc2_);
            }
            if(dragWasApplied)
            {
               graphics.x = graphics.x * 0.5 + 0.5 * xDragSnap;
            }
            graphics.y = graphics.y * 0.5 + 0.2 * snapPositions[_snapIndex] + 0.3 * dragTargetY;
         }
      }
   }
}
