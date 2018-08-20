package game.view.popup.artifactchest.rewardpopup
{
   import game.command.rpc.stash.StashEventParams;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactChestLevel;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.rule.ArtifactChestRule;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.artifactchest.PlayerArtifactChest;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.stat.Stash;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.PopupBase;
   import game.view.popup.artifactchest.leveluprewardpopup.ArtifactChestLevelUpRewardPopupMediator;
   import game.view.popup.artifactchest.x100rewards.ArtifactChestx100RewardsPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class ArtifactChestRewardPopupMediator extends PopupMediator
   {
       
      
      private var _reOpen:Boolean = false;
      
      private var _rule:ArtifactChestRule;
      
      private var _reward:RewardValueObjectList;
      
      private var _levelUpRewards:Vector.<ArtifactChestLevelUpRewardVO>;
      
      private var _openAmount:uint;
      
      private var _free:Boolean;
      
      private var _signal_reOpen:Signal;
      
      public function ArtifactChestRewardPopupMediator(param1:Player, param2:RewardValueObjectList, param3:uint, param4:Boolean, param5:Vector.<ArtifactChestLevelUpRewardVO>)
      {
         _signal_reOpen = new Signal(uint,Boolean);
         super(param1);
         _reward = param2;
         _levelUpRewards = param5;
         if(_levelUpRewards)
         {
            _levelUpRewards.sort(sortLevelUpRewards);
         }
         _openAmount = param3;
         _free = param4;
         _rule = DataStorage.rule.artifactChestRule;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      public function get openCostX1() : CostData
      {
         return player.artifactChest.getOpenCostX1(player);
      }
      
      public function get openCostX10() : CostData
      {
         return player.artifactChest.getOpenCostX10(player);
      }
      
      public function get openCostX100() : CostData
      {
         return player.artifactChest.getOpenCostX100(player);
      }
      
      public function get openCostX10Free() : CostData
      {
         return player.artifactChest.getOpenCostX10Free(player);
      }
      
      public function get rule() : ArtifactChestRule
      {
         return _rule;
      }
      
      public function get reward() : RewardValueObjectList
      {
         return _reward;
      }
      
      public function get mergedRewardsList() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc3_:RewardData = new RewardData();
         _loc2_ = 0;
         while(_loc2_ < reward.rewardValueObjectList.length)
         {
            _loc3_.add(reward.rewardValueObjectList[_loc2_].reward);
            _loc2_++;
         }
         var _loc1_:Vector.<InventoryItem> = _loc3_.outputDisplay;
         _loc1_.sort(sortRewards);
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
      
      private function sortRewards(param1:InventoryItem, param2:InventoryItem) : int
      {
         var _loc4_:Boolean = param1.item is CoinDescription && (param1.item as CoinDescription).ident == "artifact_coin";
         var _loc6_:Boolean = param2.item is CoinDescription && (param2.item as CoinDescription).ident == "artifact_coin";
         var _loc7_:Boolean = param1.item is ConsumableDescription && (param1.item as ConsumableDescription).rewardType == "artifactEvolution";
         var _loc5_:Boolean = param2.item is ConsumableDescription && (param2.item as ConsumableDescription).rewardType == "artifactEvolution";
         var _loc3_:* = param1.item is ArtifactDescription;
         var _loc8_:* = param2.item is ArtifactDescription;
         if(_loc4_)
         {
            return -1;
         }
         if(_loc6_)
         {
            return 1;
         }
         if(_loc7_)
         {
            return -1;
         }
         if(_loc5_)
         {
            return 1;
         }
         if(_loc3_ && _loc8_)
         {
            return param2.amount - param1.amount;
         }
         if(_loc3_)
         {
            return -1;
         }
         if(_loc8_)
         {
            return 1;
         }
         return param2.item.color.id - param1.item.color.id;
      }
      
      public function get levelUpRewards() : Vector.<ArtifactChestLevelUpRewardVO>
      {
         return _levelUpRewards;
      }
      
      public function get openAmount() : uint
      {
         return _openAmount;
      }
      
      public function get free() : Boolean
      {
         return _free;
      }
      
      public function get artifactChest() : PlayerArtifactChest
      {
         return player.artifactChest;
      }
      
      public function get artifactChestLevel() : ArtifactChestLevel
      {
         return rule.getChestLelevById(artifactChest.level);
      }
      
      public function get artifactChestLevelExp() : uint
      {
         return artifactChestLevel.chestExp;
      }
      
      public function get artifactChestNextLevelExp() : uint
      {
         var _loc1_:ArtifactChestLevel = rule.getChestLelevById(artifactChest.level + 1);
         return _loc1_ != null?_loc1_.chestExp:artifactChestLevelExp;
      }
      
      public function get artifactChestPrevLevelExp() : uint
      {
         var _loc1_:ArtifactChestLevel = rule.getChestLelevById(artifactChest.level - 1);
         return _loc1_ != null?_loc1_.chestExp:artifactChestLevelExp;
      }
      
      public function get signal_reOpen() : Signal
      {
         return _signal_reOpen;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_consumable(DataStorage.consumable.getArtifactChestKeyDesc());
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactChestRewardPopup(this);
         return _popup;
      }
      
      public function action_reOpen() : void
      {
         var _loc1_:StashEventParams = Stash.click("get_more",_popup.stashParams);
         _signal_reOpen.dispatch(openAmount,free);
      }
      
      public function action_showLevelUpReward() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(levelUpRewards.length)
         {
            _loc1_ = levelUpRewards.pop();
            _loc2_ = new ArtifactChestLevelUpRewardPopupMediator(GameModel.instance.player,_loc1_.reward,_loc1_.level);
            _loc2_.signal_dispose.add(action_showLevelUpReward);
            _loc2_.open(_popup.stashParams);
         }
      }
      
      public function action_showX100Rewards() : void
      {
         var _loc1_:ArtifactChestx100RewardsPopupMediator = new ArtifactChestx100RewardsPopupMediator(GameModel.instance.player,reward.rewardList);
         _loc1_.open();
      }
      
      private function sortLevelUpRewards(param1:ArtifactChestLevelUpRewardVO, param2:ArtifactChestLevelUpRewardVO) : int
      {
         return param2.level - param1.level;
      }
      
      public function registerSpecialOffer(param1:ClipLayout) : void
      {
         var _loc2_:Halloween2k17SpecialOfferViewOwner = new Halloween2k17SpecialOfferViewOwner(param1,this,"artifactChest");
         player.specialOffer.hooks.registerHalloween2k17SpecialOffer(_loc2_);
      }
   }
}
