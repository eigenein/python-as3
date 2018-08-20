package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.InventoryItemIcon;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItemCraftRecipe extends ClipListItem
   {
       
      
      public var item_icon:InventoryItemIcon;
      
      public var tf_green_count_available:ClipLabel;
      
      public var tf_green_count_total:ClipLabel;
      
      public var tf_count_available:ClipLabel;
      
      public var tf_count_total:ClipLabel;
      
      public var tf_action:ClipLabel;
      
      public var image_plus_seek:ClipSprite;
      
      public var black_text_bg:ClipSprite;
      
      public var layout:ClipLayout;
      
      private var data:InventoryItemValueObject;
      
      private const _signal_select:Signal = new Signal(Object);
      
      public function ClipListItemCraftRecipe()
      {
         tf_green_count_available = new ClipLabel(true);
         tf_green_count_total = new ClipLabel(true);
         tf_count_available = new ClipLabel(true);
         tf_count_total = new ClipLabel(true);
         tf_action = new ClipLabel();
         image_plus_seek = new ClipSprite();
         black_text_bg = new ClipSprite();
         layout = ClipLayout.horizontalBottomCentered(-1,tf_green_count_available,tf_count_available,tf_green_count_total,tf_count_total);
         super();
         item_icon = new InventoryItemIcon();
         item_icon.signal_click.add(onItemSelected);
         tf_green_count_total.height = 21;
         tf_count_total.height = 21;
      }
      
      override public function dispose() : void
      {
         if(this.data)
         {
            this.data.signal_amountUpdate.remove(handler_amountUpdated);
         }
      }
      
      override public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         image_plus_seek.graphics.touchable = false;
         black_text_bg.graphics.touchable = false;
         tf_action.touchable = false;
      }
      
      override public function setData(param1:*) : void
      {
         if(this.data)
         {
            this.data.signal_amountUpdate.remove(handler_amountUpdated);
         }
         var _loc2_:InventoryItemValueObject = param1 as InventoryItemValueObject;
         if(!_loc2_)
         {
            return;
         }
         this.data = _loc2_;
         item_icon.setItem(_loc2_.inventoryItem);
         updateText();
         _loc2_.signal_amountUpdate.add(handler_amountUpdated);
         handler_amountUpdated();
      }
      
      protected function setText(param1:String = null) : void
      {
         var _loc2_:* = param1 != null;
         black_text_bg.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         image_plus_seek.graphics.visible = _loc2_;
         tf_action.graphics.visible = _loc2_;
         if(param1)
         {
            tf_action.text = param1;
         }
         else
         {
            tf_action.text = "";
         }
         tf_action.adjustSizeToFitWidth();
      }
      
      private function updateText() : void
      {
         if(data)
         {
            switch(int(data.stateAsHeroSlotState) - 3)
            {
               case 0:
                  setText(Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_SEEK"));
                  break;
               case 1:
                  setText(Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CRAFT"));
            }
         }
      }
      
      protected function onItemSelected() : void
      {
         _signal_select.dispatch(data);
      }
      
      protected function handler_amountUpdated() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = false;
         if(data)
         {
            _loc1_ = data.ownedAmount;
            _loc3_ = data.amount;
            _loc2_ = _loc1_ >= _loc3_;
            var _loc4_:* = _loc2_;
            tf_green_count_total.visible = _loc4_;
            tf_green_count_available.visible = _loc4_;
            _loc4_ = !_loc2_;
            tf_count_total.visible = _loc4_;
            tf_count_available.visible = _loc4_;
            if(_loc2_)
            {
               tf_green_count_available.text = String(_loc1_);
               tf_green_count_total.text = "/" + _loc3_;
            }
            else
            {
               tf_count_available.text = String(_loc1_);
               tf_count_total.text = "/" + _loc3_;
            }
         }
         updateText();
      }
   }
}
