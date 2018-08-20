package game.view.popup.clan
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.common.ClipListItemSelectableInventoryItemWithTooltip;
   
   public class ClanItemForActivityPopupClip extends GuiClipNestedContainer
   {
       
      
      private var scrollBar:GameScrollBar;
      
      public var button_close:ClipButton;
      
      public var button_confirm:ClipButtonLabeled;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_disclaimer:ClipLabel;
      
      public var icon_activity:ClipSprite;
      
      public var tf_value:SpecialClipLabel;
      
      public var tf_label_cap:SpecialClipLabel;
      
      public var icon_activity_cap:ClipSprite;
      
      public var tf_value_cap:SpecialClipLabel;
      
      public var layout_reward_cap:ClipLayout;
      
      public var layout_reward:ClipLayout;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var inventory_item_list:ClipListWithScroll;
      
      public var list_item_provider:ClipDataProvider;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public function ClanItemForActivityPopupClip()
      {
         scrollBar = new GameScrollBar();
         icon_activity = new ClipSprite();
         tf_value = new SpecialClipLabel(true);
         tf_label_cap = new SpecialClipLabel(true);
         icon_activity_cap = new ClipSprite();
         tf_value_cap = new SpecialClipLabel(true);
         layout_reward_cap = ClipLayout.horizontalCentered(5,tf_label_cap,icon_activity_cap,tf_value_cap);
         layout_reward = ClipLayout.horizontalMiddleCentered(5,icon_activity,tf_value);
         scroll_slider_container = new ClipLayoutNone();
         super();
         inventory_item_list = new ClipListWithScroll(ClipListItemSelectableInventoryItemWithTooltip,scrollBar);
         list_item_provider = inventory_item_list.itemClipProvider;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         scrollBar.height = scroll_slider_container.height;
         scroll_slider_container.addChild(scrollBar);
         inventory_item_list.addGradients(gradient_top.graphics,gradient_bottom.graphics);
         var _loc2_:TiledRowsLayout = new TiledRowsLayout();
         inventory_item_list.list.layout = _loc2_;
      }
   }
}
