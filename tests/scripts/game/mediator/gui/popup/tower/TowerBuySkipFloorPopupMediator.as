package game.mediator.gui.popup.tower
{
   import game.command.tower.CommandTowerBuySkipFloor;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerFloorDescription;
   import game.data.storage.tower.TowerFloorType;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class TowerBuySkipFloorPopupMediator extends PopupMediator
   {
       
      
      public function TowerBuySkipFloorPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      public function get maxSkipFloor() : int
      {
         return DataStorage.rule.towerRule.maxSkipFloor;
      }
      
      public function get skipCost() : CostData
      {
         var _loc3_:int = 0;
         var _loc2_:CostData = new CostData();
         var _loc1_:Vector.<TowerFloorDescription> = DataStorage.tower.getFloorList();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_].floor >= player.tower.floor.value && _loc1_[_loc3_].floor <= maxSkipFloor && _loc1_[_loc3_].type == TowerFloorType.BATTLE)
            {
               _loc2_.add(DataStorage.rule.towerRule.skipCost.clone());
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerBuySkipFloorPopup(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      public function buySkip() : void
      {
         var _loc1_:CommandTowerBuySkipFloor = GameModel.instance.actionManager.tower.towerBuySkipFloor(skipCost);
         _loc1_.onClientExecute(handler_onFloorBuySkipCommandResult);
         close();
      }
      
      private function handler_onFloorBuySkipCommandResult(param1:CommandTowerBuySkipFloor) : void
      {
         GameModel.instance.actionManager.tower.towerSkipFloor();
      }
   }
}
