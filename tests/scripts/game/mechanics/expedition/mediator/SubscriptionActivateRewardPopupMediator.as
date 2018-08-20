package game.mechanics.expedition.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.subscription.SubscriptionLevelDescription;
   import game.mechanics.expedition.popup.SubscriptionActivateRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class SubscriptionActivateRewardPopupMediator extends PopupMediator
   {
       
      
      private var _activationReward:InventoryItem;
      
      private var _isRenew:Boolean;
      
      private var _dailyReward:InventoryItem;
      
      private var _title:String;
      
      public function SubscriptionActivateRewardPopupMediator(param1:Player)
      {
         var _loc3_:int = 0;
         super(param1);
         _title = Translate.translate("UI_ZEPPELIN_POPUP_TF_SUBSCRIPTION");
         var _loc4_:Vector.<SubscriptionLevelDescription> = param1.subscription.subscriptionInfo.current.levels;
         var _loc2_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_loc4_[_loc3_].level == level)
            {
               _activationReward = _loc4_[_loc3_].levelUpReward.outputDisplay[0];
               _dailyReward = _loc4_[_loc3_].dailyReward.outputDisplay[0];
               break;
            }
            _loc3_++;
         }
         _isRenew = level > 1;
      }
      
      public function get activationReward() : InventoryItem
      {
         return _activationReward;
      }
      
      public function get isRenew() : Boolean
      {
         return _isRenew;
      }
      
      public function get dailyReward() : InventoryItem
      {
         return _dailyReward;
      }
      
      public function get level() : int
      {
         return player.subscription.subscriptionInfo.currentLevel.value;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SubscriptionActivateRewardPopup(this);
         return _popup;
      }
   }
}
