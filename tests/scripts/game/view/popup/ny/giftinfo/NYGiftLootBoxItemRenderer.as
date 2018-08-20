package game.view.popup.ny.giftinfo
{
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class NYGiftLootBoxItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:RewardItemClip;
      
      public function NYGiftLootBoxItemRenderer()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(RewardItemClip,"inventory_tile");
         addChild(clip.container);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid("data") && data && clip)
         {
            clip.data = data as InventoryItem;
            clip.item_counter.graphics.visible = false;
         }
      }
   }
}
