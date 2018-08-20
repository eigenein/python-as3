package game.view.popup.inventory
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemIcon;
   
   public class SellItemPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_minus_inst0:ClipButton;
      
      public var button_plus_inst0:ClipButton;
      
      public var button_sell:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_current_amount:ClipLabel;
      
      public var tf_hint:ClipLabel;
      
      public var tf_item_in_stock:ClipLabel;
      
      public var tf_item_in_stock_label:ClipLabel;
      
      public var tf_selected_item_name:ClipLabel;
      
      public var tf_sell_cost:ClipLabel;
      
      public var tf_sell_cost_base:ClipLabel;
      
      public var tf_sell_for_label:ClipLabel;
      
      public var tf_sell_for_label_base:ClipLabel;
      
      public var icon_gold:GuiClipImage;
      
      public var icon_gold_base:GuiClipImage;
      
      public var item_icon:InventoryItemIcon;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var cutePanel_BG_12_12_12_12_inst1:GuiClipScale9Image;
      
      public var layout_in_stock:ClipLayout;
      
      public var layout_sell_cost:ClipLayout;
      
      public var layout_sell_cost_base:ClipLayout;
      
      public var marker_slider_container:ClipLayout;
      
      public var layout_counter_slider:ClipLayout;
      
      public function SellItemPopupClip()
      {
         button_minus_inst0 = new ClipButton();
         button_plus_inst0 = new ClipButton();
         button_sell = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_current_amount = new ClipLabel();
         tf_hint = new ClipLabel();
         tf_item_in_stock = new ClipLabel(true);
         tf_item_in_stock_label = new ClipLabel(true);
         tf_selected_item_name = new ClipLabel();
         tf_sell_cost = new ClipLabel(true);
         tf_sell_cost_base = new ClipLabel(true);
         tf_sell_for_label = new ClipLabel(true);
         tf_sell_for_label_base = new ClipLabel(true);
         icon_gold = new GuiClipImage();
         icon_gold_base = new GuiClipImage();
         item_icon = new InventoryItemIcon();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         cutePanel_BG_12_12_12_12_inst1 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_in_stock = ClipLayout.horizontal(4,tf_item_in_stock_label,tf_item_in_stock);
         layout_sell_cost = ClipLayout.horizontalCentered(4,tf_sell_for_label,icon_gold,tf_sell_cost);
         layout_sell_cost_base = ClipLayout.horizontal(4,tf_sell_for_label_base,icon_gold_base,tf_sell_cost_base);
         marker_slider_container = ClipLayout.none();
         layout_counter_slider = ClipLayout.verticalMiddleCenter(-2,tf_current_amount,marker_slider_container);
         super();
      }
   }
}
