package game.view.popup.common
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.component.SelectableInventoryItemValueObject;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.controller.TouchHoldController;
   import game.view.popup.hero.rune.HeroRunePopupInventoryItemClip;
   
   public class ClipListItemSelectableInventoryItem extends ClipListItem
   {
       
      
      private var data:SelectableInventoryItemValueObject;
      
      private var incrementHold:TouchHoldController;
      
      private var decrementHold:TouchHoldController;
      
      public var button_minus:ClipButton;
      
      public var button_plus:HeroRunePopupInventoryItemClip;
      
      public function ClipListItemSelectableInventoryItem()
      {
         super();
      }
      
      override public function dispose() : void
      {
         setData(null);
      }
      
      override public function setData(param1:*) : void
      {
         if(this.data)
         {
            this.data.signal_selectedAmountChanged.remove(handler_selectedAmountChanged);
            this.data.signal_amountUpdate.remove(handler_amountUpdate);
         }
         var _loc2_:SelectableInventoryItemValueObject = param1 as SelectableInventoryItemValueObject;
         if(!_loc2_)
         {
            return;
         }
         this.data = _loc2_;
         this.data.signal_selectedAmountChanged.add(handler_selectedAmountChanged);
         this.data.signal_amountUpdate.add(handler_amountUpdate);
         button_plus.item_image.image.texture = AssetStorageUtil.getItemTexture(_loc2_.inventoryItem);
         button_plus.item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(_loc2_.inventoryItem);
         var _loc3_:int = _loc2_.inventoryItem is InventoryFragmentItem?15:0;
         button_plus.tf_value.x = button_plus.item_image.graphics.x + 4 + _loc3_;
         button_plus.tf_value.text = String(_loc2_.value);
         button_plus.tf_value.validate();
         alignBackground(button_plus.tf_value,button_plus.bg_value,_loc3_ + 8,5,2,0);
         updateAmounts(_loc2_);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         incrementHold = new TouchHoldController(button_plus.container,2,5);
         decrementHold = new TouchHoldController(button_minus.container,2,5);
         incrementHold.signal_hold.add(handler_select);
         decrementHold.signal_hold.add(handler_deselect);
      }
      
      protected function updateAmounts(param1:SelectableInventoryItemValueObject) : void
      {
         var _loc2_:int = param1.selectedAmount;
         if(_loc2_)
         {
            button_plus.tf_amount.text = String(_loc2_) + " / " + String(param1.ownedAmount);
         }
         else
         {
            button_plus.tf_amount.text = String(param1.ownedAmount);
         }
         if(param1.ownedAmount > 0)
         {
            if(graphics.filter)
            {
               graphics.filter.dispose();
               graphics.filter = null;
            }
            graphics.alpha = 1;
            graphics.touchable = true;
         }
         else
         {
            if(!graphics.filter)
            {
               graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
            }
            graphics.alpha = 0.3;
            graphics.touchable = false;
         }
         button_plus.tf_amount.validate();
         button_plus.tf_amount.adjustSizeToFitWidth(button_plus.item_image.image.width - 6);
         button_plus.tf_amount.x = button_plus.item_image.image.x + button_plus.item_image.image.width - button_plus.tf_amount.width - 1;
         alignBackground(button_plus.tf_amount,button_plus.bg_amount,5,6,4,6);
         var _loc3_:* = param1.canDecrease;
         decrementHold.isEnabled = _loc3_;
         _loc3_ = _loc3_;
         button_minus.isEnabled = _loc3_;
         button_minus.graphics.visible = _loc3_;
         _loc3_ = param1.canIncrease;
         incrementHold.isEnabled = _loc3_;
         button_plus.isEnabled = _loc3_;
      }
      
      private function alignBackground(param1:ClipLabel, param2:GuiClipScale3Image, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         param2.image.x = param1.x - param3;
         param2.image.y = param1.y - param5;
         param2.image.width = param1.x + param1.width + param4 - param2.image.x;
         param2.image.height = param1.y + param1.height + param6 - param2.image.y;
      }
      
      private function handler_select() : void
      {
         if(data)
         {
            data.increaseAmount();
         }
      }
      
      private function handler_deselect() : void
      {
         if(data)
         {
            data.decreaseAmount();
         }
      }
      
      private function handler_selectedAmountChanged(param1:SelectableInventoryItemValueObject) : void
      {
         updateAmounts(param1);
      }
      
      private function handler_amountUpdate() : void
      {
         updateAmounts(data);
      }
   }
}
