package game.view.popup.billing
{
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import starling.animation.DelayedCall;
   import starling.core.Starling;
   
   public class BillingPopupHoverController
   {
      
      private static const DELAY_SHOW_INFO_SECONDS:Number = 0.3;
      
      private static const DELAY_HIDE_INFO_SECONDS:Number = 0.3;
       
      
      public const BILLING_NOT_SELECTED:BillingPopupValueObject = new BillingPopupValueObject(null,null);
      
      private var _showInfo:BooleanPropertyWriteable;
      
      private var _hoveredBilling:BillingPopupValueObject;
      
      private var _hoveredBillingProperty:ObjectPropertyWriteable;
      
      private var showInfoDelayedCall:DelayedCall;
      
      private var hideInfoDelayedCall:DelayedCall;
      
      public function BillingPopupHoverController()
      {
         _showInfo = new BooleanPropertyWriteable(false);
         _hoveredBillingProperty = new ObjectPropertyWriteable(BillingPopupValueObject,BILLING_NOT_SELECTED);
         super();
      }
      
      public function get hoveredBilling() : ObjectProperty
      {
         return _hoveredBillingProperty;
      }
      
      public function handler_billingHover(param1:BillingPopupValueObject) : void
      {
         if(_hoveredBillingProperty.value == BILLING_NOT_SELECTED && param1 != null)
         {
            _hoveredBilling = param1;
            startShowHoverInfoTimer();
            stopHoverOutTimer();
         }
         else if(param1 != null)
         {
            _hoveredBilling = param1;
            _hoveredBillingProperty.value = param1;
            stopHoverOutTimer();
         }
         else
         {
            _hoveredBilling = BILLING_NOT_SELECTED;
         }
      }
      
      public function handler_billingOut(param1:BillingPopupValueObject) : void
      {
         if(_hoveredBilling == param1)
         {
            stopShowHoverInfoTimer();
            startHoverOutTimer();
         }
      }
      
      protected function showHoverInfo() : void
      {
         showInfoDelayedCall = null;
         _showInfo.value = true;
         if(_hoveredBilling)
         {
            _hoveredBillingProperty.value = _hoveredBilling;
         }
         else
         {
            _hoveredBillingProperty.value = BILLING_NOT_SELECTED;
         }
      }
      
      protected function hideHoverInfo() : void
      {
         hideInfoDelayedCall = null;
         _showInfo.value = false;
         _hoveredBilling = BILLING_NOT_SELECTED;
         _hoveredBillingProperty.value = BILLING_NOT_SELECTED;
      }
      
      private function startShowHoverInfoTimer() : void
      {
         if(!showInfoDelayedCall)
         {
            showInfoDelayedCall = Starling.juggler.delayCall(showHoverInfo,0.3) as DelayedCall;
         }
      }
      
      private function stopShowHoverInfoTimer() : void
      {
         if(showInfoDelayedCall)
         {
            Starling.juggler.remove(showInfoDelayedCall);
            showInfoDelayedCall = null;
         }
      }
      
      private function startHoverOutTimer() : void
      {
         if(!hideInfoDelayedCall)
         {
            hideInfoDelayedCall = Starling.juggler.delayCall(hideHoverInfo,0.3) as DelayedCall;
         }
      }
      
      private function stopHoverOutTimer() : void
      {
         if(hideInfoDelayedCall)
         {
            Starling.juggler.remove(hideInfoDelayedCall);
            hideInfoDelayedCall = null;
         }
      }
   }
}
