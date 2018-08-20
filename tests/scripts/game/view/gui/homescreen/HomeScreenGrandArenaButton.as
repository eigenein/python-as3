package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   
   public class HomeScreenGrandArenaButton extends HomeScreenBuildingButton
   {
       
      
      private var _music:ButtonHoverSound;
      
      public var icon_content:GuiAnimation;
      
      public function HomeScreenGrandArenaButton()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         hover_front.graphics.touchable = _loc2_;
         icon_content.graphics.touchable = _loc2_;
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.grandArenaHover);
         }
         return _music;
      }
   }
}
