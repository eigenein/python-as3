package game.view.popup.ny.giftinfo
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYGiftInfoPopupClip extends PopupClipBase
   {
       
      
      public var tf_desc:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function NYGiftInfoPopupClip()
      {
         tf_desc = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = ClipLayout.horizontalMiddleCentered(0);
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
