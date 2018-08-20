package game.model.user.specialoffer
{
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.bundle.SubscriptionResourceBundleSpecialOfferPopupMediator;
   import game.model.user.Player;
   
   public class PlayerSpecialOfferSubscriptionBundle extends PlayerSpecialOfferBundle
   {
      
      public static const OFFER_TYPE:String = "subscriptionBundle";
       
      
      protected var _zeppelingSideBarIcon:SpecialOfferIconDescription;
      
      public function PlayerSpecialOfferSubscriptionBundle(param1:Player, param2:*)
      {
         super(param1,param2);
         autoPopupQueueEntry.priority = 5;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         if(clientData.sideBarIcon)
         {
            _zeppelingSideBarIcon = new SpecialOfferIconDescription(this,clientData.sideBarIcon);
            param1.zeppelingIcons.add(_zeppelingSideBarIcon);
            _zeppelingSideBarIcon.signal_click.add(handler_openPopup);
         }
      }
      
      override protected function createPopup() : PopupMediator
      {
         return new SubscriptionResourceBundleSpecialOfferPopupMediator(player,createResourceBundleDescription());
      }
   }
}
