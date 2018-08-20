package game.view.gui.homescreen
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ny.welcome.NYWelcomePopupMediator;
   
   public class HomeScreenNYVagonButton extends HomeScreenVagonButton
   {
       
      
      private var hitTestImageStartPosition:Point;
      
      public function HomeScreenNYVagonButton()
      {
         super();
      }
      
      public function setNYTreeLevel(param1:uint) : void
      {
         if(!hitTestImageStartPosition)
         {
            hitTestImageStartPosition = new Point(hitTest_image.graphics.x,hitTest_image.graphics.y);
         }
         animation.setClip(AssetStorage.rsx.main_screen.data.getClipByName("tree" + param1 + "_animation_idle"));
         hover_front.gotoAndStop(param1 - 1);
         var _loc2_:GuiClipImage = AssetStorage.rsx.main_screen.create(GuiClipImage,"hitTest_image_mc_" + param1);
         hitTest_image.graphics.x = hitTestImageStartPosition.x + _loc2_.image.x;
         hitTest_image.graphics.y = hitTestImageStartPosition.y + _loc2_.image.y;
         hitTest_image.image.texture = _loc2_.image.texture;
         hitTest_image.image.width = _loc2_.image.width;
         hitTest_image.image.height = _loc2_.image.height;
      }
      
      override protected function adjustIntensity(param1:GuiAnimation, param2:int) : void
      {
         if(param1)
         {
            param1.graphics.alpha = param2 / 100;
            param1.graphics.visible = param2 > 0;
         }
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return NYWelcomePopupMediator.music;
      }
   }
}
