package game.command.social
{
   import game.data.reward.RewardData;
   import game.data.storage.level.VIPLevel;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import idv.cjcat.signals.Signal;
   
   public class BillingBuyCommandBase extends PlatformCommand
   {
       
      
      public const signal_paymentBoxError:Signal = new Signal(BillingBuyCommandBase);
      
      public const signal_paymentBoxConfirm:Signal = new Signal(BillingBuyCommandBase);
      
      public const signal_paymentSuccess:Signal = new Signal(BillingBuyCommandBase);
      
      protected var starmoneySum:int;
      
      protected var _billing:BillingPopupValueObject;
      
      protected var _reward:RewardData;
      
      protected var _displayReward:RewardData;
      
      protected var _vipLevelPrev:VIPLevel;
      
      protected var _vipLevelObtained:VIPLevel;
      
      public function BillingBuyCommandBase()
      {
         super();
      }
      
      public function get billing() : BillingPopupValueObject
      {
         return _billing;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get displayReward() : RewardData
      {
         return _displayReward;
      }
      
      public function get vipLevelPrev() : VIPLevel
      {
         return _vipLevelPrev;
      }
      
      public function get vipLevelObtained() : VIPLevel
      {
         return _vipLevelObtained;
      }
   }
}
