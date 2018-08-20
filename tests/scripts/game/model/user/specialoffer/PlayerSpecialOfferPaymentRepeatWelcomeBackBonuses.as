package game.model.user.specialoffer
{
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.specialoffer.welcomeback.SpecialOfferWelcomeBackBonusesPopupMediator;
   
   public class PlayerSpecialOfferPaymentRepeatWelcomeBackBonuses extends PlayerSpecialOfferPaymentRepeatWithTimer
   {
      
      public static const OFFER_TYPE:String = "paymentRepeatWelcomeBackBonuses";
       
      
      private const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(4);
      
      public function PlayerSpecialOfferPaymentRepeatWelcomeBackBonuses(param1:Player, param2:*)
      {
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_autoPopupOpen);
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.addAutoPopup(autoPopupQueueEntry);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
         autoPopupQueueEntry.dispose();
      }
      
      private function handler_autoPopupOpen(param1:PopupStashEventParams) : void
      {
         var _loc2_:PopupStashEventParams = Stash.click("specialOffer:" + id,param1);
         var _loc3_:SpecialOfferWelcomeBackBonusesPopupMediator = new SpecialOfferWelcomeBackBonusesPopupMediator(player,this);
         if(_loc3_.isValid)
         {
            _loc3_.openDelayed(_loc2_);
         }
      }
   }
}
