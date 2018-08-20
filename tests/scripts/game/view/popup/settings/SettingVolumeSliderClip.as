package game.view.popup.settings
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import engine.core.clipgui.GuiClipFactoryBase;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.Button;
   import feathers.controls.Slider;
   import feathers.display.Scale3Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.settings.SettingSliderMediator;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   import starling.display.Image;
   
   public class SettingVolumeSliderClip extends GuiClipNestedContainer
   {
       
      
      private var _mediator:SettingSliderMediator;
      
      private const slider:Slider = new Slider();
      
      public var tf_label:ClipLabel;
      
      public var tf_value:ClipLabel;
      
      public var thumb:ClipDataProvider;
      
      public var track:ClipDataProvider;
      
      public var track_filled:ClipDataProvider;
      
      public var slider_layout:GuiClipLayoutContainer;
      
      public function SettingVolumeSliderClip()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_mediator)
         {
            _mediator.signal_changed.remove(handler_valueChanged);
         }
         slider.removeEventListener("change",handler_sliderChange);
      }
      
      public function set mediator(param1:SettingSliderMediator) : void
      {
         _mediator = param1;
         tf_label.text = _mediator.label;
         slider.minimum = _mediator.minValue;
         slider.maximum = _mediator.maxValue;
         slider.step = _mediator.step;
         handler_valueChanged(_mediator.value);
         _mediator.signal_changed.add(handler_valueChanged);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         slider.thumbFactory = thumbFactory;
         slider.minimumTrackFactory = trackFactory;
         slider.maximumTrackFactory = emptyTrackFactory;
         slider.step = 1;
         slider.addEventListener("change",handler_sliderChange);
         slider.width = slider_layout.graphics.width;
         slider.trackLayoutMode = "minMax";
         slider_layout.container.addChild(slider);
      }
      
      private function thumbFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         if(thumb)
         {
            _loc1_.defaultSkin = new Image(ClipImageCache.getClipTexture(thumb.clip));
         }
         _loc1_.isQuickHitAreaEnabled = true;
         var _loc2_:int = 40;
         _loc1_.minTouchHeight = _loc2_;
         _loc1_.minTouchWidth = _loc2_;
         _loc1_.signal_click.add(handler_testSound);
         return _loc1_;
      }
      
      private function trackFactory() : Button
      {
         return createTrackScale3Button(track_filled.clip);
      }
      
      private function emptyTrackFactory() : Button
      {
         return createTrackScale3Button(track.clip);
      }
      
      private function createTrackScale3Button(param1:Clip) : GameButton
      {
         var _loc2_:GameButton = new GameButton();
         var _loc3_:Rectangle = GuiClipFactoryBase.getScale9Grid(param1);
         if(_loc3_.x != 0 && _loc3_.width != 0)
         {
            _loc2_.defaultSkin = new Scale3Image(ClipImageTextureFactory.getScale3Texture(param1,_loc3_.x,_loc3_.width,"horizontal"));
            slider.direction = "horizontal";
         }
         else
         {
            _loc2_.defaultSkin = new Scale3Image(ClipImageTextureFactory.getScale3Texture(param1,_loc3_.y,_loc3_.height,"vertical"));
            slider.direction = "vertical";
         }
         return _loc2_;
      }
      
      private function handler_valueChanged(param1:Number) : void
      {
         slider.value = param1;
         tf_value.text = _mediator.valueString;
      }
      
      private function handler_sliderChange() : void
      {
         _mediator.value = slider.value;
      }
      
      private function handler_testSound() : void
      {
         _mediator.testValue();
      }
   }
}
