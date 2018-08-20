package game.mechanics.expedition.mediator
{
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.expedition.popup.ExpeditionBriefingPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.subscription.PlayerSubscriptionData;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class ExpeditionBriefingPopupMediator extends PopupMediator
   {
       
      
      private var _signal_unlockConditions:Signal;
      
      private var _expedition:ExpeditionValueObject;
      
      public function ExpeditionBriefingPopupMediator(param1:Player, param2:ExpeditionValueObject)
      {
         _signal_unlockConditions = new Signal();
         super(param1);
         this._expedition = param2;
         param1.signal_update.vip_level.add(handler_updateVipLevel);
         param1.subscription.signal_updated.add(handler_updateSubscription);
      }
      
      override protected function dispose() : void
      {
         player.signal_update.vip_level.remove(handler_updateVipLevel);
         player.subscription.signal_updated.remove(handler_updateSubscription);
         super.dispose();
      }
      
      public function get signal_unlockConditions() : Signal
      {
         return _signal_unlockConditions;
      }
      
      public function get expedition() : ExpeditionValueObject
      {
         return _expedition;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ExpeditionBriefingPopup(this);
         return _popup;
      }
      
      public function action_navigateToExpeditionUnlock() : void
      {
         if(_expedition.isLockedBySubscription)
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.SUBSCRIPTION,Stash.click("subscription",_popup.stashParams));
         }
         else if(_expedition.isLockedByVipLevel)
         {
            PopupList.instance.dialog_bank(Stash.click("bank",_popup.stashParams));
         }
      }
      
      private function handler_updateVipLevel() : void
      {
         _signal_unlockConditions.dispatch();
      }
      
      private function handler_updateSubscription(param1:PlayerSubscriptionData) : void
      {
         _signal_unlockConditions.dispatch();
      }
   }
}
