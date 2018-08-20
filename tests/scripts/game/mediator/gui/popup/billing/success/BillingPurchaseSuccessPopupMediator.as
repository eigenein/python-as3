package game.mediator.gui.popup.billing.success
{
   import game.command.social.SocialBillingBuyCommand;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.stat.VKPixel;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.success.BillingPurchaseSuccessPopup;
   import idv.cjcat.signals.Signal;
   
   public class BillingPurchaseSuccessPopupMediator extends PopupMediator
   {
       
      
      private var reward:RewardData;
      
      private var _cmd:SocialBillingBuyCommand;
      
      private var _signal_close:Signal;
      
      public function BillingPurchaseSuccessPopupMediator(param1:Player, param2:SocialBillingBuyCommand)
      {
         _signal_close = new Signal(BillingPurchaseSuccessPopupMediator);
         super(param1);
         this._cmd = param2;
         this.reward = param2.displayReward;
      }
      
      public function get cmd() : SocialBillingBuyCommand
      {
         return _cmd;
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      public function get progressbarValue() : int
      {
         return player.vipPoints;
      }
      
      public function get progressbarMaxValue() : int
      {
         return !!player.vipLevel.nextLevel?player.vipLevel.nextLevel.exp:int(progressbarMinValue);
      }
      
      public function get progressbarMinValue() : int
      {
         return player.vipLevel.exp;
      }
      
      public function get vipLevel() : int
      {
         return player.vipLevel.level;
      }
      
      public function get nextVipLevel() : int
      {
         return !!player.vipLevel.nextLevel?player.vipLevel.nextLevel.level:int(vipLevel);
      }
      
      public function get vipPoints() : int
      {
         return player.vipPoints;
      }
      
      public function get vipPointsReward() : int
      {
         return reward.vipPoints;
      }
      
      public function get gemReward() : int
      {
         return reward.starmoney;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BillingPurchaseSuccessPopup(this);
         return _popup;
      }
      
      override public function close() : void
      {
         super.close();
         _signal_close.dispatch(this);
      }
      
      override public function open(param1:PopupStashEventParams = null) : void
      {
         super.open(param1);
         try
         {
            VKPixel.send("bank_gems_purchase:" + _cmd.billing.desc.id);
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
   }
}
