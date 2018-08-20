package game.view.popup.shop
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorageUtil;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   
   public class ShopCostPanel extends GuiClipNestedContainer
   {
       
      
      public var tf_item_cost:ClipLabel;
      
      public var icon_currency:GuiClipImage;
      
      public var pricePlate:GuiClipScale3Image;
      
      private var _costData:InventoryItem;
      
      public function ShopCostPanel()
      {
         super();
         tf_item_cost = new ClipLabel(true);
         icon_currency = new GuiClipImage();
         pricePlate = new GuiClipScale3Image(12,1);
      }
      
      public function get costData() : InventoryItem
      {
         return _costData;
      }
      
      public function set costData(param1:InventoryItem) : void
      {
         if(_costData == param1)
         {
            return;
         }
         _costData = param1;
         icon_currency.image.texture = AssetStorageUtil.getItemGUIIcon(param1.item);
         tf_item_cost.text = param1.amount.toString();
         tf_item_cost.validate();
         pricePlate.graphics.width = tf_item_cost.width + 30;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
