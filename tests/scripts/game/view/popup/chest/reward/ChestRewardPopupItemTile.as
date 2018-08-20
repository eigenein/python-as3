package game.view.popup.chest.reward
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorageUtil;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.InventoryItemCounterClip;
   
   public class ChestRewardPopupItemTile extends GuiClipNestedContainer
   {
       
      
      public var tf_item_name:ClipLabel;
      
      public var item_border_image:GuiClipImage;
      
      public var item_counter:InventoryItemCounterClip;
      
      public var item_image:GuiClipImage;
      
      public function ChestRewardPopupItemTile()
      {
         super();
      }
      
      public function set data(param1:InventoryItem) : void
      {
         tf_item_name.wordWrap = true;
         tf_item_name.text = param1.name;
         item_counter.maxWidth = item_image.image.width;
         item_counter.text = param1.amount.toString();
         item_image.image.texture = AssetStorageUtil.getItemTexture(param1);
         item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
      }
   }
}
