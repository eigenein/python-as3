package game.view.popup.odnoklassniki
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class OdnoklassnikiEventPopupClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var postcard_container:GuiClipContainer;
      
      public var button_close:ClipButton;
      
      public var button_to_store:ClipButtonLabeled;
      
      public function OdnoklassnikiEventPopupClip()
      {
         dialog_frame = new GuiClipScale9Image();
         postcard_container = new GuiClipContainer();
         button_close = new ClipButton();
         button_to_store = new ClipButtonLabeled();
         super();
      }
   }
}
