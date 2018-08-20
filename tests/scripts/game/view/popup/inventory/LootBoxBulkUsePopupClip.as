package game.view.popup.inventory
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemIcon;
   
   public class LootBoxBulkUsePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_minus_inst0:ClipButton;
      
      public var button_plus_inst0:ClipButton;
      
      public var button_use:ClipButtonLabeled;
      
      public var tf_current_amount:ClipLabel;
      
      public var tf_hint1:ClipLabel;
      
      public var tf_hint2:ClipLabel;
      
      public var tf_item_in_stock:ClipLabel;
      
      public var tf_selected_item_name:ClipLabel;
      
      public var item_icon:InventoryItemIcon;
      
      public var marker_slider_container:ClipLayout;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var layout_counter_slider:ClipLayout;
      
      public var layout_items:ClipLayout;
      
      public function LootBoxBulkUsePopupClip()
      {
         button_close = new ClipButton();
         button_minus_inst0 = new ClipButton();
         button_plus_inst0 = new ClipButton();
         button_use = new ClipButtonLabeled();
         tf_current_amount = new ClipLabel();
         tf_hint1 = new ClipLabel();
         tf_hint2 = new ClipLabel();
         tf_item_in_stock = new ClipLabel();
         tf_selected_item_name = new ClipLabel();
         item_icon = new InventoryItemIcon();
         marker_slider_container = ClipLayout.none();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_counter_slider = ClipLayout.verticalMiddleCenter(-2,tf_current_amount,marker_slider_container);
         layout_items = ClipLayout.horizontalMiddleCentered(4);
         super();
      }
   }
}
