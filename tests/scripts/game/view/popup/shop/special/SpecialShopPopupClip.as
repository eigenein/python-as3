package game.view.popup.shop.special
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.controls.LayoutGroup;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.shop.ShopCostPanel;
   
   public class SpecialShopPopupClip extends GuiClipNestedContainer
   {
       
      
      public var cost_panel:ShopCostPanel;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var power_block:SpecialShopPowerClip;
      
      public var skill_block:SpecialShopSkillClip;
      
      public var rank_block:SpecialShopRankClip;
      
      public var stats_block:SpecialShopStatListClip;
      
      public var button_promote:ClipButtonLabeled;
      
      public var tf_label_you_get:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_timer:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var bg_container:GuiClipLayoutContainer;
      
      public var hero_panel:SpecialShopPopupHeroClip;
      
      public var hero_panel_lg:LayoutGroup;
      
      public var inventory:Vector.<SpecialShopInventoryItemRenderer>;
      
      public var layout_stats:ClipLayout;
      
      public var layout_timer:ClipLayout;
      
      public var tf_discount:ClipLabel;
      
      public var discount_icon:ClipSprite;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public function SpecialShopPopupClip()
      {
         cost_panel = new ShopCostPanel();
         dialog_frame = new GuiClipScale9Image();
         power_block = new SpecialShopPowerClip();
         skill_block = new SpecialShopSkillClip();
         rank_block = new SpecialShopRankClip();
         stats_block = new SpecialShopStatListClip();
         button_promote = new ClipButtonLabeled();
         tf_label_you_get = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_timer = new ClipLabel(true);
         tf_header = new ClipLabel();
         tf_label_timer = new ClipLabel(true);
         tf_old_price = new ClipLabel();
         button_close = new ClipButton();
         bg_container = new GuiClipLayoutContainer();
         hero_panel = new SpecialShopPopupHeroClip();
         hero_panel_lg = new LayoutGroup();
         inventory = new Vector.<SpecialShopInventoryItemRenderer>(0);
         layout_stats = ClipLayout.horizontalMiddleCentered(10,rank_block,power_block,skill_block,stats_block);
         layout_timer = ClipLayout.horizontalCentered(4,tf_label_timer,tf_timer);
         tf_discount = new ClipLabel();
         discount_icon = new ClipSprite();
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
         inventory.push(hero_panel.inventory_slot_1);
         inventory.push(hero_panel.inventory_slot_2);
         inventory.push(hero_panel.inventory_slot_3);
         inventory.push(hero_panel.inventory_slot_4);
         inventory.push(hero_panel.inventory_slot_5);
         inventory.push(hero_panel.inventory_slot_6);
         hero_panel_lg.width = hero_panel.bg.graphics.width;
         hero_panel_lg.height = hero_panel.bg.graphics.height;
         var _loc2_:int = 0;
         hero_panel.graphics.y = _loc2_;
         hero_panel.graphics.x = _loc2_;
         hero_panel_lg.addChild(hero_panel.graphics);
         layout_stats.addChildAt(hero_panel_lg,0);
      }
   }
}
