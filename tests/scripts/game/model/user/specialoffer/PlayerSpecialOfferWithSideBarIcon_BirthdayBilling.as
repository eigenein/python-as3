package game.model.user.specialoffer
{
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialofferDescription;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class PlayerSpecialOfferWithSideBarIcon_BirthdayBilling extends PlayerSpecialOfferWithSideBarIcon
   {
      
      public static const OFFER_TYPE:String = "sideBarIcon_birthday2016_billing";
       
      
      public function PlayerSpecialOfferWithSideBarIcon_BirthdayBilling(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function action_popupOpen() : ResourceBundleSpecialOfferPopupMediator
      {
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:ResourceBundleSpecialofferDescription = new ResourceBundleSpecialofferDescription();
         _loc7_.rewardList = new Vector.<InventoryItem>();
         var _loc2_:Array = offerData.billingIds;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc8_ = player.billingData.getById(_loc2_[_loc4_]);
            if(_loc8_)
            {
               _loc1_ = new BillingPopupValueObject(_loc8_,player);
               if(_loc1_.rewardList)
               {
                  _loc9_ = _loc1_.rewardList.length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc9_)
                  {
                     _loc7_.rewardList.push(_loc1_.rewardList[_loc5_]);
                     _loc5_++;
                  }
               }
               else
               {
                  _loc7_.rewardList = _loc7_.rewardList.concat(_loc1_.reward.outputDisplay);
               }
               break;
            }
            _loc4_++;
         }
         if(clientData && clientData.locale)
         {
            _loc6_ = clientData.locale;
            _loc7_.buttonLabel = _loc1_.costString;
            _loc7_.title = _loc6_.title;
            _loc7_.description = _loc6_.description;
         }
         _loc7_.discountValue = 0;
         _loc7_.oldPrice = null;
         _loc7_.offerId = id;
         _loc7_.billing = _loc1_;
         _loc7_.signal_removed = signal_removed;
         _loc7_.signal_updateTimeLeft = signal_updated;
         _loc7_.timeLeftMethod = timeLeftMethod;
         _loc7_.stashWindowName = "specialOffer:" + id;
         return new ResourceBundleSpecialOfferPopupMediator(player,_loc7_);
      }
      
      private function timeLeftMethod() : String
      {
         return timerString;
      }
   }
}
