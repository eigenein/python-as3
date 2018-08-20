package game.view.gui.components
{
   import feathers.controls.Button;
   import feathers.controls.Slider;
   import feathers.display.Scale3Image;
   import game.assets.storage.AssetStorage;
   
   public class GameSlider extends Slider
   {
       
      
      public function GameSlider()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         direction = "horizontal";
         thumbFactory = __thumbFactory;
         minimumTrackFactory = __trackFactory;
      }
      
      private function __thumbFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         _loc1_.defaultSkin = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("slider_but_10_10_1_horiz",10,1));
         return _loc1_;
      }
      
      private function __trackFactory() : Button
      {
         var _loc1_:GameButton = new GameButton();
         _loc1_.defaultSkin = new Scale3Image(AssetStorage.rsx.popup_theme.getScale3Textures("slider_bg_10_10_1_horiz",10,1));
         return _loc1_;
      }
   }
}
