package game.model.user.specialoffer
{
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialofferDescription;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.billing.bundle.SubscriptionResourceBundleSpecialOfferPopup;
   import game.view.specialoffer.bundle.ResourceBundleBirthday2018SpecialOfferPopup;
   import game.view.specialoffer.bundle.ResourceBundleRedSpecialOfferPopup;
   
   public class PlayerSpecialOfferBundle extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "bundle";
       
      
      protected const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(4);
      
      public function PlayerSpecialOfferBundle(param1:Player, param2:*)
      {
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_openPopupDelayed);
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         if(_sideBarIcon)
         {
            _sideBarIcon.signal_click.add(handler_openPopup);
         }
         param1.addAutoPopup(autoPopupQueueEntry);
      }
      
      public function createResourceBundleDescription() : ResourceBundleSpecialofferDescription
      {
         var _loc3_:int = 0;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc7_:ResourceBundleSpecialofferDescription = new ResourceBundleSpecialofferDescription();
         _loc7_.rewardList = new Vector.<InventoryItem>();
         var _loc2_:Array = offerData.addBillingIds;
         var _loc5_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc8_ = player.billingData.getById(_loc2_[_loc3_]);
            if(_loc8_)
            {
               _loc1_ = new BillingPopupValueObject(_loc8_,player);
               if(_loc1_.rewardList)
               {
                  _loc9_ = _loc1_.rewardList.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc9_)
                  {
                     _loc7_.rewardList.push(_loc1_.rewardList[_loc4_]);
                     _loc4_++;
                  }
               }
               else
               {
                  _loc7_.rewardList = _loc7_.rewardList.concat(_loc1_.reward.outputDisplay);
               }
               break;
            }
            _loc3_++;
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
         return _loc7_;
      }
      
      protected function createPopup() : PopupMediator
      {
         var _loc2_:ResourceBundleSpecialofferDescription = createResourceBundleDescription();
         var _loc1_:String = clientData.popupStyle;
         var _loc3_:* = _loc1_;
         if("birthdayPurple4" !== _loc3_)
         {
            if("red4" !== _loc3_)
            {
               if("valkyrie4" === _loc3_)
               {
                  _loc2_.PopupClass = SubscriptionResourceBundleSpecialOfferPopup;
               }
            }
            else
            {
               _loc2_.PopupClass = ResourceBundleRedSpecialOfferPopup;
            }
         }
         else
         {
            _loc2_.PopupClass = ResourceBundleBirthday2018SpecialOfferPopup;
         }
         return new ResourceBundleSpecialOfferPopupMediator(player,_loc2_);
      }
      
      private function timeLeftMethod() : String
      {
         return timerString;
      }
      
      protected function handler_openPopupDelayed(param1:PopupStashEventParams) : void
      {
         createPopup().openDelayed(param1);
      }
      
      protected function handler_openPopup(param1:PopupStashEventParams) : void
      {
         createPopup().open(param1);
      }
   }
}
