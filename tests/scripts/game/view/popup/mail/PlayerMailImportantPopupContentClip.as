package game.view.popup.mail
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.FramedImageClipButton;
   
   public class PlayerMailImportantPopupContentClip extends GuiClipNestedContainer
   {
       
      
      public var button_go:ClipButtonLabeled;
      
      public var image:FramedImageClipButton;
      
      public var tf_text:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function PlayerMailImportantPopupContentClip()
      {
         button_go = new ClipButtonLabeled();
         image = new FramedImageClipButton();
         tf_text = new ClipLabel();
         layout = ClipLayout.verticalCenter(8,image,tf_text,button_go);
         super();
      }
   }
}
