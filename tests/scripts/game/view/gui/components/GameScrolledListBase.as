package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.IGuiClip;
   import feathers.controls.IDirectionalScrollBar;
   import feathers.controls.IScrollBar;
   import feathers.controls.ScrollBar;
   import feathers.layout.TiledRowsLayout;
   import feathers.utils.math.roundToNearest;
   import game.view.gui.components.list.ItemList;
   import starling.animation.Tween;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class GameScrolledListBase extends ItemList implements IGuiClip
   {
       
      
      protected var tween_top:Tween;
      
      protected var tween_bottom:Tween;
      
      protected var tweenDuration:Number = 0.1;
      
      protected var externalSlider:GameScrollBar;
      
      public function GameScrolledListBase(param1:GameScrollBar)
      {
         super();
         this.externalSlider = param1;
         createLayout();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      protected function get isTopmostPosition() : Boolean
      {
         return _targetVerticalScrollPosition == 0 && _verticalAutoScrollTween || _verticalScrollPosition == 0;
      }
      
      protected function get isLowestPosition() : Boolean
      {
         return _targetVerticalScrollPosition == maxVerticalScrollPosition && _verticalAutoScrollTween || _verticalScrollPosition == maxVerticalScrollPosition;
      }
      
      protected function get isLeftMostPosition() : Boolean
      {
         return _targetHorizontalScrollPosition == 0 && _horizontalAutoScrollTween || _horizontalScrollPosition == 0;
      }
      
      protected function get isRightMostPosition() : Boolean
      {
         return _targetHorizontalScrollPosition == maxHorizontalScrollPosition && _horizontalAutoScrollTween || _horizontalScrollPosition == maxHorizontalScrollPosition;
      }
      
      public function setNode(param1:Node) : void
      {
         x = param1.state.matrix.tx;
         y = param1.state.matrix.ty;
         width = param1.clip.bounds.width * param1.state.matrix.a;
         height = param1.clip.bounds.height * param1.state.matrix.d;
      }
      
      public function matchContainer(param1:DisplayObjectContainer) : void
      {
         width = param1.width;
         height = param1.height;
         param1.addChild(this);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("scroll"))
         {
            refreshExternalScrollElements();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         interactionMode = "mouse";
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "on";
         if(externalSlider)
         {
            _verticalScrollBarFactory = factory_verticalScrollBar;
         }
         verticalScrollStep = 0;
         verticalMouseWheelScrollStep = 70;
         tween_top = new Tween(null,0.5,"linear");
         tween_bottom = new Tween(null,0.5,"linear");
         refreshExternalScrollElements();
      }
      
      override protected function createScrollBars() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.horizontalScrollBar)
         {
            this.horizontalScrollBar.removeEventListener("beginInteraction",horizontalScrollBar_beginInteractionHandler);
            this.horizontalScrollBar.removeEventListener("endInteraction",horizontalScrollBar_endInteractionHandler);
            this.horizontalScrollBar.removeEventListener("change",horizontalScrollBar_changeHandler);
            this.removeRawChildInternal(DisplayObject(this.horizontalScrollBar),true);
            this.horizontalScrollBar = null;
         }
         if(this.verticalScrollBar)
         {
            this.verticalScrollBar.removeEventListener("beginInteraction",verticalScrollBar_beginInteractionHandler);
            this.verticalScrollBar.removeEventListener("endInteraction",verticalScrollBar_endInteractionHandler);
            this.verticalScrollBar.removeEventListener("change",verticalScrollBar_changeHandler);
            this.removeRawChildInternal(DisplayObject(this.verticalScrollBar),true);
            this.verticalScrollBar = null;
         }
         if(this._scrollBarDisplayMode != "none" && this._horizontalScrollPolicy != "off" && this._horizontalScrollBarFactory != null)
         {
            this.horizontalScrollBar = IScrollBar(this._horizontalScrollBarFactory());
            if(this.horizontalScrollBar is IDirectionalScrollBar)
            {
               IDirectionalScrollBar(this.horizontalScrollBar).direction = "horizontal";
            }
            _loc1_ = this._customHorizontalScrollBarName != null?this._customHorizontalScrollBarName:this.horizontalScrollBarName;
            this.horizontalScrollBar.styleNameList.add(_loc1_);
            this.horizontalScrollBar.addEventListener("change",horizontalScrollBar_changeHandler);
            this.horizontalScrollBar.addEventListener("beginInteraction",horizontalScrollBar_beginInteractionHandler);
            this.horizontalScrollBar.addEventListener("endInteraction",horizontalScrollBar_endInteractionHandler);
            this.addRawChildInternal(DisplayObject(this.horizontalScrollBar));
         }
         if(this._scrollBarDisplayMode != "none" && this._verticalScrollPolicy != "off" && this._verticalScrollBarFactory != null)
         {
            this.verticalScrollBar = IScrollBar(this._verticalScrollBarFactory());
            if(this.verticalScrollBar is IDirectionalScrollBar)
            {
               IDirectionalScrollBar(this.verticalScrollBar).direction = "vertical";
            }
            _loc2_ = this._customVerticalScrollBarName != null?this._customVerticalScrollBarName:this.verticalScrollBarName;
            this.verticalScrollBar.styleNameList.add(_loc2_);
            this.verticalScrollBar.addEventListener("change",verticalScrollBar_changeHandler);
            this.verticalScrollBar.addEventListener("beginInteraction",verticalScrollBar_beginInteractionHandler);
            this.verticalScrollBar.addEventListener("endInteraction",verticalScrollBar_endInteractionHandler);
         }
      }
      
      override protected function calculateViewPortOffsets(param1:Boolean = false, param2:Boolean = false) : void
      {
         this._topViewPortOffset = this._paddingTop;
         this._rightViewPortOffset = this._paddingRight;
         this._bottomViewPortOffset = this._paddingBottom;
         this._leftViewPortOffset = this._paddingLeft;
         if(this._scrollBarDisplayMode != "fixed")
         {
            this._hasHorizontalScrollBar = this._isDraggingHorizontally || this._horizontalAutoScrollTween;
            this._hasVerticalScrollBar = this._isDraggingVertically || this._verticalAutoScrollTween;
         }
      }
      
      override protected function showOrHideChildren() : void
      {
         if(this.currentBackgroundSkin)
         {
            if(this._autoHideBackground)
            {
               this.currentBackgroundSkin.visible = this._viewPort.width < this.actualWidth || this._viewPort.height < this.actualHeight || this._horizontalScrollPosition < 0 || this._horizontalScrollPosition > this._maxHorizontalScrollPosition || this._verticalScrollPosition < 0 || this._verticalScrollPosition > this._maxVerticalScrollPosition;
            }
            else
            {
               this.currentBackgroundSkin.visible = true;
            }
         }
      }
      
      override protected function layoutChildren() : void
      {
         if(this.currentBackgroundSkin)
         {
            this.currentBackgroundSkin.width = this.actualWidth;
            this.currentBackgroundSkin.height = this.actualHeight;
         }
         if(this.horizontalScrollBar)
         {
            this.horizontalScrollBar.validate();
         }
         if(this.verticalScrollBar)
         {
            this.verticalScrollBar.validate();
         }
         if(this._touchBlocker)
         {
            this._touchBlocker.x = this._leftViewPortOffset;
            this._touchBlocker.y = this._topViewPortOffset;
            this._touchBlocker.width = this._viewPort.visibleWidth;
            this._touchBlocker.height = this._viewPort.visibleHeight;
         }
         if(useFloatCoordinates)
         {
            this._viewPort.x = this._leftViewPortOffset - this._horizontalScrollPosition;
            this._viewPort.y = this._topViewPortOffset - this._verticalScrollPosition;
         }
         else
         {
            this._viewPort.x = int(this._leftViewPortOffset - this._horizontalScrollPosition);
            this._viewPort.y = int(this._topViewPortOffset - this._verticalScrollPosition);
         }
      }
      
      override protected function refreshScrollBarValues() : void
      {
         var _loc1_:Number = this.actualWidth - (this._leftViewPortOffset + this._rightViewPortOffset);
         var _loc2_:Number = this.actualHeight - (this._topViewPortOffset + this._bottomViewPortOffset);
         if(this.horizontalScrollBar)
         {
            this.horizontalScrollBar.minimum = this._minHorizontalScrollPosition;
            this.horizontalScrollBar.maximum = this._maxHorizontalScrollPosition;
            this.horizontalScrollBar.value = this._horizontalScrollPosition;
            this.horizontalScrollBar.page = (this._maxHorizontalScrollPosition - this._minHorizontalScrollPosition) * _loc1_ / this._viewPort.width;
            this.horizontalScrollBar.step = this.actualHorizontalScrollStep;
         }
         if(this.verticalScrollBar)
         {
            this.verticalScrollBar.minimum = this._minVerticalScrollPosition;
            this.verticalScrollBar.maximum = this._maxVerticalScrollPosition;
            this.verticalScrollBar.value = this._verticalScrollPosition;
            this.verticalScrollBar.page = (this._maxVerticalScrollPosition - this._minVerticalScrollPosition) * _loc2_ / this._viewPort.height;
            this.verticalScrollBar.step = this.actualVerticalScrollStep;
         }
      }
      
      override protected function verticalScrollBar_endInteractionHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         if(snapToPages)
         {
            super.completeScroll();
            this._verticalScrollBarIsScrolling = false;
            this.dispatchEventWith("endInteraction");
            _loc2_ = roundToNearest(this._verticalScrollPosition,this.actualPageHeight);
            if(_loc2_ != this._verticalScrollPosition)
            {
               this.throwTo(NaN,_loc2_,_pageThrowDuration);
            }
         }
         else
         {
            this._verticalScrollBarIsScrolling = false;
            this.dispatchEventWith("endInteraction");
            this.completeScroll();
         }
      }
      
      override protected function verticalScrollBar_changeHandler(param1:Event) : void
      {
         this.verticalScrollPosition = externalSlider.value;
         refreshExternalScrollElements();
      }
      
      override protected function refreshBackgroundSkin() : void
      {
         super.refreshBackgroundSkin();
         refreshExternalScrollElements();
      }
      
      protected function createLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         _loc1_.gap = -2;
         layout = _loc1_;
      }
      
      protected function refreshExternalScrollElements() : void
      {
      }
      
      private function factory_verticalScrollBar() : ScrollBar
      {
         return externalSlider;
      }
   }
}
