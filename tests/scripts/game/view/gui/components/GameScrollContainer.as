package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.IGuiClip;
   import feathers.controls.ScrollContainer;
   import feathers.layout.VerticalLayout;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class GameScrollContainer extends ScrollContainer implements IGuiClip
   {
       
      
      protected var tween_top:Tween;
      
      protected var tween_bottom:Tween;
      
      protected var tweenDuration:Number = 0.1;
      
      protected var externalSlider:GameScrollBar;
      
      protected var gradientTop:DisplayObject;
      
      protected var gradientBottom:DisplayObject;
      
      private var _topGradientVisible:Boolean;
      
      private var _bottomGradientVisible:Boolean;
      
      public function GameScrollContainer(param1:GameScrollBar, param2:DisplayObject, param3:DisplayObject)
      {
         super();
         this.externalSlider = param1;
         createLayout();
         if(param3 && param2)
         {
            addGradients(param2,param3);
         }
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
      
      public function addGradients(param1:DisplayObject, param2:DisplayObject) : void
      {
         this.gradientTop = param1;
         this.gradientBottom = param2;
         updateGradient(param1,null,!isTopmostPosition);
         updateGradient(param2,null,!isLowestPosition);
      }
      
      public function setNode(param1:Node) : void
      {
         x = param1.state.matrix.tx;
         y = param1.state.matrix.ty;
         width = param1.clip.bounds.width * param1.state.matrix.a;
         height = param1.clip.bounds.height * param1.state.matrix.d;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("scroll"))
         {
            _refreshExternalScrollElements();
         }
      }
      
      override protected function refreshMinAndMaxScrollPositions() : void
      {
         super.refreshMinAndMaxScrollPositions();
      }
      
      protected function updateGradient(param1:DisplayObject, param2:Tween, param3:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc4_:Number = !!param3?1:0;
         if(param2)
         {
            param2.reset(param1,tweenDuration,"linear");
            param2.fadeTo(_loc4_);
            Starling.juggler.add(param2);
         }
         else
         {
            param1.alpha = _loc4_;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(externalSlider)
         {
            externalSlider.addEventListener("change",verticalScrollBar_changeHandler);
            externalSlider.addEventListener("beginInteraction",verticalScrollBar_beginInteractionHandler);
            externalSlider.addEventListener("endInteraction",verticalScrollBar_endInteractionHandler);
         }
         interactionMode = "mouse";
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "on";
         verticalScrollStep = 0;
         verticalMouseWheelScrollStep = 70;
         tween_top = new Tween(gradientTop,0.5,"linear");
         tween_bottom = new Tween(gradientBottom,0.5,"linear");
         _refreshExternalScrollElements();
      }
      
      override protected function refreshScrollBarValues() : void
      {
         if(externalSlider)
         {
            externalSlider.minimum = this._minVerticalScrollPosition;
            externalSlider.maximum = this._maxVerticalScrollPosition;
            externalSlider.value = this._verticalScrollPosition;
            externalSlider.page = (this._maxVerticalScrollPosition - this._minVerticalScrollPosition) * this.actualPageHeight / this._viewPort.height;
            externalSlider.step = this.actualVerticalScrollStep;
            _refreshExternalScrollElements();
         }
      }
      
      override protected function verticalScrollBar_changeHandler(param1:Event) : void
      {
         this.verticalScrollPosition = externalSlider.value;
         _refreshExternalScrollElements();
      }
      
      override protected function refreshBackgroundSkin() : void
      {
         super.refreshBackgroundSkin();
         _refreshExternalScrollElements();
      }
      
      protected function createLayout() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         layout = _loc1_;
         _loc1_.gap = 0;
         var _loc2_:int = 20;
         _loc1_.paddingBottom = _loc2_;
         _loc1_.paddingTop = _loc2_;
      }
      
      protected function _refreshExternalScrollElements() : void
      {
         if(gradientBottom && gradientTop)
         {
            if(isTopmostPosition == _topGradientVisible)
            {
               _topGradientVisible = !_topGradientVisible;
               updateGradient(gradientTop,tween_top,_topGradientVisible);
            }
            if(isLowestPosition == _bottomGradientVisible)
            {
               _bottomGradientVisible = !_bottomGradientVisible;
               updateGradient(gradientBottom,tween_bottom,_bottomGradientVisible);
            }
         }
      }
   }
}
