package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.billing.BillingBenefitValueObject;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.BillingPopupValueObjectWithBonus;
   import game.model.user.Player;
   import game.util.TimeFormatter;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.paymentrepeat.SpecialOfferPaymentRepeatOnBillingViewWithTimer;
   
   public class PlayerSpecialOfferPaymentRepeatWithTimer extends PlayerSpecialOfferPaymentRepeat
   {
       
      
      public function PlayerSpecialOfferPaymentRepeatWithTimer(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override public function get timerString() : String
      {
         if(someDaysLeft)
         {
            return daysLeftString;
         }
         return hmsLeftString;
      }
      
      override protected function overlayFactory() : GuiElementExternalStyle
      {
         var _loc2_:GuiElementExternalStyle = new GuiElementExternalStyle();
         var _loc1_:SpecialOfferPaymentRepeatOnBillingViewWithTimer = new SpecialOfferPaymentRepeatOnBillingViewWithTimer(this);
         _loc2_.signal_dispose.add(_loc1_.dispose);
         _loc2_.setOverlay(_loc1_.graphics,new RelativeAlignment());
         return _loc2_;
      }
      
      override protected function handler_billingBenefits(param1:BillingPopupValueObject, param2:Vector.<BillingBenefitValueObject>) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(hasBillingId(param1.desc.id) && param1 is BillingPopupValueObjectWithBonus)
         {
            _loc3_ = param1 as BillingPopupValueObjectWithBonus;
            _loc5_ = Translate.translate("UI_SPECIALOFFER_SPECIAL_OFFER") + "\n";
            if(moreThanOneDayLeft)
            {
               _loc5_ = _loc5_ + ("(" + daysLeftString + ")");
            }
            else
            {
               _loc5_ = _loc5_ + ("(" + Translate.translate("UI_SPECIALOFFER_ACTIVE_TILL") + " " + TimeFormatter.dateToMS(new Date(1000 * _endTime)) + ")");
            }
            _loc6_ = param2.length;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               if(!param2[_loc4_].showGemIcon || _loc4_ == _loc6_ - 1)
               {
                  param2.splice(_loc4_,0,new BillingBenefitValueObject(true,"+" + _loc3_.bonus,_loc5_));
                  break;
               }
               _loc4_++;
            }
         }
      }
   }
}
