package game.view.gui.overlay.offer
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   
   public class SpecialOfferSideBarClip extends GuiClipNestedContainer
   {
       
      
      public var layout_main:ClipLayout;
      
      public function SpecialOfferSideBarClip()
      {
         layout_main = ClipLayout.vertical(15);
         super();
      }
   }
}
