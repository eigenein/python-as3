package game.view.popup.hero.consumable
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.component.ToggleComponent;
   import game.mediator.gui.popup.inventory.ToggleableInventoryItemValueObject;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class HeroUseConsumableWithSelectorConsumableItemClip extends ClipButton
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var tf_value:ClipLabel;
      
      public var bg_value:GuiClipScale3Image;
      
      public var tf_amount:ClipLabel;
      
      public var bg_amount:GuiClipScale3Image;
      
      public var selection:GuiClipScale9Image;
      
      private var item:InventoryItemValueObject;
      
      private var toggle:ToggleComponent;
      
      public function HeroUseConsumableWithSelectorConsumableItemClip()
      {
         tf_value = new ClipLabel(true);
         tf_amount = new ClipLabel(true);
         super();
      }
      
      public function get isSelected() : Boolean
      {
         return toggle && toggle.property_selected.value;
      }
      
      public function setData(param1:ToggleableInventoryItemValueObject, param2:ToggleComponent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         setToggle(param2);
         setItem(param1);
         if(param1.item is ConsumableDescription)
         {
            _loc4_ = (param1.item as ConsumableDescription).rewardAmount;
            tf_value.text = "+" + String(_loc4_);
            _loc3_ = param1 is InventoryFragmentItem?15:0;
            tf_value.x = item_image.graphics.x + 4 + _loc3_;
            tf_value.validate();
            alignBackground(tf_value,bg_value,_loc3_ + 5,2,2,5);
         }
      }
      
      override public function click() : void
      {
         super.click();
         toggle.select();
      }
      
      protected function setItem(param1:InventoryItemValueObject) : void
      {
         if(this.item)
         {
            this.item.signal_amountUpdate.remove(handler_amountUpdate);
         }
         this.item = param1;
         if(param1)
         {
            handler_amountUpdate();
            param1.signal_amountUpdate.add(handler_amountUpdate);
            item_image.image.texture = AssetStorageUtil.getItemTexture(param1.inventoryItem);
            item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(param1.inventoryItem);
         }
      }
      
      protected function setToggle(param1:ToggleComponent) : void
      {
         if(this.toggle)
         {
            this.toggle.property_selected.unsubscribe(handler_selected);
         }
         this.toggle = param1;
         if(this.toggle)
         {
            this.toggle.property_selected.onValue(handler_selected);
         }
      }
      
      private function alignBackground(param1:ClipLabel, param2:GuiClipScale3Image, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         param2.image.x = param1.x - param3;
         param2.image.y = param1.y - param5;
         param2.image.width = param1.x + param1.width + param4 - param2.image.x;
         param2.image.height = param1.y + param1.height + param6 - param2.image.y;
      }
      
      private function setAvailable(param1:Boolean) : void
      {
         if(param1)
         {
            if(graphics.filter)
            {
               graphics.filter.dispose();
               graphics.filter = null;
            }
            graphics.alpha = 1;
         }
         else
         {
            if(!graphics.filter)
            {
               graphics.filter = AssetStorage.rsx.popup_theme.filter_disabled;
            }
            graphics.alpha = 0.3;
         }
         var _loc2_:* = param1 && !(!!toggle?toggle.property_selected.value:false);
         graphics.touchable = _loc2_;
         isEnabled = _loc2_;
      }
      
      private function handler_selected(param1:Boolean) : void
      {
         if(selection)
         {
            selection.graphics.visible = param1;
         }
         var _loc2_:* = !param1 && (!!item?item.ownedAmount > 0:false);
         graphics.touchable = _loc2_;
         isEnabled = _loc2_;
      }
      
      private function handler_amountUpdate() : void
      {
         var _loc1_:int = 0;
         if(item)
         {
            _loc1_ = item.ownedAmount;
         }
         else
         {
            _loc1_ = 0;
         }
         setAvailable(_loc1_ > 0);
         tf_amount.text = String(_loc1_);
         tf_amount.validate();
         tf_amount.adjustSizeToFitWidth(item_image.image.width - 6);
         tf_amount.x = item_image.image.x + item_image.image.width - tf_amount.width - 2;
         alignBackground(tf_amount,bg_amount,3,3,0,6);
      }
   }
}
