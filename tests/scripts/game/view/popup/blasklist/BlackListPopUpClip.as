package game.view.popup.blasklist
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class BlackListPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var action_button:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_desc:ClipLabel;
      
      public var tf_title:ClipLabel;
      
      public var tf_empty:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function BlackListPopUpClip()
      {
         action_button = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_desc = new ClipLabel();
         tf_title = new ClipLabel();
         tf_empty = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
