package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.utils.MathUtil;
   import feathers.layout.VerticalLayout;
   import feathers.utils.math.roundToNearest;
   import flash.geom.Matrix;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class QuestEventList extends GameScrolledAlphaGradientList
   {
       
      
      private var arrowUp:ClipButton;
      
      private var arrowDown:ClipButton;
      
      private var markerTopPosition:Matrix;
      
      private var markerBottomPosition:Matrix;
      
      private var markerTop:ClipSprite;
      
      private var markerBottom:ClipSprite;
      
      private var topMarkerIndex:int = 2147483647;
      
      private var bottomMarkerIndex:int = -2147483648;
      
      protected var _tween_top:Tween;
      
      protected var _tween_bottom:Tween;
      
      public function QuestEventList(param1:GameScrollBar, param2:ClipButton, param3:ClipButton, param4:ClipSprite, param5:ClipSprite)
      {
         _tween_top = new Tween(null,0.3,"linear");
         _tween_bottom = new Tween(null,0.3,"linear");
         super(param1,10);
         param2.signal_click.add(handler_arrowUp);
         param3.signal_click.add(handler_arrowDown);
         this.markerTop = param4;
         this.markerBottom = param5;
         this.arrowUp = param2;
         this.arrowDown = param3;
         updateButton(param2,null,false);
         updateButton(param3,null,false);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         updateButton(arrowUp,null,false);
         updateButton(arrowDown,null,false);
      }
      
      public function updateMarkersIndices() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateButton(param1:ClipButton, param2:Tween, param3:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         param1.isEnabled = param3;
         var _loc4_:Number = !!param3?1:0.3;
         if(param2)
         {
            param2.reset(param1.graphics,0.3,"linear");
            param2.fadeTo(_loc4_);
            Starling.juggler.add(param2);
         }
         else
         {
            param1.graphics.alpha = _loc4_;
         }
      }
      
      override protected function refreshExternalScrollElements() : void
      {
         if(isTopmostPosition && isLowestPosition)
         {
            arrowUp.isEnabled = false;
            arrowDown.isEnabled = false;
            arrowUp.graphics.alpha = 0;
            arrowDown.graphics.alpha = 0;
            _bottomGradientVisible = false;
            _topGradientVisible = false;
         }
         else
         {
            if(isTopmostPosition == _topGradientVisible)
            {
               updateButton(arrowUp,_tween_top,!_topGradientVisible);
            }
            if(isLowestPosition == _bottomGradientVisible)
            {
               updateButton(arrowDown,_tween_bottom,!_bottomGradientVisible);
            }
         }
         super.refreshExternalScrollElements();
      }
      
      override protected function refreshScrollBarValues() : void
      {
         super.refreshScrollBarValues();
         refreshMarkers();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("data"))
         {
            updateMarkersIndices();
         }
      }
      
      protected function refreshMarkers() : void
      {
         var _loc12_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:* = NaN;
         var _loc2_:Number = NaN;
         if(!markerTopPosition)
         {
            markerTopPosition = markerTop.graphics.transformationMatrix.clone();
            markerBottomPosition = markerBottom.graphics.transformationMatrix.clone();
            markerTopPosition.tx = markerTopPosition.tx + markerTop.graphics.width * 0.5;
            markerTopPosition.ty = markerTopPosition.ty + markerTop.graphics.height * 0.5;
            markerBottomPosition.tx = markerBottomPosition.tx + markerBottom.graphics.width * 0.5;
            markerBottomPosition.ty = markerBottomPosition.ty + markerBottom.graphics.height * 0.5;
         }
         var _loc1_:DisplayObject = (layout as VerticalLayout).typicalItem;
         var _loc10_:Number = (layout as VerticalLayout).gap;
         var _loc11_:Number = (layout as VerticalLayout).paddingTop;
         var _loc5_:* = 4;
         var _loc13_:* = 12;
         if(_loc1_ && topMarkerIndex < 2147483647)
         {
            _loc12_ = topMarkerIndex * (_loc1_.height + _loc10_) - verticalScrollPosition + _loc11_;
            _loc7_ = markerTopPosition.ty;
            _loc3_ = y + _loc5_ + _loc13_ + _loc11_;
            _loc8_ = _loc12_ + y + _loc5_ + _loc13_;
            _loc9_ = MathUtil.clamp((_loc8_ - _loc7_) / (_loc3_ - _loc7_),0,1);
            setupMarkerPosition(markerTop.graphics,markerBottomPosition.tx,_loc9_,_loc7_,_loc3_);
            _loc6_ = bottomMarkerIndex * (_loc1_.height + _loc10_) - verticalScrollPosition;
            _loc7_ = y + height + _loc10_;
            _loc3_ = markerBottomPosition.ty;
            _loc8_ = _loc6_ + y + _loc5_ + _loc13_ + _loc11_;
            _loc9_ = 1 - MathUtil.clamp((_loc8_ - _loc7_) / (_loc3_ - _loc7_),0,1);
            _loc4_ = 0.35;
            if(_loc9_ < _loc4_)
            {
               _loc2_ = _loc4_ - _loc9_;
               _loc9_ = MathUtil.clamp(_loc9_ - _loc2_ * 1.5,0,1);
            }
            setupMarkerPosition(markerBottom.graphics,markerBottomPosition.tx,_loc9_,_loc3_,_loc7_);
         }
         else
         {
            markerTop.graphics.visible = false;
            markerBottom.graphics.visible = false;
         }
      }
      
      private function setupMarkerPosition(param1:DisplayObject, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:* = 0.75;
         var _loc6_:* = 1;
         var _loc8_:* = _loc7_ + (_loc6_ - _loc7_) * Math.pow(param3,0.3);
         param1.scaleY = _loc8_;
         param1.scaleX = _loc8_;
         markerTop.graphics.visible = param3 < 1;
         param1.alpha = (1 - param3) * (1 - param3);
         param1.x = param2 - param1.width * 0.5;
         param1.y = param4 * (1 - param3) + param5 * param3 - param1.height * 0.5;
      }
      
      private function throwByPageToDirection(param1:int) : void
      {
         var _loc2_:Number = roundToNearest(this._verticalScrollPosition,this.actualPageHeight);
         _loc2_ = _loc2_ + param1 * this.actualPageHeight;
         throwTo(NaN,_loc2_);
      }
      
      private function handler_arrowUp() : void
      {
         throwByPageToDirection(-1);
      }
      
      private function handler_arrowDown() : void
      {
         throwByPageToDirection(1);
      }
   }
}
