package game.mechanics
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class MechanicNotEnoughLevelPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_caption:ClipLabel;
      
      public var tf_footer:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var image_marker:ClipSprite;
      
      public function MechanicNotEnoughLevelPopupClip()
      {
         button_ok = new ClipButtonLabeled();
         tf_caption = new ClipLabel();
         tf_footer = new ClipLabel();
         tf_header = new ClipLabel();
         image_marker = new ClipSprite();
         super();
      }
   }
}
