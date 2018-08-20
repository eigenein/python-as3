package game.view.popup.fightresult.pve
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class MissionRewardPopupRewardRenderer extends ListItemRenderer
   {
       
      
      private var clip:InventoryItemRenderer;
      
      public function MissionRewardPopupRewardRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TooltipHelper.removeTooltip(this);
      }
      
      override public function set data(param1:Object) : void
      {
         .super.data = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
         addChild(clip.graphics);
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = null;
         if(data)
         {
            _loc1_ = data as InventoryItem;
            clip.setData(_loc1_);
         }
      }
   }
}
