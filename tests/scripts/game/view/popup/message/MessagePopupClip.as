package game.view.popup.message
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class MessagePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:SpecialClipLabel;
      
      public var line:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_text:ClipLayout;
      
      public function MessagePopupClip()
      {
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_message = new SpecialClipLabel();
         line = new GuiClipScale3Image(148,1);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_text = ClipLayout.verticalMiddleCenter(4,tf_header,line,tf_message,button_ok);
         super();
      }
   }
}
