package game.model.user.specialoffer
{
   import game.model.user.Player;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.paymentrepeat.SpecialOfferPaymentRepeatOnBillingViewNoTimer;
   
   public class PlayerSpecialOfferPaymentRepeatNoTimer extends PlayerSpecialOfferPaymentRepeat
   {
       
      
      public function PlayerSpecialOfferPaymentRepeatNoTimer(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override protected function overlayFactory() : GuiElementExternalStyle
      {
         var _loc2_:GuiElementExternalStyle = new GuiElementExternalStyle();
         var _loc1_:SpecialOfferPaymentRepeatOnBillingViewNoTimer = new SpecialOfferPaymentRepeatOnBillingViewNoTimer(this);
         _loc2_.signal_dispose.add(_loc1_.dispose);
         _loc2_.setOverlay(_loc1_.graphics,new RelativeAlignment());
         return _loc2_;
      }
   }
}
