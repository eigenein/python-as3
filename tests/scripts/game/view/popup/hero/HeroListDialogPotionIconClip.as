package game.view.popup.hero
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class HeroListDialogPotionIconClip extends GuiClipNestedContainer
   {
       
      
      public var frame:ClipSprite;
      
      public var image:GuiClipImage;
      
      public function HeroListDialogPotionIconClip()
      {
         frame = new ClipSprite();
         image = new GuiClipImage();
         super();
      }
   }
}
