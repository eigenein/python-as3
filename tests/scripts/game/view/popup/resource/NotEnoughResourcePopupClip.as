package game.view.popup.resource
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class NotEnoughResourcePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_ok:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var line:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_text:ClipLayout;
      
      public function NotEnoughResourcePopupClip()
      {
         button_ok = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_message = new ClipLabel();
         line = new GuiClipScale3Image(148,1);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_text = ClipLayout.verticalMiddleCenter(4,tf_header,line,tf_message,button_ok);
         super();
      }
   }
}
