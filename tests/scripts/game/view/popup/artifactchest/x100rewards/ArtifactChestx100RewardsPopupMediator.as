package game.view.popup.artifactchest.x100rewards
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class ArtifactChestx100RewardsPopupMediator extends PopupMediator
   {
       
      
      private var _rewardsList:Vector.<InventoryItem>;
      
      public function ArtifactChestx100RewardsPopupMediator(param1:Player, param2:Vector.<InventoryItem>)
      {
         super(param1);
         _rewardsList = param2;
      }
      
      public function get rewardsList() : Vector.<InventoryItem>
      {
         return _rewardsList;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactChestx100RewardsPopup(this);
         return new ArtifactChestx100RewardsPopup(this);
      }
   }
}
