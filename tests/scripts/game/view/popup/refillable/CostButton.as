package game.view.popup.refillable
{
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorageUtil;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class CostButton extends ClipButton
   {
       
      
      public var tf_item_cost:ClipLabel;
      
      public var icon_currency:GuiClipImage;
      
      public var layout_cost:ClipLayout;
      
      public function CostButton()
      {
         tf_item_cost = new ClipLabel(true);
         icon_currency = new GuiClipImage();
         layout_cost = ClipLayout.horizontalMiddleCentered(4,icon_currency,tf_item_cost);
         super();
      }
      
      public function set cost(param1:InventoryItem) : void
      {
         icon_currency.image.texture = AssetStorageUtil.getItemGUIIcon(param1.item);
         tf_item_cost.text = param1.amount.toString();
      }
   }
}
