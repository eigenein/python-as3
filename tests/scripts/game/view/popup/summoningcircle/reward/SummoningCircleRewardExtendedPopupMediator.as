package game.view.popup.summoningcircle.reward
{
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class SummoningCircleRewardExtendedPopupMediator extends PopupMediator
   {
       
      
      private var _rewardsList:Vector.<InventoryItem>;
      
      public function SummoningCircleRewardExtendedPopupMediator(param1:Player, param2:Vector.<InventoryItem>)
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
         _popup = new SummoningCircleRewardExtendedPopup(this);
         return new SummoningCircleRewardExtendedPopup(this);
      }
   }
}
