package game.view.popup.refillable
{
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorageUtil;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   
   public class CostButtonWithSale extends CostButton
   {
       
      
      private var hasNewPrice:Boolean;
      
      private var hasOldPrice:Boolean;
      
      public var block_old_cost:ClipLabelCrossed;
      
      public var tf_new_cost:ClipLabel;
      
      public function CostButtonWithSale()
      {
         block_old_cost = new ClipLabelCrossed();
         tf_new_cost = new ClipLabel(true);
         super();
         (layout_cost.layout as HorizontalLayout).gap = 1;
      }
      
      override public function set cost(param1:InventoryItem) : void
      {
         icon_currency.image.texture = AssetStorageUtil.getItemGUIIcon(param1.item);
         var _loc2_:String = param1.amount;
         tf_item_cost.text = _loc2_;
         tf_new_cost.text = _loc2_;
         hasNewPrice = param1 && param1.amount != 0;
         updateSaleVisibility();
      }
      
      public function set oldCost(param1:InventoryItem) : void
      {
         block_old_cost.text = String(param1.amount);
         updateSaleVisibility();
         hasOldPrice = param1 && param1.amount != 0;
         updateSaleVisibility();
      }
      
      protected function updateSaleVisibility() : void
      {
         var _loc1_:Boolean = hasOldPrice && hasNewPrice;
         block_old_cost.graphics.visible = _loc1_;
         tf_new_cost.graphics.visible = _loc1_;
         tf_item_cost.graphics.visible = !_loc1_;
         if(_loc1_)
         {
            layout_cost.addChild(block_old_cost.graphics);
            layout_cost.addChild(tf_new_cost);
         }
         else
         {
            if(block_old_cost.graphics.parent)
            {
               block_old_cost.graphics.removeFromParent();
            }
            if(tf_new_cost.parent)
            {
               tf_new_cost.removeFromParent();
            }
         }
      }
   }
}
