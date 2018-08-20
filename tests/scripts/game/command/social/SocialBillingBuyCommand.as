package game.command.social
{
   import com.progrestar.common.social.datavalue.SocialPaymentBox;
   import engine.context.platform.PlatformFacade;
   import engine.context.platform.social.SocialPlatformFacade;
   import engine.context.platform.social.VkontakteSocialFacade;
   import game.command.realtime.SocketClientEvent;
   import game.command.rpc.billing.CommandBillingGetLast;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.subscription.SubscriptionDescription;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class SocialBillingBuyCommand extends BillingBuyCommandBase
   {
      
      private static const MESSAGE_CLIENT_TIMEOUT:int = 6;
      
      private static const PENDING_MESSAGE_CLIENT_TIMEOUT:int = 1;
      
      private static const BILLING_COMPLETE_PING_DELAY_START:int = 3;
      
      private static const BILLING_COMPLETE_PING_DELAY_INCREASE:int = 2;
       
      
      private var timeoutEvent:AlarmEvent;
      
      private var timeoutDelay:int = 3;
      
      private var billingResult:SocialBillingBuyResult;
      
      protected var userConfirmationAccepted:Boolean = false;
      
      protected var maxPendingTimeRequested:Number = 0;
      
      private var _isTransfer:Boolean;
      
      public function SocialBillingBuyCommand(param1:BillingPopupValueObject)
      {
         super();
         this._billing = param1;
      }
      
      public function get isTransfer() : Boolean
      {
         return _isTransfer;
      }
      
      override public function execute() : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:Boolean = GameModel.instance.player.subscription.subscriptionInfo.isAuto;
         var _loc1_:PlatformFacade = GameModel.instance.context.platformFacade;
         if(_loc2_ && _loc1_ is VkontakteSocialFacade && _billing.desc.subscriptionId)
         {
            _loc4_ = DataStorage.subscription.getSubscriptionById(_billing.desc.subscriptionId);
            (_loc1_ as VkontakteSocialFacade).showSubscriptionBox(onSocialPaymentSuccess,onPaymentRefuse,_loc4_.ident,"create",_loc4_.id);
         }
         else
         {
            _loc3_ = new SocialPaymentBox(billing.desc.cost,billing.dynamicStarmoneyName,"",billing.desc.id.toString());
            _loc3_.fb_productURL = billing.productURL;
            _loc3_.type = billing.desc.type;
            _loc3_.signal_onSuccess.add(onSocialPaymentSuccess);
            _loc3_.signal_onPendingRequested.add(onSocialPaymentPendingRequested);
            _loc3_.signal_onError.add(onPaymentRefuse);
            _loc3_.signal_onRefuse.add(onPaymentRefuse);
            (_loc1_ as SocialPlatformFacade).showPaymentBox(_loc3_);
         }
         GameModel.instance.actionManager.messageClient.subscribe("paymentSuccess",onPaymentMessage);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:RewardData = billingResult.getSummaryReward(param1.starmoney);
         _vipLevelPrev = param1.vipLevel;
         _displayReward = new RewardData();
         _displayReward.starmoney = _loc2_.starmoney;
         _displayReward.vipPoints = reward.vipPoints;
         param1.takeReward(_loc2_);
         if(_loc2_.subscriptions && _loc2_.subscriptions.length > 0)
         {
            GameModel.instance.actionManager.playerCommands.subscriptionGetInfo();
         }
         if(!isTransfer)
         {
         }
         _vipLevelObtained = param1.vipLevel;
         super.clientExecute(param1);
      }
      
      protected function completeBilling(param1:SocialBillingBuyResult) : void
      {
         if(timeoutEvent)
         {
            GameTimer.instance.removeAlarm(timeoutEvent);
            timeoutEvent = null;
         }
         if(!userConfirmationAccepted)
         {
            userConfirmationAccepted = true;
            signal_paymentBoxConfirm.dispatch(this);
         }
         this.billingResult = param1;
         _reward = param1.reward;
         if(billing.isTransfer)
         {
            _isTransfer = true;
         }
         starmoneySum = param1.newStarmoneyValue;
         onComplete.dispatch(this);
         onClientCommand.dispatch(this);
         GameModel.instance.actionManager.messageClient.unsubscribe("paymentSuccess",onPaymentMessage);
         GameModel.instance.player.billingData.buy(param1.transactionId);
         GameModel.instance.player.specialOffer.hooks.adjustBillingResult(param1);
         signal_paymentSuccess.dispatch(this);
      }
      
      private function onPaymentMessage(param1:SocketClientEvent) : void
      {
         trace("SocialBillingBuyCommand.onPaymentMessage");
         var _loc4_:Object = param1.data.body.billingReward;
         var _loc2_:int = param1.data.body.starmoney;
         var _loc5_:String = param1.data.body.transactionId;
         var _loc3_:Array = param1.data.body.specialOffers;
         completeBilling(new SocialBillingBuyResult(_loc4_,_loc2_,_loc5_,_loc3_));
      }
      
      private function onPaymentRefuse() : void
      {
         GameModel.instance.actionManager.messageClient.unsubscribe("paymentSuccess",onPaymentMessage);
         signal_paymentBoxError.dispatch(this);
      }
      
      private function scheduleRequest(param1:int) : void
      {
         if(!timeoutEvent)
         {
            timeoutEvent = new AlarmEvent(GameTimer.instance.currentServerTime + param1);
            timeoutEvent.callback = handler_messageClientTimeout;
         }
         else
         {
            timeoutEvent.time = GameTimer.instance.currentServerTime + param1;
         }
         GameTimer.instance.addAlarm(timeoutEvent);
      }
      
      private function pendingRequestTimeout() : Boolean
      {
         if(!billingResult && !userConfirmationAccepted && timeoutDelay > maxPendingTimeRequested)
         {
            userConfirmationAccepted = true;
            onPaymentRefuse();
            return true;
         }
         return false;
      }
      
      private function onSocialPaymentSuccess() : void
      {
         signal_paymentBoxConfirm.dispatch(this);
         userConfirmationAccepted = true;
         if(billingResult)
         {
            return;
         }
         scheduleRequest(6);
      }
      
      private function onSocialPaymentPendingRequested(param1:Number) : void
      {
         if(userConfirmationAccepted)
         {
            return;
         }
         if(billingResult)
         {
            signal_paymentBoxConfirm.dispatch(this);
            userConfirmationAccepted = true;
            return;
         }
         maxPendingTimeRequested = param1;
         scheduleRequest(1);
      }
      
      private function handler_messageClientTimeout() : void
      {
         var _loc1_:CommandBillingGetLast = GameModel.instance.actionManager.billingGetLast();
         _loc1_.onClientExecute(handler_billingGetLast);
         _loc1_.signal_error.add(handler_billingGetLastError);
      }
      
      private function handler_billingGetLast(param1:CommandBillingGetLast) : void
      {
         var _loc2_:Player = GameModel.instance.player;
         if(!(billingResult || pendingRequestTimeout()))
         {
            if(param1.emptyResult || _loc2_.billingData.hasTransaction(param1))
            {
               scheduleRequest(timeoutDelay);
               timeoutDelay = timeoutDelay + 2;
            }
            else
            {
               completeBilling(param1.createResultObject());
            }
         }
      }
      
      private function handler_billingGetLastError(param1:CommandBillingGetLast) : void
      {
         if(!pendingRequestTimeout())
         {
            scheduleRequest(timeoutDelay);
            timeoutDelay = timeoutDelay + 2;
         }
      }
   }
}
