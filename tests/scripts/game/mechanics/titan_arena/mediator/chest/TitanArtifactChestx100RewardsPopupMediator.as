package game.mechanics.titan_arena.mediator.chest
{
   import game.mechanics.titan_arena.popup.chest.TitanArtifactChestx100RewardsPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class TitanArtifactChestx100RewardsPopupMediator extends PopupMediator
   {
       
      
      private var _rewardsList:Vector.<InventoryItem>;
      
      public function TitanArtifactChestx100RewardsPopupMediator(param1:Player, param2:Vector.<InventoryItem>)
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
         _popup = new TitanArtifactChestx100RewardsPopup(this);
         return new TitanArtifactChestx100RewardsPopup(this);
      }
   }
}
