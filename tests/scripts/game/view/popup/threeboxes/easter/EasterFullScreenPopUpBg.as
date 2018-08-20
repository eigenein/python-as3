package game.view.popup.threeboxes.easter
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class EasterFullScreenPopUpBg extends GuiClipNestedContainer
   {
       
      
      public var blindSideLeft:ClipSprite;
      
      public var blindSideRight:ClipSprite;
      
      public function EasterFullScreenPopUpBg()
      {
         blindSideLeft = new ClipSprite();
         blindSideRight = new ClipSprite();
         super();
      }
   }
}
