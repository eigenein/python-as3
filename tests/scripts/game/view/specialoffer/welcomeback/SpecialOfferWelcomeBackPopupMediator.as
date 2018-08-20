package game.view.specialoffer.welcomeback
{
   import engine.core.utils.property.BooleanProperty;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferWelcomeBack;
   import game.view.popup.PopupBase;
   
   public class SpecialOfferWelcomeBackPopupMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferWelcomeBack;
      
      public function SpecialOfferWelcomeBackPopupMediator(param1:Player, param2:PlayerSpecialOfferWelcomeBack)
      {
         super(param1);
         this.offer = param2;
         param2.signal_removed.add(handler_removed);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         offer.signal_removed.remove(handler_removed);
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return !!offer.freeRewardObtained.value?offer.paymentReward:offer.freeReward;
      }
      
      public function get costString() : String
      {
         return offer.costString;
      }
      
      public function get title() : String
      {
         return offer.title;
      }
      
      public function get description() : String
      {
         return offer.description;
      }
      
      public function get button() : String
      {
         return offer.button;
      }
      
      public function get offerTitle() : String
      {
         return offer.offerTitle;
      }
      
      public function get offerDescription() : String
      {
         return offer.offerDescription;
      }
      
      public function get offerButton() : String
      {
         return offer.offerButton;
      }
      
      public function get freeRewardObtained() : BooleanProperty
      {
         return offer.freeRewardObtained;
      }
      
      public function get offerDescriptionLocaleKey() : String
      {
         return offer.offerDescriptionLocaleKey;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferWelcomeBackPopup(this);
         return new SpecialOfferWelcomeBackPopup(this);
      }
      
      public function action_buy() : void
      {
         if(offer.freeRewardObtained.value)
         {
            offer.action_buy();
         }
         else
         {
            offer.action_claimFree();
         }
      }
      
      private function handler_removed() : void
      {
         close();
      }
   }
}
