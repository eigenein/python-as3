package game.view.popup.shop.buy
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class BuyItemPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_minus_inst0:ClipButton;
      
      public var button_plus_inst0:ClipButton;
      
      public var button_buy:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_current_amount:ClipLabel;
      
      public var tf_hint:ClipLabel;
      
      public var tf_selected_item_name:ClipLabel;
      
      public var tf_buy_for_label:ClipLabel;
      
      public var tf_buy_for_label_base:ClipLabel;
      
      public var price_base:QuestRewardItemRenderer;
      
      public var price:QuestRewardItemRenderer;
      
      public var item_icon:InventoryItemIcon;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var cutePanel_BG_12_12_12_12_inst1:GuiClipScale9Image;
      
      public var layout_buy_cost:ClipLayout;
      
      public var layout_buy_cost_base:ClipLayout;
      
      public var marker_slider_container:ClipLayout;
      
      public var layout_counter_slider:ClipLayout;
      
      public function BuyItemPopupClip()
      {
         button_minus_inst0 = new ClipButton();
         button_plus_inst0 = new ClipButton();
         button_buy = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_current_amount = new ClipLabel();
         tf_hint = new ClipLabel();
         tf_selected_item_name = new ClipLabel();
         tf_buy_for_label = new ClipLabel(true);
         tf_buy_for_label_base = new ClipLabel(true);
         price_base = new QuestRewardItemRenderer();
         price = new QuestRewardItemRenderer();
         item_icon = new InventoryItemIcon();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cutePanel_BG_12_12_12_12_inst1 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_buy_cost = ClipLayout.horizontalMiddleCentered(4,tf_buy_for_label,price);
         layout_buy_cost_base = ClipLayout.horizontalMiddle(4,tf_buy_for_label_base,price_base);
         marker_slider_container = ClipLayout.none();
         layout_counter_slider = ClipLayout.verticalMiddleCenter(-2,tf_current_amount,marker_slider_container);
         super();
      }
   }
}
