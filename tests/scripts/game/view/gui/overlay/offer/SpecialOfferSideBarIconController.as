package game.view.gui.overlay.offer
{
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.bundle.ResourceBundleSpecialOfferPopupMediator;
   import game.model.GameModel;
   import game.model.user.specialoffer.PlayerSpecialOfferThreeBoxes;
   import game.model.user.specialoffer.PlayerSpecialOfferTripleSkinBundle;
   import game.model.user.specialoffer.PlayerSpecialOfferWithSideBarIcon;
   import game.model.user.specialoffer.PlayerSpecialOfferWithSideBarIcon_BirthdayBilling;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import game.view.popup.birthday.BirthDayPopUpMediator;
   import game.view.popup.threeboxes.ThreeBoxesFullScreenPopUpMediator;
   
   public class SpecialOfferSideBarIconController
   {
      
      private static var _this:SpecialOfferSideBarIconController;
       
      
      public function SpecialOfferSideBarIconController()
      {
         super();
      }
      
      public static function call(param1:SpecialOfferIconDescription, param2:PopupStashEventParams, param3:Boolean = false) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         if(!param1)
         {
            return;
         }
         if(!_this)
         {
            _this = new SpecialOfferSideBarIconController();
         }
         if(param1.methodName)
         {
            _loc5_ = _this[param1.methodName];
            _loc4_ = [param1.specialOffer];
            if(param1.methodArguments)
            {
               _loc4_ = _loc4_.concat(param1.methodArguments);
            }
            _loc7_ = _loc5_.apply(_this,_loc4_);
            _loc6_ = _loc7_ as PopupMediator;
            if(_loc6_)
            {
               if(param3)
               {
                  _loc6_.openDelayed();
               }
               else
               {
                  _loc6_.open();
               }
            }
         }
         else
         {
            param1.action_click(param2);
         }
      }
      
      private function openBirthDayPopUp(param1:PlayerSpecialOfferWithSideBarIcon, param2:Boolean = false) : BirthDayPopUpMediator
      {
         GameModel.instance.player.quizData.action_quizNavigateTo(null);
         return null;
      }
      
      private function openBillingPopup(param1:PlayerSpecialOfferWithSideBarIcon_BirthdayBilling, param2:int) : ResourceBundleSpecialOfferPopupMediator
      {
         return param1.action_popupOpen();
      }
      
      private function openTripleSkinBundlePopup(param1:PlayerSpecialOfferTripleSkinBundle) : PopupMediator
      {
         return param1.action_popupOpen();
      }
      
      private function openEasterPopup(param1:PlayerSpecialOfferThreeBoxes) : ThreeBoxesFullScreenPopUpMediator
      {
         return param1.action_popupOpen();
      }
   }
}
