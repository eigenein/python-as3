package game.view.popup.titanspiritartifact
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipHitTestImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class TitanSpiritArtifactAnimation extends GuiClipNestedContainer
   {
       
      
      public var hitTest_image:GuiClipHitTestImage;
      
      public var animation:GuiAnimation;
      
      public var hover_front:GuiAnimation;
      
      public var hover_back:GuiAnimation;
      
      public function TitanSpiritArtifactAnimation()
      {
         hitTest_image = new GuiClipHitTestImage();
         super();
      }
      
      public function dispose() : void
      {
         animation && animation.dispose();
         hover_front && hover_front.dispose();
      }
   }
}
