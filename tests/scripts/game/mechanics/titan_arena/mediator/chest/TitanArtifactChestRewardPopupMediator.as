package game.mechanics.titan_arena.mediator.chest
{
   import feathers.core.PopUpManager;
   import game.command.rpc.stash.StashEventParams;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.rule.TitanArtifactChestRule;
   import game.mechanics.titan_arena.popup.chest.TitanArtifactChestRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.reward.RewardSpiritPopup;
   import idv.cjcat.signals.Signal;
   
   public class TitanArtifactChestRewardPopupMediator extends PopupMediator
   {
       
      
      private var _reOpen:Boolean = false;
      
      private var _rule:TitanArtifactChestRule;
      
      private var _rewardList:Vector.<InventoryItem>;
      
      private var _openAmount:uint;
      
      private var _free:Boolean;
      
      private var _signal_reOpen:Signal;
      
      public function TitanArtifactChestRewardPopupMediator(param1:Player, param2:Vector.<InventoryItem>, param3:uint, param4:Boolean)
      {
         _signal_reOpen = new Signal(uint,Boolean);
         super(param1);
         _rewardList = param2;
         _openAmount = param3;
         _free = param4;
         _rule = DataStorage.rule.titanArtifactChestRule;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      public function get openCostX1() : CostData
      {
         return rule.openCostX1;
      }
      
      public function get openCostX10() : CostData
      {
         return rule.openCostX10;
      }
      
      public function get openCostX100() : CostData
      {
         return rule.openCostX100;
      }
      
      public function get openCostX10Free() : CostData
      {
         return rule.openCostX10Free;
      }
      
      public function get rule() : TitanArtifactChestRule
      {
         return _rule;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      public function get mergedRewardsList() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc6_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:RewardData = new RewardData();
         _loc2_ = 0;
         while(_loc2_ < rewardList.length)
         {
            _loc4_.addFragmentItem(rewardList[_loc2_].item,rewardList[_loc2_].amount);
            _loc2_++;
         }
         var _loc1_:Vector.<InventoryItem> = _loc4_.outputDisplay;
         _loc1_.sort(sortMergedRewardsList);
         var _loc5_:uint = 15;
         if(_loc1_.length > 0 && _loc1_.length < _loc5_)
         {
            _loc6_ = _loc1_.concat();
            _loc6_.sort(sortMergedRewardsListByAmount);
            while(_loc1_.length < _loc5_)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc6_.length)
               {
                  _loc1_.push(new InventoryFragmentItem(_loc6_[_loc3_].item,_loc6_[_loc3_].amount));
                  _loc3_++;
               }
            }
         }
         return _loc1_;
      }
      
      public function setReOpen() : void
      {
         _reOpen = true;
      }
      
      public function get reOpen() : Boolean
      {
         return _reOpen;
      }
      
      public function get openAmount() : uint
      {
         return _openAmount;
      }
      
      public function get free() : Boolean
      {
         return _free;
      }
      
      public function get hasSpiritInReward() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _rewardList.length)
         {
            if(_rewardList[_loc1_].item is TitanArtifactDescription)
            {
               if((_rewardList[_loc1_].item as TitanArtifactDescription).artifactType == "spirit")
               {
                  return true;
               }
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get signal_reOpen() : Signal
      {
         return _signal_reOpen;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_consumable(DataStorage.consumable.getTitanArtifactChestKeyDesc());
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactChestRewardPopup(this);
         return _popup;
      }
      
      public function action_reOpen() : void
      {
         var _loc1_:StashEventParams = Stash.click("get_more",_popup.stashParams);
         _signal_reOpen.dispatch(openAmount,free);
      }
      
      public function action_showX100Rewards() : void
      {
         var _loc1_:TitanArtifactChestx100RewardsPopupMediator = new TitanArtifactChestx100RewardsPopupMediator(GameModel.instance.player,_rewardList);
         _loc1_.open();
      }
      
      public function action_showSpiritReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = {};
         _loc1_ = 0;
         while(_loc1_ < _rewardList.length)
         {
            if(_rewardList[_loc1_].item is TitanArtifactDescription)
            {
               if((_rewardList[_loc1_].item as TitanArtifactDescription).artifactType == "spirit" && !_loc2_[(_rewardList[_loc1_].item as TitanArtifactDescription).id])
               {
                  PopUpManager.addPopUp(new RewardSpiritPopup(_rewardList[_loc1_].item as TitanArtifactDescription));
                  _loc2_[(_rewardList[_loc1_].item as TitanArtifactDescription).id] = true;
               }
            }
            _loc1_++;
         }
      }
      
      private function sortMergedRewardsList(param1:InventoryItem, param2:InventoryItem) : int
      {
         return param2.id - param1.id;
      }
      
      private function sortMergedRewardsListByAmount(param1:InventoryItem, param2:InventoryItem) : int
      {
         return param2.amount - param1.amount;
      }
   }
}
