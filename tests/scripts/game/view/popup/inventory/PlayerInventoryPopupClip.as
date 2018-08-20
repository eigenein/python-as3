package game.view.popup.inventory
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class PlayerInventoryPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tab_layout_container:GuiClipLayoutContainer;
      
      public var selected_item:PlayerInventoryPopupSelectedItemClip;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var button_close:ClipButton;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var sideBGLight_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var bg:ClipSprite;
      
      public var inst0_underBGglow:ClipSprite;
      
      public function PlayerInventoryPopupClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
      }
   }
}
