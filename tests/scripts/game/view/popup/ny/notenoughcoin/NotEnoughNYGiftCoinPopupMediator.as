package game.view.popup.ny.notenoughcoin
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.rpc.ny.CommandNYTreeDecorate;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.NYPopupMediatorBase;
   import game.view.popup.ny.reward.NYRewardPopup;
   import game.view.popup.ny.treeupgrade.NYFireworksLaunchPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class NotEnoughNYGiftCoinPopupMediator extends NYPopupMediatorBase
   {
       
      
      private var nyTreeCoinCounter:InventoryItemCountProxy;
      
      public var signal_nyTreeCoinUpdate:Signal;
      
      public function NotEnoughNYGiftCoinPopupMediator(param1:Player)
      {
         signal_nyTreeCoinUpdate = new Signal();
         super(param1);
         nyTreeCoinCounter = param1.inventory.getItemCounterProxy(DataStorage.coin.getByIdent("ny_tree_coin"),false);
         nyTreeCoinCounter.signal_update.add(handler_nyTreeCoinUpdate);
      }
      
      override protected function dispose() : void
      {
         nyTreeCoinCounter.signal_update.remove(handler_nyTreeCoinUpdate);
         super.dispose();
      }
      
      public function get nyGiftCoin() : CoinDescription
      {
         return DataStorage.coin.getByIdent("ny_gift_coin");
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
      
      override public function createPopup() : PopupBase
      {
         _popup = new NotEnoughNYGiftCoinPopup(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_tree_coin"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("ny_gift_coin"));
         return _loc1_;
      }
      
      public function action_decorateNYTree(param1:NY2018TreeDecorateAction, param2:int) : void
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = new CommandNYTreeDecorate(param1,param2);
            GameModel.instance.actionManager.executeRPCCommand(_loc3_);
            _loc3_.onClientExecute(handler_treeDecorate);
         }
      }
      
      public function action_fireworks() : void
      {
         var _loc1_:NYFireworksLaunchPopupMediator = new NYFireworksLaunchPopupMediator(player);
         _loc1_.open(_popup.stashParams);
      }
      
      private function handler_treeDecorate(param1:CommandNYTreeDecorate) : void
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_REWARD_HEADER");
         PopUpManager.addPopUp(new NYRewardPopup(_loc2_,param1.reward.outputDisplay));
      }
      
      private function handler_nyTreeCoinUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_nyTreeCoinUpdate.dispatch();
      }
   }
}
