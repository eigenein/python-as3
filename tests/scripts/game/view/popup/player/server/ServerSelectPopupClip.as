package game.view.popup.player.server
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ServerSelectPopupClip extends PopupClipBase
   {
       
      
      public var tf_label_current_server:ClipLabel;
      
      public var tf_label_server_list:ClipLabel;
      
      public var btn_select:ClipButtonLabeled;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var current_server:ServerSelectPopupCurrentServerClip;
      
      public function ServerSelectPopupClip()
      {
         tf_label_current_server = new ClipLabel();
         tf_label_server_list = new ClipLabel();
         btn_select = new ClipButtonLabeled();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         current_server = new ServerSelectPopupCurrentServerClip();
         super();
      }
   }
}
