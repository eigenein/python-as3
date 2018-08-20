package game.view.popup.selectaccount
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class SelectAccountPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function SelectAccountPopUpClip()
      {
         tf_title = new ClipLabel();
         tf_desc = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         scroll_slider_container = new GuiClipLayoutContainer();
         list_container = new GuiClipLayoutContainer();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
