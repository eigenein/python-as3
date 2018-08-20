package game.mechanics.expedition.mediator
{
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.social.VkontakteSocialFacade;
   import engine.core.utils.property.IntProperty;
   import game.command.social.BillingBuyCommandBase;
   import game.data.storage.DataStorage;
   import game.data.storage.subscription.SubscriptionDescription;
   import game.data.storage.subscription.SubscriptionLevelDescription;
   import game.mechanics.expedition.model.SubscriptionLevelValueObject;
   import game.mechanics.expedition.popup.SubscriptionPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.subscription.PlayerSubscriptionData;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   
   public class SubscriptionPopupMediator extends PopupMediator
   {
       
      
      private var billing:PlayerBillingDescription;
      
      private var _activationReward:InventoryItem;
      
      private var _levels:Vector.<SubscriptionLevelValueObject>;
      
      public function SubscriptionPopupMediator(param1:Player)
      {
         super(param1);
         _activationReward = levels[0].level.levelUpReward.outputDisplay[0];
         billing = param1.billingData.getBySubscriptionId(DataStorage.subscription.theSubscription.id);
         param1.subscription.signal_updated.add(handler_playerSubscriptionUpdate);
      }
      
      override protected function dispose() : void
      {
         player.subscription.signal_updated.remove(handler_playerSubscriptionUpdate);
         super.dispose();
      }
      
      public function get billingCost() : String
      {
         return !!billing?billing.costString:"?";
      }
      
      public function get activationReward() : InventoryItem
      {
         return _activationReward;
      }
      
      public function get currentSubscriptionLevel() : IntProperty
      {
         return player.subscription.subscriptionInfo.currentLevel;
      }
      
      public function get levels() : Vector.<SubscriptionLevelValueObject>
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Vector.<SubscriptionLevelDescription> = DataStorage.subscription.theSubscription.levels;
         _levels = new Vector.<SubscriptionLevelValueObject>();
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = new SubscriptionLevelValueObject(_loc2_[_loc3_]);
            _levels.push(_loc4_);
            _loc4_.currentLevel = player.subscription.subscriptionInfo.currentLevel.value;
            _loc4_.lastLevel = _loc1_;
            _loc3_++;
         }
         return _levels;
      }
      
      public function get state_lastChanceToRenew() : Boolean
      {
         return player.subscription.subscriptionInfo.isLastChanceToRenew;
      }
      
      public function get state_isActive() : Boolean
      {
         return player.subscription.subscriptionInfo.isActive;
      }
      
      public function get state_isAuto() : Boolean
      {
         return player.subscription.subscriptionInfo.isAuto;
      }
      
      public function get state_canProlong() : Boolean
      {
         return player.subscription.subscriptionInfo.isAvailableToProlong;
      }
      
      public function get time_nextProlong() : String
      {
         return getTimeLeft(player.subscription.subscriptionInfo.secondsLeftToRenew);
      }
      
      public function get time_durationLeft() : String
      {
         return getTimeLeft(player.subscription.subscriptionInfo.secondsLeft);
      }
      
      public function get time_renewLastChance() : String
      {
         return getTimeLeft(player.subscription.subscriptionInfo.secondsLeftToRenewRed);
      }
      
      public function get state_isPendingCancel() : Boolean
      {
         return player.subscription.subscriptionInfo.pendingCancel;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SubscriptionPopup(this);
         return _popup;
      }
      
      public function action_buy() : void
      {
         var _loc1_:BillingPopupValueObject = new BillingPopupValueObject(billing,player);
         var _loc2_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(_loc1_);
         _loc2_.signal_paymentBoxError.add(handler_paymentError);
         _loc2_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc2_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      public function action_resumeVK() : void
      {
         var _loc1_:PlatformFacade = GameModel.instance.context.platformFacade;
         var _loc2_:SubscriptionDescription = DataStorage.subscription.theSubscription;
         (_loc1_ as VkontakteSocialFacade).showSubscriptionBox(handler_vkSubscriptionResume,null,_loc2_.ident,"resume",player.subscription.subscriptionInfo.vkSubscriptionId);
      }
      
      private function getTimeLeft(param1:int) : String
      {
         var _loc2_:* = param1;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ > 86400)
         {
            return TimeFormatter.toDH(_loc2_,"{d} {h} {m}"," ",true);
         }
         return TimeFormatter.toMS2(_loc2_);
      }
      
      private function handler_vkSubscriptionResume() : void
      {
         player.subscription.action_markVKSubscriptionAsResumed();
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
         if(!disposed && player)
         {
            close();
         }
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
      }
      
      private function handler_playerSubscriptionUpdate(param1:PlayerSubscriptionData) : void
      {
      }
   }
}
