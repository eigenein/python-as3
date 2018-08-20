package game.mediator.gui.popup.tower
{
   import game.command.tower.CommandTowerNextChest;
   import game.command.tower.CommandTowerNextFloor;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.level.VIPLevel;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.tower.PlayerTowerChestEntry;
   import game.model.user.tower.PlayerTowerChestFloor;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerChestFloorPopup;
   
   public class TowerChestFloorPopupMediator extends PopupMediator
   {
       
      
      private var chestFloor:PlayerTowerChestFloor;
      
      private var _chests:Vector.<TowerChestValueObject>;
      
      public function TowerChestFloorPopupMediator(param1:Player, param2:PlayerTowerChestFloor)
      {
         var _loc4_:int = 0;
         super(param1);
         this.chestFloor = param2;
         _chests = new Vector.<TowerChestValueObject>();
         var _loc5_:Vector.<PlayerTowerChestEntry> = param2.chests;
         var _loc3_:uint = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _chests[_loc4_] = new TowerChestValueObject(_loc5_[_loc4_],param2);
            _chests[_loc4_].signal_selected.add(handler_chestSelected);
            _loc4_++;
         }
      }
      
      override protected function dispose() : void
      {
         var _loc2_:int = 0;
         super.dispose();
         var _loc1_:uint = _chests.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _chests[_loc2_].signal_selected.clear();
            _loc2_++;
         }
      }
      
      public function get isMaxFloor() : Boolean
      {
         return floor == DataStorage.tower.maxFloorNumber;
      }
      
      public function get canProceed() : Boolean
      {
         return player.tower.currentFloor.canProceed;
      }
      
      public function get floor() : int
      {
         return player.tower.floor.value;
      }
      
      public function get chests() : Vector.<TowerChestValueObject>
      {
         return _chests;
      }
      
      public function get rewards() : Vector.<RewardData>
      {
         return chestFloor.rewards;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold();
         _loc1_.requre_starmoney();
         var _loc2_:CoinDescription = DataStorage.coin.getByIdent("tower");
         _loc1_.requre_coin(_loc2_);
         return _loc1_;
      }
      
      public function get goldBonus_vipLevel() : int
      {
         var _loc2_:* = null;
         var _loc1_:RewardModifierDescription = DataStorage.rewardModifier.getRewardModifierById(33);
         if(_loc1_)
         {
            _loc2_ = DataStorage.level.getVipLevelWithRewardMod(_loc1_);
            if(_loc2_)
            {
               return _loc2_.level;
            }
         }
         return 0;
      }
      
      public function get goldBonus_value() : int
      {
         var _loc2_:InventoryItem = rewards[0].outputDisplay[0];
         var _loc1_:RewardModifierDescription = DataStorage.rewardModifier.getRewardModifierById(33);
         if(_loc1_ && _loc2_)
         {
            return Math.round((_loc1_.multiplier - 1) * _loc2_.amount);
         }
         return 0;
      }
      
      public function get playerVipLevel() : int
      {
         return player.vipLevel.level;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerChestFloorPopup(this);
         return new TowerChestFloorPopup(this);
      }
      
      public function action_nextFloor() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(player.tower.chestSkip)
         {
            _loc2_ = GameModel.instance.actionManager.tower.towerNextChest();
            _loc2_.onClientExecute(handler_nextChest);
         }
         else
         {
            _loc1_ = GameModel.instance.actionManager.tower.towerNextFloor();
            _loc1_.onClientExecute(handler_nextFloor);
         }
      }
      
      private function handler_nextFloor(param1:CommandTowerNextFloor) : void
      {
         close();
      }
      
      private function handler_nextChest(param1:CommandTowerNextChest) : void
      {
         close();
      }
      
      private function handler_chestSelected(param1:TowerChestValueObject) : void
      {
         GameModel.instance.actionManager.tower.towerOpenChest(param1);
      }
   }
}
