package game.mediator.gui.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.RPCCommandBase;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.stat.Stash;
   import game.view.popup.MessagePopup;
   import game.view.popup.PopupBase;
   import game.view.popup.refillable.NotEnoughVipPopup;
   import game.view.popup.refillable.RefillPopupBase;
   import idv.cjcat.signals.Signal;
   
   public class RefillableRefillPopupMediatorBase extends PopupMediator implements IRefillableNavigatorResult
   {
       
      
      protected var _notEnoughVipMessageText:String;
      
      protected var refillable:PlayerRefillableEntry;
      
      protected var _closeAfterRefill:Boolean = true;
      
      protected var _signal_refillCancel:Signal;
      
      protected var _signal_refillComplete:Signal;
      
      public function RefillableRefillPopupMediatorBase(param1:Player)
      {
         _signal_refillCancel = new Signal();
         _signal_refillComplete = new Signal();
         super(param1);
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
      
      public function get nextVipAdditionalAttempts() : int
      {
         return refillable.getVipLevelRefillCount(nextVipLevel) - refillable.refillCount;
      }
      
      public function get nextVipLevel() : int
      {
         return refillable.nextVipLevel;
      }
      
      public function get refillAmount() : int
      {
         return refillable.refillAmount;
      }
      
      public function get refillCost() : InventoryItem
      {
         return refillable.refillCost.outputDisplay[0];
      }
      
      public function get refillCount() : int
      {
         return Math.max(0,refillable.maxRefillCount - refillable.refillCount);
      }
      
      public function get maxRefillCount() : int
      {
         return refillable.maxRefillCount;
      }
      
      public function get refillPossibleToday() : Boolean
      {
         return refillable.canRefill || nextVipLevel != -1;
      }
      
      public function action_buy() : void
      {
      }
      
      public function action_increaseVIP() : void
      {
         var _loc1_:PopupStashEventParams = _popup.stashParams;
         close();
         var _loc2_:BillingPopupMediator = new BillingPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("action_increaseVIP",_loc1_));
      }
      
      override public function createPopup() : PopupBase
      {
         if(maxRefillCount == 0)
         {
            return new NotEnoughVipPopup(_notEnoughVipMessageText,nextVipLevel);
         }
         if(!refillable.canRefill && nextVipLevel == -1)
         {
            return new MessagePopup(Translate.translate("UI_POPUP_REFILL_IMPOSSIBLE"),"");
         }
         _popup = _createPopup();
         return _popup;
      }
      
      protected function stash_buyClickSend() : PopupStashEventParams
      {
         return Stash.click("pay:" + refillCost.amount,_popup.stashParams);
      }
      
      protected function _createPopup() : RefillPopupBase
      {
         if(maxRefillCount == 0)
         {
         }
         return null;
      }
      
      protected function handler_commandComplete(param1:RPCCommandBase) : void
      {
         if(_closeAfterRefill)
         {
            close();
            _signal_refillComplete.dispatch();
            _signal_refillComplete.clear();
            _signal_refillCancel.clear();
         }
         else
         {
            _signal_refillComplete.dispatch();
         }
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
   }
}
