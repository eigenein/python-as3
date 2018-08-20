package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.rpc.ny.CommandNYGetInfo;
   import game.command.rpc.ny.CommandNYTreeDecorate;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.data.storage.rule.ny2018tree.NY2018TreeLevel;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.NYPopupMediatorBase;
   import game.view.popup.ny.giftinfo.NYGiftInfoPopupMediator;
   import game.view.popup.ny.reward.NYRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class NYTreeUpgradePopupMediator extends NYPopupMediatorBase
   {
       
      
      private var nyTreeCoinCounter:InventoryItemCountProxy;
      
      private var nyTreeLevel:uint;
      
      public var signal_treeExpChange:Signal;
      
      public var signal_treeLevelChange:Signal;
      
      public var signal_nyTreeCoinUpdate:Signal;
      
      public function NYTreeUpgradePopupMediator(param1:Player)
      {
         signal_treeExpChange = new Signal();
         signal_treeLevelChange = new Signal();
         signal_nyTreeCoinUpdate = new Signal();
         super(param1);
         param1.ny.signal_treeExpChange.add(handler_treeExpChange);
         nyTreeCoinCounter = param1.inventory.getItemCounterProxy(DataStorage.coin.getByIdent("ny_tree_coin"),false);
         nyTreeCoinCounter.signal_update.add(handler_nyTreeCoinUpdate);
         nyTreeLevel = param1.ny.treeLevel;
         GameModel.instance.actionManager.executeRPCCommand(new CommandNYGetInfo());
      }
      
      override protected function dispose() : void
      {
         player.ny.signal_treeExpChange.remove(handler_treeExpChange);
         nyTreeCoinCounter.signal_update.remove(handler_nyTreeCoinUpdate);
         super.dispose();
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_tree_coin"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_gift_coin"));
         return _loc1_;
      }
      
      public function get serverId() : int
      {
         return player.serverId;
      }
      
      public function get playerClanTitle() : String
      {
         return !!player.clan.clan?player.clan.clan.title:null;
      }
      
      public function get nyTreeDisplayedLevel() : int
      {
         return player.ny.treeLevel + 1;
      }
      
      public function get nyTreeAssetLevel() : int
      {
         return DataStorage.rule.ny2018TreeRule.getAssetLevelByLevel(player.ny.treeLevel);
      }
      
      public function get treeExpPercent() : Number
      {
         return player.ny.treeExpPercent;
      }
      
      public function get treeExpPercentText() : String
      {
         return Math.round(treeExpPercent * 100) / 100 + "%";
      }
      
      public function get decorateActions() : Vector.<NY2018TreeDecorateAction>
      {
         return DataStorage.rule.ny2018TreeRule.decorateActions;
      }
      
      public function get decorateMultiplierNYTreeCoin() : int
      {
         var _loc1_:NY2018TreeDecorateAction = decorateActions[0];
         var _loc2_:int = GameModel.instance.player.inventory.getItemCount(DataStorage.coin.getByIdent("ny_tree_coin"));
         if(_loc2_ >= 1000 * _loc1_.cost.outputDisplayFirst.amount)
         {
            return 1000;
         }
         if(_loc2_ >= 100 * _loc1_.cost.outputDisplayFirst.amount)
         {
            return Math.floor(_loc2_ / (100 * _loc1_.cost.outputDisplayFirst.amount)) * 100;
         }
         if(_loc2_ >= 5 * _loc1_.cost.outputDisplayFirst.amount)
         {
            return Math.floor(_loc2_ / (5 * _loc1_.cost.outputDisplayFirst.amount)) * 5;
         }
         return 1;
      }
      
      public function get currentGift() : NYGiftDescription
      {
         var _loc1_:NY2018TreeLevel = DataStorage.rule.ny2018TreeRule.getLevelById(player.ny.treeLevel + 1);
         if(_loc1_.giftIds.length)
         {
            return DataStorage.nyGifts.getNYGifyById(_loc1_.giftIds[0]);
         }
         return null;
      }
      
      public function get currentGiftAsset() : String
      {
         var _loc1_:NYGiftDescription = currentGift;
         return !!_loc1_?_loc1_.asset:null;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new NYTreeUpgradePopup(this);
         return _popup;
      }
      
      public function action_showNYGifts() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_GIFTS,Stash.click("gifts",_popup.stashParams));
      }
      
      public function canDecorateNYTree(param1:NY2018TreeDecorateAction, param2:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         if(param1 != null)
         {
            _loc3_ = new CostData();
            _loc3_.add(param1.cost);
            _loc3_.multiply(param2);
            _loc4_ = player.canSpend(_loc3_);
         }
         return _loc4_;
      }
      
      public function action_decorateNYTree(param1:NY2018TreeDecorateAction, param2:int) : CommandNYTreeDecorate
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = new CommandNYTreeDecorate(param1,param2,true);
            GameModel.instance.actionManager.executeRPCCommand(_loc3_);
            return _loc3_;
         }
         return null;
      }
      
      public function applyCommandTreeUpdate(param1:CommandNYTreeDecorate) : void
      {
         param1.applyTreeUpdate(player);
      }
      
      public function action_fireworks() : void
      {
         var _loc1_:NYFireworksLaunchPopupMediator = new NYFireworksLaunchPopupMediator(player);
         _loc1_.open(_popup.stashParams);
      }
      
      public function action_showNYGiftInfo(param1:NYGiftDescription) : void
      {
         new NYGiftInfoPopupMediator(player,param1).open(_popup.stashParams);
      }
      
      private function handler_treeExpChange() : void
      {
         if(player.ny.treeLevel != nyTreeLevel)
         {
            signal_treeLevelChange.dispatch();
         }
         signal_treeExpChange.dispatch();
      }
      
      private function handler_nyTreeCoinUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_nyTreeCoinUpdate.dispatch();
      }
      
      private function handler_treeDecorate(param1:CommandNYTreeDecorate) : void
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_REWARD_HEADER");
         PopUpManager.addPopUp(new NYRewardPopup(_loc2_,param1.reward.outputDisplay));
      }
   }
}
