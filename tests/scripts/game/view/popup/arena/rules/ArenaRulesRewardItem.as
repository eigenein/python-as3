package game.view.popup.arena.rules
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   
   public class ArenaRulesRewardItem extends GuiClipNestedContainer
   {
       
      
      public var tf_amount:ClipLabel;
      
      public var icon_image:GuiClipImage;
      
      public function ArenaRulesRewardItem()
      {
         tf_amount = new ClipLabel(true);
         icon_image = new GuiClipImage();
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function set data(param1:InventoryItem) : void
      {
         graphics.visible = param1;
         if(param1)
         {
            icon_image.image.texture = AssetStorageUtil.getItemTexture(param1);
            tf_amount.text = param1.amount.toString();
            tf_amount.validate();
            TooltipHelper.addTooltip(graphics,new TooltipVO(InventoryItemInfoTooltip,param1));
         }
      }
   }
}
