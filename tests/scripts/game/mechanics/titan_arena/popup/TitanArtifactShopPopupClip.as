package game.mechanics.titan_arena.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.ILayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.shop.ShopCostPanel;
   
   public class TitanArtifactShopPopupClip extends GuiClipNestedContainer
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
      
      public var tf_refresh_time:ClipLabel;
      
      public var tf_refresh_text:ClipLabel;
      
      public var refresh_button:ClipButton;
      
      public var cost_panel:ShopCostPanel;
      
      public var refresh_block_layout_container:GuiClipLayoutContainer;
      
      public var tf_voucher_goods_desc:ClipLabel;
      
      public function TitanArtifactShopPopupClip()
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
         tf_refresh_time = new ClipLabel(true);
         tf_refresh_text = new ClipLabel(true);
         tf_voucher_goods_desc = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
         refresh_block_layout_container.layoutGroup.layout = _horizontalLayout();
         refresh_block_layout_container.layoutGroup.addChild(tf_refresh_text);
         refresh_block_layout_container.layoutGroup.addChild(tf_refresh_time);
         refresh_block_layout_container.layoutGroup.addChild(refresh_button.graphics);
         refresh_block_layout_container.layoutGroup.addChild(cost_panel.graphics);
      }
      
      private function _horizontalLayout() : ILayout
      {
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = 3;
         return _loc1_;
      }
   }
}
