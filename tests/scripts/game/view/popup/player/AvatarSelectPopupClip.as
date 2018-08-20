package game.view.popup.player
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class AvatarSelectPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var btn_change:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_tabs:ClipLayout;
      
      public function AvatarSelectPopupClip()
      {
         tf_caption = new ClipLabel();
         btn_change = new ClipButtonLabeled();
         button_close = new ClipButton();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         gradient_top.graphics.touchable = _loc2_;
         gradient_bottom.graphics.touchable = _loc2_;
      }
   }
}
