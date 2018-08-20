package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemIcon;
   
   public class PlayerInventoryPopupSelectedItemClip extends GuiClipNestedContainer
   {
       
      
      private var item:InventoryItem;
      
      public var button_sell:ClipButtonLabeled;
      
      public var button_use:ClipButtonLabeled;
      
      public var item_icon:InventoryItemIcon;
      
      public var desc_bg:GuiClipScale9Image;
      
      public var tf_sell_cost:ClipLabel;
      
      public var icon_gold:GuiClipImage;
      
      public var tf_sell_cost_label:ClipLabel;
      
      public var sell_cost_bg:GuiClipScale9Image;
      
      public var tf_stock_count:ClipLabel;
      
      public var tf_selected_item_name:ClipLabel;
      
      public var tf_item_in_stock:ClipLabel;
      
      public var tf_item_in_stock_label:ClipLabel;
      
      public var layout_in_stock:ClipLayout;
      
      public var tf_item_desc_text:ClipLabel;
      
      public var layout_sell_cost:ClipLayout;
      
      public var layout_btns:ClipLayout;
      
      public var itemDesc:ItemDescriptionClip;
      
      public function PlayerInventoryPopupSelectedItemClip()
      {
         super();
         tf_sell_cost = new ClipLabel(true);
         icon_gold = new GuiClipImage();
         tf_sell_cost_label = new ClipLabel(true);
         sell_cost_bg = new GuiClipScale9Image();
         button_sell = new ClipButtonLabeled();
         button_use = new ClipButtonLabeled();
         tf_stock_count = new ClipLabel();
         tf_selected_item_name = new ClipLabel();
         tf_item_in_stock = new ClipLabel(true);
         tf_item_in_stock_label = new ClipLabel(true);
         layout_in_stock = ClipLayout.horizontal(4,tf_item_in_stock_label,tf_item_in_stock);
         tf_item_desc_text = new ClipLabel();
         tf_item_desc_text.wordWrap = true;
         desc_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_sell_cost = ClipLayout.horizontalCentered(4,tf_sell_cost_label,icon_gold,tf_sell_cost);
         (layout_sell_cost.layout as HorizontalLayout).verticalAlign = "middle";
         layout_btns = ClipLayout.horizontalCentered(-2,button_use,button_sell);
      }
      
      public function dispose() : void
      {
         if(item)
         {
            item.signal_update.remove(handler_amountUpdate);
         }
      }
      
      private function setSellCost(param1:RewardData) : void
      {
         if(param1.gold > 0)
         {
            tf_sell_cost.text = param1.gold.toString();
            icon_gold.image.texture = AssetStorage.rsx.popup_theme.getTexture("icon_gold_coin");
         }
         else
         {
            tf_sell_cost.text = param1.outputDisplayFirst.amount.toString();
            icon_gold.image.texture = AssetStorage.rsx.popup_theme.getTexture(param1.outputDisplayFirst.item.iconAssetTexture);
         }
      }
      
      public function setSelectedItem(param1:InventoryItem, param2:Vector.<BattleStatValueObject>, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false) : void
      {
         if(this.item)
         {
            param1.signal_update.remove(handler_amountUpdate);
         }
         this.item = param1;
         if(this.item)
         {
            param1.signal_update.add(handler_amountUpdate);
         }
         tf_selected_item_name.text = param1.name;
         updateAmountDisplay();
         item_icon.setItem(param1);
         if(param4)
         {
            setSellCost(param1.sellCost);
         }
         button_sell.graphics.visible = param4;
         layout_sell_cost.graphics.visible = param4;
         sell_cost_bg.graphics.visible = param4;
         itemDesc.setData(param1,param2);
         button_use.graphics.visible = param3 || param5;
         if(param3)
         {
            button_use.label = Translate.translate("UI_DIALOG_INVENTORY_USE");
         }
         else
         {
            button_use.label = Translate.translate("UI_DIALOG_INVENTORY_INFO");
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_sell_cost_label.text = Translate.translate("UI_DIALOG_INVENTORY_SELL_COST");
         tf_item_in_stock_label.text = Translate.translate("UI_DIALOG_INVENTORY_AMOUNT");
         button_sell.label = Translate.translate("UI_DIALOG_INVENTORY_SELL");
         button_use.label = Translate.translate("UI_DIALOG_INVENTORY_USE");
         tf_item_desc_text.height = NaN;
      }
      
      private function updateAmountDisplay() : void
      {
         tf_item_in_stock.text = item.amount.toString();
         var _loc2_:* = item.amount > 0;
         var _loc1_:Number = !!_loc2_?1:0;
         button_sell.isEnabled = _loc2_;
         button_use.isEnabled = _loc2_;
         button_sell.graphics.alpha = _loc1_;
         layout_sell_cost.graphics.alpha = _loc1_;
         sell_cost_bg.graphics.alpha = _loc1_;
         button_use.graphics.alpha = _loc1_;
      }
      
      private function handler_amountUpdate(param1:InventoryItem) : void
      {
         updateAmountDisplay();
      }
   }
}
