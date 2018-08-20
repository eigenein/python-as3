package game.mediator.gui.popup.billing.bundle
{
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.SubscriptionResourceBundleSpecialOfferPopup;
   
   public class SubscriptionResourceBundleSpecialOfferPopupMediator extends ResourceBundleSpecialOfferPopupMediator
   {
       
      
      public function SubscriptionResourceBundleSpecialOfferPopupMediator(param1:Player, param2:ResourceBundleSpecialofferDescription)
      {
         super(param1,param2);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SubscriptionResourceBundleSpecialOfferPopup(this);
         return _popup;
      }
   }
}
