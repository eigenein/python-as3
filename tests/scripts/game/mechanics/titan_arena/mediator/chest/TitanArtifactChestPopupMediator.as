package game.mechanics.titan_arena.mediator.chest
{
   import game.command.rpc.artifact.CommandTitanArtifactChestOpen;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.rule.TitanArtifactChestRule;
   import game.mechanics.titan_arena.popup.chest.TitanArtifactChestPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class TitanArtifactChestPopupMediator extends PopupMediator
   {
       
      
      private var rule:TitanArtifactChestRule;
      
      private var sphereCounterProxy:InventoryItemCountProxy;
      
      private var titanAllArtifacts:Vector.<TitanArtifactDescription>;
      
      private var lastRewardPopup:TitanArtifactChestRewardPopupMediator;
      
      private var _signal_artifactChestSphereUpdate:Signal;
      
      private var _signal_starmoneySpent:Signal;
      
      public function TitanArtifactChestPopupMediator(param1:Player)
      {
         _signal_artifactChestSphereUpdate = new Signal();
         _signal_starmoneySpent = new Signal();
         super(param1);
         rule = DataStorage.rule.titanArtifactChestRule;
         titanAllArtifacts = DataStorage.titanArtifact.getAllArtifacts();
         param1.titanArtifactChest.signal_starmoneySpent.add(handler_artifactChestStarmoneySpent);
         sphereCounterProxy = param1.inventory.getItemCounterProxy(DataStorage.consumable.getTitanArtifactChestKeyDesc(),false);
         sphereCounterProxy.signal_update.add(handler_artifactChestSphereUpdate);
      }
      
      override protected function dispose() : void
      {
         player.titanArtifactChest.signal_starmoneySpent.add(handler_artifactChestStarmoneySpent);
         sphereCounterProxy.signal_update.remove(handler_artifactChestSphereUpdate);
         sphereCounterProxy = null;
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
      
      public function get openCostX10Free() : CostData
      {
         return rule.openCostX10Free;
      }
      
      public function get openCostX100() : CostData
      {
         return rule.openCostX100;
      }
      
      public function get signal_artifactChestSphereUpdate() : Signal
      {
         return _signal_artifactChestSphereUpdate;
      }
      
      public function get signal_starmoneySpent() : Signal
      {
         return _signal_starmoneySpent;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_consumable(DataStorage.consumable.getTitanArtifactChestKeyDesc());
         return _loc1_;
      }
      
      public function get artifactChestKeysAmount() : uint
      {
         return !!sphereCounterProxy?sphereCounterProxy.amount:0;
      }
      
      public function get titanArtifactList() : Vector.<TitanArtifactDescription>
      {
         var _loc1_:Vector.<TitanArtifactDescription> = titanAllArtifacts.filter(filter_artifacts);
         _loc1_.sort(sort_artifacts);
         return _loc1_;
      }
      
      public function get titanSpiritArtifactList() : Vector.<TitanArtifactDescription>
      {
         return titanAllArtifacts.filter(filter_spiritArtifacts);
      }
      
      public function get x100Avaliable() : Boolean
      {
         return player.titanArtifactChest.starmoneySpent >= rule.openCostX100.starmoney;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArtifactChestPopup(this);
         return _popup;
      }
      
      public function action_open(param1:uint, param2:Boolean) : void
      {
         var _loc3_:CommandTitanArtifactChestOpen = GameModel.instance.actionManager.titan.artifactChestOpen(player,param1,param2);
         if(lastRewardPopup != null && !player.canSpend(_loc3_.cost))
         {
            lastRewardPopup.close();
         }
         _loc3_.signal_complete.add(handler_artifactChestOpen);
      }
      
      private function filter_artifacts(param1:TitanArtifactDescription, param2:int, param3:Vector.<TitanArtifactDescription>) : Boolean
      {
         return param1.artifactTypeData.type != "spirit";
      }
      
      private function filter_spiritArtifacts(param1:TitanArtifactDescription, param2:int, param3:Vector.<TitanArtifactDescription>) : Boolean
      {
         return param1.artifactTypeData.type == "spirit";
      }
      
      private function sort_artifacts(param1:TitanArtifactDescription, param2:TitanArtifactDescription) : int
      {
         return param1.id - param2.id;
      }
      
      private function handler_artifactChestOpen(param1:CommandTitanArtifactChestOpen) : void
      {
         cmd = param1;
         cmd.signal_complete.remove(handler_artifactChestOpen);
         var m:TitanArtifactChestRewardPopupMediator = new TitanArtifactChestRewardPopupMediator(GameModel.instance.player,cmd.rewardList,cmd.amount,cmd.free);
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
      
      private function handler_artifactChestSphereUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_artifactChestSphereUpdate.dispatch();
      }
      
      private function handler_artifactChestStarmoneySpent() : void
      {
         signal_starmoneySpent.dispatch();
      }
   }
}
