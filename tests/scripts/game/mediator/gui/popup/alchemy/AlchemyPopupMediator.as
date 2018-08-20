package game.mediator.gui.popup.alchemy
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.refillable.AlchemyRewardValueObject;
   import game.command.rpc.refillable.CommandAlchemyUse;
   import game.data.storage.DataStorage;
   import game.data.storage.level.AlchemyLevel;
   import game.data.storage.level.PlayerTeamLevel;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerAlchemyRefillableEntry;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.view.popup.PopupBase;
   import game.view.popup.alchemy.AlchemyPopup;
   import game.view.popup.hero.TimerQueueDispenser;
   import idv.cjcat.signals.Signal;
   
   public class AlchemyPopupMediator extends PopupMediator implements IRefillableNavigatorResult
   {
       
      
      private var _critWheelData:Vector.<AlchemyPopupCritWheelValueObject>;
      
      public const resultDispenser:TimerQueueDispenser = new TimerQueueDispenser(AlchemyRewardValueObject,300);
      
      private var refillable:PlayerAlchemyRefillableEntry;
      
      private var _nextUseReward:int;
      
      private var unshownRewards:Vector.<AlchemyRewardValueObject>;
      
      protected var _closeAfterRefill:Boolean = true;
      
      protected var _signal_refillCancel:Signal;
      
      protected var _signal_refillComplete:Signal;
      
      public const signal_updateCostAndReward:Signal = new Signal();
      
      private var _nextUseCost_single:InventoryItem;
      
      private var _nextUseCost_multi:InventoryItem;
      
      public function AlchemyPopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         unshownRewards = new Vector.<AlchemyRewardValueObject>();
         _signal_refillCancel = new Signal();
         _signal_refillComplete = new Signal();
         super(param1);
         refillable = param1.refillable.getById(DataStorage.refillable.ALCHEMY.id) as PlayerAlchemyRefillableEntry;
         refillable.signal_update.add(updateCostAndReward);
         updateCostAndReward();
         _critWheelData = new Vector.<AlchemyPopupCritWheelValueObject>();
         var _loc2_:Array = [1,10,1,2,1,5,1,2,1,100];
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _critWheelData[_loc4_] = new AlchemyPopupCritWheelValueObject(_loc2_[_loc4_],_loc4_);
            _loc4_++;
         }
      }
      
      public static function get MULTI_ROLL() : int
      {
         return 10;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         resultDispenser.dispose();
         refillable.signal_update.remove(updateCostAndReward);
      }
      
      public function get critWheelData() : Vector.<AlchemyPopupCritWheelValueObject>
      {
         return _critWheelData;
      }
      
      public function set closeAfterRefill(param1:Boolean) : void
      {
         _closeAfterRefill = param1;
      }
      
      public function get signal_refillCancel() : Signal
      {
         return _signal_refillCancel;
      }
      
      public function get signal_refillComplete() : Signal
      {
         return _signal_refillComplete;
      }
      
      public function get actionAvailable_single() : Boolean
      {
         return 1 <= availableCount;
      }
      
      public function get actionAvailable_multi() : Boolean
      {
         return MULTI_ROLL <= availableCount;
      }
      
      public function get availableCount() : int
      {
         return refillable.maxRefillCount - refillable.refillCount;
      }
      
      public function get usedCount() : int
      {
         return refillable.refillCount;
      }
      
      public function get maxUseCount() : int
      {
         return refillable.maxRefillCount;
      }
      
      public function get nextVipAdditionalAttempts() : int
      {
         return refillable.getVipLevelRefillCount(nextVipLevel) - maxUseCount;
      }
      
      public function get nextVipLevel() : int
      {
         return refillable.getVipLevelToRefill(maxUseCount + 1);
      }
      
      public function get nextUseCost_single() : InventoryItem
      {
         return _nextUseCost_single;
      }
      
      public function get nextUseCost_multi() : InventoryItem
      {
         return _nextUseCost_multi;
      }
      
      public function get nextUseReward() : int
      {
         return _nextUseReward;
      }
      
      public function get rewardList() : Vector.<AlchemyRewardValueObject>
      {
         return refillable.sessionRewards;
      }
      
      public function get hasUnshownReward() : Boolean
      {
         return unshownRewards.length > 0;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold(false);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new AlchemyPopup(this);
         return _popup;
      }
      
      public function action_use_multi() : void
      {
         _action_use(false);
      }
      
      public function action_use_single() : void
      {
         _action_use(true);
      }
      
      public function getNextUnshownReward() : AlchemyRewardValueObject
      {
         return unshownRewards.shift();
      }
      
      protected function _action_use(param1:Boolean = true) : void
      {
         var _loc2_:* = null;
         if(param1 && actionAvailable_single || !param1 && actionAvailable_multi)
         {
            _loc2_ = GameModel.instance.actionManager.refillableGoldBuy(!param1);
            _loc2_.onClientExecute(onUse);
         }
         else if(nextVipLevel == -1)
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_REFILL_IMPOSSIBLE"),"");
         }
         else
         {
            PopupList.instance.popup_vip_needed(Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_ALCHEMY"),nextVipLevel);
         }
      }
      
      protected function updateCostAndReward() : void
      {
         var _loc2_:* = null;
         _loc2_ = null;
         _nextUseReward = 0;
         var _loc1_:PlayerTeamLevel = player.levelData.level;
         if(actionAvailable_single)
         {
            _loc2_ = DataStorage.level.getAlchemyLevel(refillable.refillCount);
            _nextUseCost_single = _loc2_.cost.outputDisplay[0];
            _nextUseCost_multi = new InventoryItem(_nextUseCost_single.item,_nextUseCost_single.amount * MULTI_ROLL);
            _nextUseReward = _loc2_.getGoldAtTeamLevel(_loc1_);
         }
         else
         {
            _loc2_ = DataStorage.level.getAlchemyLevel(refillable.refillCount);
            _nextUseCost_single = _loc2_.cost.outputDisplay[0];
            _nextUseCost_multi = new InventoryItem(_nextUseCost_single.item,_nextUseCost_single.amount * MULTI_ROLL);
            _nextUseReward = _loc2_.getGoldAtTeamLevel(_loc1_);
         }
         signal_updateCostAndReward.dispatch();
      }
      
      private function onUse(param1:CommandAlchemyUse) : void
      {
         refillable.addRewards(param1.rewardList);
         resultDispenser.add(param1.rewardList);
         updateCostAndReward();
      }
      
      public function action_addReward(param1:AlchemyRewardValueObject) : void
      {
         player.takeReward(param1.reward);
      }
   }
}
