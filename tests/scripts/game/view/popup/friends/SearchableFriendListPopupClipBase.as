package game.view.popup.friends
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class SearchableFriendListPopupClipBase extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var bg:GuiClipScale9Image;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var tf_empty:ClipLabel;
      
      public var tf_name_input:ClipInput;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function SearchableFriendListPopupClipBase()
      {
         button_close = new ClipButton();
         bg = new GuiClipScale9Image();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         tf_empty = new ClipLabel();
         tf_name_input = new ClipInput();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
