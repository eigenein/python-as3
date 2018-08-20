package game.view.popup.test.grade
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.Button;
   import feathers.controls.Slider;
   import feathers.display.Scale3Image;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.GameButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   import idv.cjcat.signals.Signal;
   import starling.display.Image;
   
   public class BattleGradeSlider extends GuiClipNestedContainer
   {
       
      
      public var tf_value:SpecialClipLabel;
      
      public var button_plus:ClipButton;
      
      public var button_minus:ClipButton;
      
      public var thumb:ClipDataProvider;
      
      public var track:ClipDataProvider;
      
      public var slider_layout:GuiClipLayoutContainer;
      
      public const signal_value:Signal = new Signal(Number);
      
      public const slider:Slider = new Slider();
      
      public function BattleGradeSlider()
      {
         tf_value = new SpecialClipLabel(true);
         super();
      }
      
      public function set text(param1:String) : void
      {
         tf_value.text = param1;
         tf_value.adjustSizeToFitWidth();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_plus.signal_click.add(handler_plus);
         button_minus.signal_click.add(handler_minus);
         slider.direction = "horizontal";
         slider.thumbFactory = thumbFactory;
         slider.minimumTrackFactory = trackFactory;
         slider.step = 1;
         slider.addEventListener("change",handler_sliderChange);
         slider.width = slider_layout.graphics.width;
         slider_layout.container.addChild(slider);
      }
      
      private function thumbFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         _loc1_.defaultSkin = new Image(ClipImageCache.getClipTexture(thumb.clip));
         return _loc1_;
      }
      
      private function trackFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         _loc1_.defaultSkin = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("slider_bg_10_10_1_horiz",10,1));
         return _loc1_;
      }
      
      private function handler_plus() : void
      {
         if(slider.value < slider.maximum)
         {
            slider.value = slider.value + slider.step;
            signal_value.dispatch(slider.value);
         }
      }
      
      private function handler_minus() : void
      {
         if(slider.value > slider.minimum)
         {
            slider.value = slider.value - slider.step;
            signal_value.dispatch(slider.value);
         }
      }
      
      private function handler_sliderChange() : void
      {
         signal_value.dispatch(slider.value);
      }
   }
}
