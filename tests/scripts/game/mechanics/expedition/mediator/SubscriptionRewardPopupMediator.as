package game.mechanics.expedition.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.billing.CommandSubscriptionFarmGifts;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.expedition.model.SubscriptionRewardPopupValueObject;
   import game.mechanics.expedition.popup.SubscriptionRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class SubscriptionRewardPopupMediator extends PopupMediator
   {
       
      
      private var cmd:CommandSubscriptionFarmGifts;
      
      private var _rewards:Vector.<SubscriptionRewardPopupValueObject>;
      
      public function SubscriptionRewardPopupMediator(param1:Player, param2:CommandSubscriptionFarmGifts)
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         super(param1);
         this.cmd = param2;
         _rewards = new Vector.<SubscriptionRewardPopupValueObject>();
         if(param2.zeppelinReward)
         {
            _loc3_ = param2.zeppelinReward.outputDisplayFirst;
            _loc4_ = new SubscriptionRewardPopupValueObject(_loc3_,Translate.translate("UI_POPUP_SUBSCRIPTION_REWARD_1_TF_DESC_KEY"));
            _rewards.push(_loc4_);
         }
         if(param2.subscriptionReward)
         {
            _loc3_ = param2.subscriptionReward.outputDisplayFirst;
            _loc4_ = new SubscriptionRewardPopupValueObject(_loc3_,Translate.translate("UI_POPUP_SUBSCRIPTION_REWARD_1_TF_DESC_COINS"));
            _rewards.push(_loc4_);
         }
      }
      
      public function get rewards() : Vector.<SubscriptionRewardPopupValueObject>
      {
         return _rewards;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SubscriptionRewardPopup(this);
         return _popup;
      }
      
      public function action_close() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.SUBSCRIPTION,Stash.click("subscription",_popup.stashParams));
         close();
      }
   }
}
