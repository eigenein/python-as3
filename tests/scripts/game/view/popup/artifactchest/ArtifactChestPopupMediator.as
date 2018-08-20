package game.view.popup.artifactchest
{
   import game.command.rpc.artifact.CommandArtifactChestOpen;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactChestDropItem;
   import game.data.storage.artifact.ArtifactChestLevel;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.rule.ArtifactChestRule;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.artifactchest.PlayerArtifactChest;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.view.popup.PopupBase;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class ArtifactChestPopupMediator extends PopupMediator
   {
       
      
      private var artifactIds:Vector.<int>;
      
      private var keysCounterProxy:InventoryItemCountProxy;
      
      private var lastRewardPopup:ArtifactChestRewardPopupMediator;
      
      private var _rule:ArtifactChestRule;
      
      private var _signal_chestExperienceChange:Signal;
      
      private var _signal_starmoneySpent:Signal;
      
      private var _signal_artifactChestKeysUpdate:Signal;
      
      public function ArtifactChestPopupMediator(param1:Player, param2:ArtifactChestRule)
      {
         _signal_chestExperienceChange = new Signal();
         _signal_starmoneySpent = new Signal();
         _signal_artifactChestKeysUpdate = new Signal();
         super(param1);
         artifactIds = DataStorage.artifact.getAllArtifactIds();
         _rule = param2;
         param1.artifactChest.signal_experienceChange.add(handler_artifactChestExperienceChange);
         param1.artifactChest.signal_starmoneySpent.add(handler_artifactChestStarmoneySpent);
         keysCounterProxy = param1.inventory.getItemCounterProxy(DataStorage.consumable.getArtifactChestKeyDesc(),false);
         keysCounterProxy.signal_update.add(handler_artifactChestKeysUpdate);
      }
      
      override protected function dispose() : void
      {
         player.artifactChest.signal_experienceChange.remove(handler_artifactChestExperienceChange);
         player.artifactChest.signal_starmoneySpent.remove(handler_artifactChestStarmoneySpent);
         keysCounterProxy.signal_update.remove(handler_artifactChestKeysUpdate);
         keysCounterProxy = null;
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
      
      public function get dropItems() : Vector.<ArtifactChestDropItem>
      {
         return _rule.dropItems;
      }
      
      public function get artifactChest() : PlayerArtifactChest
      {
         return player.artifactChest;
      }
      
      public function get artifactChestLevel() : ArtifactChestLevel
      {
         return _rule.getChestLelevById(artifactChest.level);
      }
      
      public function get artifactChestLevelExp() : uint
      {
         return artifactChestLevel.chestExp;
      }
      
      public function get artifactChestNextLevelExp() : uint
      {
         var _loc1_:ArtifactChestLevel = _rule.getChestLelevById(artifactChest.level + 1);
         return _loc1_ != null?_loc1_.chestExp:artifactChestLevelExp;
      }
      
      public function get x100Avaliable() : Boolean
      {
         return player.artifactChest.starmoneySpent >= _rule.openCostX100.starmoney;
      }
      
      public function get signal_chestExperienceChange() : Signal
      {
         return _signal_chestExperienceChange;
      }
      
      public function get signal_starmoneySpent() : Signal
      {
         return _signal_starmoneySpent;
      }
      
      public function get signal_artifactChestKeysUpdate() : Signal
      {
         return _signal_artifactChestKeysUpdate;
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
         _popup = new ArtifactChestPopup(this);
         return _popup;
      }
      
      public function get artifactChestKeysAmount() : uint
      {
         return !!keysCounterProxy?keysCounterProxy.amount:0;
      }
      
      public function getRandomArtifactDescription() : ArtifactDescription
      {
         var _loc1_:uint = Math.round(Math.random() * (artifactIds.length - 1));
         return DataStorage.artifact.getById(artifactIds[_loc1_]) as ArtifactDescription;
      }
      
      public function action_open(param1:uint, param2:Boolean) : void
      {
         var _loc3_:CommandArtifactChestOpen = GameModel.instance.actionManager.hero.artifactChestOpen(player,param1,param2);
         if(lastRewardPopup != null && !player.canSpend(_loc3_.cost))
         {
            lastRewardPopup.close();
         }
         _loc3_.signal_complete.add(handler_artifactChestOpen);
      }
      
      private function handler_artifactChestOpen(param1:CommandArtifactChestOpen) : void
      {
         cmd = param1;
         cmd.signal_complete.remove(handler_artifactChestOpen);
         var reward:RewardValueObjectList = new RewardValueObjectList(cmd.rewardList);
         var m:ArtifactChestRewardPopupMediator = new ArtifactChestRewardPopupMediator(GameModel.instance.player,reward,cmd.amount,cmd.free,cmd.levelUpRewards);
         if(lastRewardPopup)
         {
            lastRewardPopup.close();
            lastRewardPopup = null;
            m.setReOpen();
         }
         m.signal_reOpen.add(function(param1:uint, param2:Boolean):*
         {
            lastRewardPopup = m;
            handler_reOpen(param1,param2);
         });
         m.open(_popup.stashParams);
      }
      
      private function handler_reOpen(param1:uint, param2:Boolean) : void
      {
         action_open(param1,param2);
      }
      
      private function handler_artifactChestExperienceChange() : void
      {
         signal_chestExperienceChange.dispatch();
      }
      
      private function handler_artifactChestStarmoneySpent() : void
      {
         signal_starmoneySpent.dispatch();
      }
      
      private function handler_artifactChestKeysUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_artifactChestKeysUpdate.dispatch();
      }
   }
}
