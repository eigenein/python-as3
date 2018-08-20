package game.view.popup.tower.complete
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class TowerCompleteRewardPopupMediator extends PopupMediator
   {
       
      
      public function TowerCompleteRewardPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      public function get rewardsList() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         _loc2_ = 0;
         while(_loc2_ < player.tower.rewardsList.length)
         {
            _loc3_ = 0;
            while(_loc3_ < player.tower.rewardsList[_loc2_].outputDisplay.length)
            {
               _loc1_.push(player.tower.rewardsList[_loc2_].outputDisplay[_loc3_]);
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerCompleteRewardPopup(this);
         return new TowerCompleteRewardPopup(this);
      }
   }
}
