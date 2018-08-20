package game.mediator.gui.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.inventory.CommandInventoryUseStamina;
   import game.command.rpc.refillable.CommandStaminaBuy;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.refillable.RefillPopupBase;
   import game.view.popup.refillable.StaminaRefillPopup;
   
   public class StaminaRefillPopupMediator extends RefillableRefillPopupMediatorBase
   {
       
      
      public var staminaItemDesc:ConsumableDescription;
      
      public var staminaItem:InventoryItem;
      
      public function StaminaRefillPopupMediator(param1:Player)
      {
         _notEnoughVipMessageText = Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_STAMINA");
         super(param1);
         refillable = param1.refillable.stamina;
         closeAfterRefill = false;
         var _loc2_:Vector.<ConsumableDescription> = DataStorage.consumable.getItemsByType("stamina");
         staminaItemDesc = _loc2_[0];
         staminaItem = param1.inventory.getItemCollection().getItem(staminaItemDesc);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_stamina(false);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandStaminaBuy = GameModel.instance.actionManager.refillableStaminaBuy();
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      public function action_use() : void
      {
         var _loc1_:* = null;
         if(staminaItemDesc && staminaItem && staminaItem.amount > 0)
         {
            _loc1_ = GameModel.instance.actionManager.inventory.inventoryUseStamina(staminaItemDesc,1);
            _loc1_.onClientExecute(handler_useStaminaItem);
         }
      }
      
      override protected function _createPopup() : RefillPopupBase
      {
         var _loc1_:StaminaRefillPopup = new StaminaRefillPopup(this);
         if(!Tutorial.flags.dailyQuestsDimmerTutorialCompleted)
         {
            _loc1_.stashParams.prevActionName = "dailyQuestsDimmerTutorialNotCompleted";
         }
         return _loc1_;
      }
      
      private function handler_useStaminaItem(param1:CommandInventoryUseStamina) : void
      {
         FloatingTextContainer.showInDisplayObjectCenter(_popup,0,20,Translate.translate("LIB_PSEUDO_STAMINA") + " +" + staminaItemDesc.rewardAmount,this);
         super.handler_commandComplete(param1);
      }
      
      override protected function handler_commandComplete(param1:RPCCommandBase) : void
      {
         FloatingTextContainer.showInDisplayObjectCenter(_popup,0,20,Translate.translate("LIB_PSEUDO_STAMINA") + " +" + (param1 as CommandStaminaBuy).staminaAmount,this);
         super.handler_commandComplete(param1);
      }
   }
}
