package game.view.popup.friends.socialquest
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.InventoryItemCounterClip;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   
   public class RewardItemClip extends GuiClipNestedContainer
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_counter:InventoryItemCounterClip;
      
      public var item_image:GuiClipImage;
      
      public function RewardItemClip()
      {
         super();
      }
      
      public function set data(param1:InventoryItem) : void
      {
         if(param1.amount > 1)
         {
            item_counter.graphics.visible = true;
            item_counter.text = param1.amount.toString();
            item_counter.maxWidth = item_image.image.width;
         }
         else
         {
            item_counter.graphics.visible = false;
         }
         item_image.image.texture = AssetStorageUtil.getItemTexture(param1);
         item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
         TooltipHelper.removeTooltip(graphics);
         var _loc2_:TooltipVO = new TooltipVO(InventoryItemInfoTooltip,param1);
         TooltipHelper.addTooltip(graphics,_loc2_);
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
   }
}
