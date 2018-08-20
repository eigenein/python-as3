package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipHitTestImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class TitanValleySpiritClip extends GuiClipNestedContainer
   {
       
      
      public var hitTest_image:GuiClipHitTestImage;
      
      public var animation:GuiAnimation;
      
      public var hover_front:GuiAnimation;
      
      public function TitanValleySpiritClip()
      {
         hitTest_image = new GuiClipHitTestImage();
         super();
      }
   }
}
