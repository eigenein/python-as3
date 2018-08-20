package game.mediator.gui.popup.tower
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.tower.TowerFloorDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.PopupResourcePanelMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.tower.PlayerTowerBuffEffect;
   import game.model.user.tower.PlayerTowerChestFloor;
   import game.model.user.tower.PlayerTowerFloor;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.complete.TowerCompleteRewardPopupMediator;
   import game.view.popup.tower.screen.TowerScreen;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class TowerScreenMediator extends PopupMediator
   {
       
      
      private var hasFloorToTransitionTo:Boolean = false;
      
      private var needSmoothTransition:Boolean = false;
      
      private var _signal_floorUpdate:Signal;
      
      private var _signal_updateCanProceed:Signal;
      
      private var _signal_pointsUpdate:Signal;
      
      private var _screenHero:TowerScreenHeroMediator;
      
      private var _resourcePanel:PopupResourcePanelMediator;
      
      private var _transitionController:TowerScreenFloorTransitionController;
      
      private var _signal_buffsUpdate:Signal;
      
      private var _resourceCounters:ResourcePanelValueObjectGroup;
      
      private var _buffList:Vector.<TowerScreenBuffValueObject>;
      
      private var _floorList:Vector.<TowerFloorValueObject>;
      
      public function TowerScreenMediator(param1:Player)
      {
         _signal_floorUpdate = new Signal();
         _signal_updateCanProceed = new Signal();
         _signal_buffsUpdate = new Signal();
         super(param1);
         if(param1.tower.initialized)
         {
            playerTowerDataReady();
         }
         else
         {
            param1.tower.initRequest();
            param1.tower.signal_init.addOnce(playerTowerDataReady);
         }
      }
      
      override protected function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_popup)
         {
            _popup.removeEventListener("addedToStage",popupOnStage);
         }
         if(_transitionController)
         {
            _transitionController.dispose();
         }
         if(_resourceCounters)
         {
            _resourceCounters.dispose();
         }
         if(_screenHero)
         {
            _screenHero.dispose();
         }
         player.tower.signal_effectsUpdated.remove(handler_updateBuffs);
         player.tower.currentFloor.signal_updateCanProceed.remove(handler_updateCanProceed);
         player.tower.floor.signal_update.remove(handler_floorUpdate);
         player.tower.signal_battleComplete.remove(handler_battleComplete);
         if(_floorList)
         {
            _loc1_ = _floorList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _floorList[_loc2_].dispose();
               _loc2_++;
            }
         }
         super.dispose();
      }
      
      public function get mayFullSkip() : Boolean
      {
         return player.tower.mayFullSkip;
      }
      
      public function get chestSkip() : Boolean
      {
         return player.tower.chestSkip;
      }
      
      public function get signal_floorUpdate() : Signal
      {
         return _signal_floorUpdate;
      }
      
      public function get signal_updateCanProceed() : Signal
      {
         return _signal_updateCanProceed;
      }
      
      public function get signal_pointsUpdate() : Signal
      {
         return _signal_pointsUpdate;
      }
      
      public function get screenHero() : TowerScreenHeroMediator
      {
         return _screenHero;
      }
      
      public function get resourcePanel() : PopupResourcePanelMediator
      {
         return _resourcePanel;
      }
      
      public function get transitionController() : TowerScreenFloorTransitionController
      {
         return _transitionController;
      }
      
      public function get signal_buffsUpdate() : Signal
      {
         return _signal_buffsUpdate;
      }
      
      public function get resourceCounters() : ResourcePanelValueObjectGroup
      {
         return _resourceCounters;
      }
      
      public function get buffList() : Vector.<TowerScreenBuffValueObject>
      {
         return _buffList;
      }
      
      public function get points() : int
      {
         return player.tower.points.value;
      }
      
      public function get floorList() : Vector.<TowerFloorValueObject>
      {
         return _floorList;
      }
      
      public function get rewardsList() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc3_:RewardData = new RewardData();
         _loc2_ = 0;
         while(_loc2_ < player.tower.rewardsList.length)
         {
            _loc3_.add(player.tower.rewardsList[_loc2_]);
            _loc2_++;
         }
         var _loc1_:Vector.<InventoryItem> = _loc3_.outputDisplay;
         _loc1_.sort(sortRewards);
         return _loc1_;
      }
      
      private function sortRewards(param1:InventoryItem, param2:InventoryItem) : int
      {
         if(param1.amount < param2.amount)
         {
            return 1;
         }
         if(param1.amount > param2.amount)
         {
            return -1;
         }
         return 0;
      }
      
      public function get currentFloor() : int
      {
         return player.tower.floor.value;
      }
      
      public function get currentFloorIndex() : int
      {
         return _floorList.length - currentFloor - 1;
      }
      
      public function get maxFloorNumber() : int
      {
         return DataStorage.tower.getFloorList().length;
      }
      
      public function get maxCountBattleFloorsTill() : int
      {
         return DataStorage.tower.countBattleFloorsTill(maxFloorNumber);
      }
      
      public function get towerComplete() : Boolean
      {
         return currentFloor >= maxFloorNumber;
      }
      
      public function get currentFloorChestsOpened() : int
      {
         if(player.tower.currentFloor is PlayerTowerChestFloor)
         {
            return (player.tower.currentFloor as PlayerTowerChestFloor).chestsOpened;
         }
         return null;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerScreen(this);
         _popup.addEventListener("addedToStage",popupOnStage);
         return _popup;
      }
      
      public function whenDataReady(param1:Function) : void
      {
         if(player.tower.initialized)
         {
            param1();
         }
         else
         {
            player.tower.signal_init.addOnce(param1);
         }
      }
      
      public function action_shop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(6);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
      }
      
      public function action_rules() : void
      {
         var _loc1_:TowerRulesPopupMediator = new TowerRulesPopupMediator(player);
         _loc1_.open();
      }
      
      public function action_rating() : void
      {
      }
      
      public function action_selectFloor(param1:TowerFloorValueObject) : void
      {
         player.tower.openFloorPopup();
      }
      
      public function action_nextFloor(param1:TowerFloorValueObject) : void
      {
         player.tower.nextFloor();
      }
      
      public function showTowerRewards() : void
      {
         var _loc1_:TowerCompleteRewardPopupMediator = new TowerCompleteRewardPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      protected function playerTowerDataReady() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         _screenHero = new TowerScreenHeroMediator(player);
         TowerFloorValueObject.screenHero = _screenHero.towerScreenHero;
         _signal_pointsUpdate = player.tower.points.signal_update;
         _floorList = new Vector.<TowerFloorValueObject>();
         var _loc2_:Vector.<TowerFloorDescription> = DataStorage.tower.getFloorList();
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = new TowerFloorValueObject(_loc2_[_loc4_]);
            if(player.tower.floor.value == _loc1_.number)
            {
               _loc1_.setPlayerFloor(player.tower.currentFloor);
            }
            _floorList.push(_loc1_);
            _loc4_++;
         }
         _loc1_ = new TowerFloorValueObject(null);
         _floorList.reverse();
         _floorList.push(_loc1_);
         _resourceCounters = new ResourcePanelValueObjectGroup(player);
         _resourceCounters.requre_coin(player.tower.skullCoin);
         _resourceCounters.requre_coin(player.tower.coin);
         _resourcePanel = new PopupResourcePanelMediator();
         _resourcePanel.panel.resourceList = _resourceCounters;
         player.tower.signal_effectsUpdated.add(handler_updateBuffs);
         updateBuffs();
         player.tower.floor.signal_update.add(handler_floorUpdate);
         _transitionController = new TowerScreenFloorTransitionController(this);
         player.tower.signal_battleComplete.add(handler_battleComplete);
      }
      
      private function updateBuffs() : void
      {
         var _loc2_:int = 0;
         _buffList = new Vector.<TowerScreenBuffValueObject>();
         var _loc3_:Vector.<PlayerTowerBuffEffect> = player.tower.getEffectList();
         var _loc1_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _buffList.push(new TowerScreenBuffValueObject(_loc3_[_loc2_]));
            _loc2_++;
         }
         _signal_buffsUpdate.dispatch();
      }
      
      private function handler_updateCanProceed() : void
      {
         _signal_updateCanProceed.dispatch();
      }
      
      private function handler_updateBuffs() : void
      {
         updateBuffs();
      }
      
      private function handler_floorUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         hasFloorToTransitionTo = true;
         if(_popup.stage)
         {
            _loc2_ = (_popup as TowerScreen).getCurrentFloor();
            _transitionController.action_transition(_loc2_,player.tower.floor.value);
         }
         else
         {
            needSmoothTransition = true;
         }
         var _loc6_:PlayerTowerFloor = player.tower.currentFloor;
         var _loc3_:int = _floorList.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _floorList[_loc5_];
            if(_loc4_.number == param1)
            {
               _loc4_.setPlayerFloor(_loc6_);
            }
            else
            {
               _loc4_.setPlayerFloor(null);
            }
            _loc5_++;
         }
         _signal_floorUpdate.dispatch();
         player.tower.currentFloor.signal_updateCanProceed.add(handler_updateCanProceed);
      }
      
      private function popupOnStage(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(hasFloorToTransitionTo)
         {
            if(needSmoothTransition)
            {
               _loc2_ = (_popup as TowerScreen).getCurrentFloor();
               _transitionController.action_transition(_loc2_,player.tower.floor.value);
               needSmoothTransition = false;
            }
            else
            {
               _transitionController.action_setupPosition();
            }
         }
      }
      
      private function handler_battleComplete() : void
      {
         _screenHero.updateTeam();
      }
   }
}
