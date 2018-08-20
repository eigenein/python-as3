package game.view.popup.shop.clanwar
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarShopPopupClip extends GuiClipNestedContainer
   {
       
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var tf_header:ClipLabel;
      
      public var scrollbar:GameScrollBar;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var list:GameScrolledList;
      
      public var clip_item:ClipDataProvider;
      
      public var clip_upper_tab:ClipDataProvider;
      
      public var layout_upper_tabs:ClipLayout;
      
      public var button_close:ClipButton;
      
      public var tab_layout_container:GuiClipLayoutContainer;
      
      public function ClanWarShopPopupClip()
      {
         dialog_frame = new GuiClipScale9Image();
         tf_header = new ClipLabel();
         scrollbar = new GameScrollBar();
         gradient_top = new ClipSpriteUntouchable();
         gradient_bottom = new ClipSpriteUntouchable();
         list = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
         clip_item = new ClipDataProvider();
         clip_upper_tab = new ClipDataProvider();
         layout_upper_tabs = ClipLayout.horizontalMiddleCentered(-5);
         button_close = new ClipButton();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
      }
   }
}
