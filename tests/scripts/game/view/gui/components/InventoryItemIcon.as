package game.view.gui.components
{
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   
   public class InventoryItemIcon extends ClipButton
   {
       
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public function InventoryItemIcon()
      {
         super();
      }
      
      public function setItemDescription(param1:InventoryItemDescription) : void
      {
         image_frame.image.texture = AssetStorageUtil.getItemDescFrameTexture(param1);
         image_item.image.texture = AssetStorageUtil.getItemDescTexture(param1);
      }
      
      public function setItem(param1:InventoryItem) : void
      {
         image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
         image_item.image.texture = AssetStorageUtil.getItemTexture(param1);
      }
      
      public function setItemProxy(param1:InventoryItemCountProxy) : void
      {
         image_frame.image.texture = AssetStorageUtil.getProxyFrameTexture(param1);
         image_item.image.texture = AssetStorageUtil.getItemDescTexture(param1.item);
      }
   }
}
