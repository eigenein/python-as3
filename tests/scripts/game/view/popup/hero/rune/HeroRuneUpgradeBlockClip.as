package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.TiledRowsLayout;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.common.ClipListItemSelectableInventoryItem;
   import game.view.popup.shop.ShopCostPanel;
   
   public class HeroRuneUpgradeBlockClip extends GuiClipNestedContainer
   {
       
      
      private var scrollBar:GameScrollBar;
      
      public var tf_items_label:ClipLabel;
      
      public var tf_label_no_runes:ClipLabel;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var inventory_item_list:ClipListWithScroll;
      
      public var list_item_provider:ClipDataProvider;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var button_go:ClipButtonLabeled;
      
      public var button_enchant:ClipButtonLabeled;
      
      public var button_enchant_gem:ClipButtonLabeled;
      
      public var tf_label_enchant_gem:ClipLabel;
      
      public var cost_enchant:ShopCostPanel;
      
      public var layout_cost:ClipLayout;
      
      public var cost_gem:ShopCostPanel;
      
      public var layout_gem_cost:ClipLayout;
      
      public function HeroRuneUpgradeBlockClip()
      {
         scrollBar = new GameScrollBar();
         scroll_slider_container = new ClipLayoutNone();
         button_enchant = new ClipButtonLabeled();
         button_enchant_gem = new ClipButtonLabeled();
         cost_enchant = new ShopCostPanel();
         layout_cost = ClipLayout.horizontalMiddleRight(0,cost_enchant);
         cost_gem = new ShopCostPanel();
         layout_gem_cost = ClipLayout.horizontalMiddleRight(0,cost_gem);
         super();
         inventory_item_list = new ClipListWithScroll(ClipListItemSelectableInventoryItem,scrollBar);
         list_item_provider = inventory_item_list.itemClipProvider;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:TiledRowsLayout = new TiledRowsLayout();
         inventory_item_list.list.layout = _loc2_;
      }
   }
}
