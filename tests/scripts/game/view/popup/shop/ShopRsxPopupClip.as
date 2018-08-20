package game.view.popup.shop
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.ILayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ShopRsxPopupClip extends PopupClipBase
   {
       
      
      public var tf_refresh_time:ClipLabel;
      
      public var tf_refresh_text:ClipLabel;
      
      public var cost_panel:ShopCostPanel;
      
      public var refresh_block_layout_container:GuiClipLayoutContainer;
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const list:GameScrolledList = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
      
      public var vertDivider_inst0:ClipSprite;
      
      public var inst0_underBGglow:ClipSprite;
      
      public var refresh_button:ClipButton;
      
      public var tab_layout_container:GuiClipLayoutContainer;
      
      public function ShopRsxPopupClip()
      {
         super();
         header_layout_container = new GuiClipLayoutContainer();
         button_close = new ClipButton();
         vertDivider_inst0 = new ClipSprite();
         bg = new ClipSprite();
         inst0_underBGglow = new ClipSprite();
         tf_refresh_time = new ClipLabel(true);
         tf_refresh_text = new ClipLabel(true);
         refresh_button = new ClipButton();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
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
