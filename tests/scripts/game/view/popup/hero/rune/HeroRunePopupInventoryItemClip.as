package game.view.popup.hero.rune
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class HeroRunePopupInventoryItemClip extends ClipButton
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var tf_value:ClipLabel;
      
      public var bg_value:GuiClipScale3Image;
      
      public var tf_amount:ClipLabel;
      
      public var bg_amount:GuiClipScale3Image;
      
      public function HeroRunePopupInventoryItemClip()
      {
         tf_value = new ClipLabel(true);
         tf_amount = new ClipLabel(true);
         super();
      }
   }
}
