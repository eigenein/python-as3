package game.mediator.gui.popup.tower
{
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerRewardDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerRulesPopup;
   
   public class TowerRulesPopupMediator extends PopupMediator
   {
       
      
      private var _myReward:Vector.<InventoryItem>;
      
      private var _rewardsByPlace:Vector.<TowerRewardDescription>;
      
      public function TowerRulesPopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         super(param1);
         _rewardsByPlace = DataStorage.tower.getRewardList();
         var _loc2_:int = param1.tower.points.value;
         var _loc3_:int = _rewardsByPlace.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_ >= _rewardsByPlace[_loc4_].pointsEarned)
            {
               _myReward = _rewardsByPlace[_loc4_].reward.outputDisplay.slice();
               break;
            }
            _loc4_++;
         }
      }
      
      public function get myPoints() : int
      {
         return player.tower.points.value;
      }
      
      public function get myReward() : Vector.<InventoryItem>
      {
         return _myReward;
      }
      
      public function get rewardsByPlace() : Vector.<TowerRewardDescription>
      {
         return _rewardsByPlace;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerRulesPopup(this);
         return _popup;
      }
   }
}
