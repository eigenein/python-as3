package game.view.popup.inventory
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.InventoryItemCounterClip;
   
   public class PlayerInventoryItemTile extends ClipButton
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_counter:InventoryItemCounterClip;
      
      public var item_image:GuiClipImage;
      
      public var marker_new:ClipSprite;
      
      public function PlayerInventoryItemTile()
      {
         super();
      }
      
      public function set data(param1:InventoryItem) : void
      {
         if(param1.item is TitanDescription)
         {
            item_counter.graphics.y = 43;
         }
         else
         {
            item_counter.graphics.y = 51;
         }
         item_counter.text = param1.amount.toString();
         item_counter.maxWidth = item_image.image.width;
         item_image.image.texture = AssetStorageUtil.getItemTexture(param1);
         item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(marker_new)
         {
            marker_new.graphics.touchable = false;
         }
      }
   }
}
