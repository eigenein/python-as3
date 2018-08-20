package game.view.specialoffer.welcomeback
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chest.ChestPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.specialoffer.PlayerSpecialOfferCostReplaceTownChestPack;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeatWithTimer;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class SpecialOfferWelcomeBackBonusesPopupMediator extends PopupMediator
   {
       
      
      private var offerRoot:PlayerSpecialOfferWithTimer;
      
      private var offerChest:PlayerSpecialOfferCostReplaceTownChestPack;
      
      private var offerBilling:PlayerSpecialOfferPaymentRepeatWithTimer;
      
      public function SpecialOfferWelcomeBackBonusesPopupMediator(param1:Player, param2:PlayerSpecialOfferWithTimer)
      {
         super(param1);
         offerRoot = param2;
         offerRoot.signal_removed.add(handler_remove);
         offerChest = param1.specialOffer.getSpecialOfferById(90) as PlayerSpecialOfferCostReplaceTownChestPack;
         offerBilling = param1.specialOffer.getSpecialOfferById(89) as PlayerSpecialOfferPaymentRepeatWithTimer;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         offerRoot.signal_removed.remove(handler_remove);
      }
      
      public function get isValid() : Boolean
      {
         return offerChest != null && offerBilling != null;
      }
      
      public function get isOver() : Boolean
      {
         return offerRoot.isOver;
      }
      
      public function get timeLeftString() : String
      {
         return offerRoot.timerStringDHorHMS;
      }
      
      public function get signal_timer() : Signal
      {
         return offerRoot.signal_updated;
      }
      
      public function get chestSale() : String
      {
         return offerChest.saleDiscountString;
      }
      
      public function get billingSale() : String
      {
         return offerBilling.saleValueString;
      }
      
      public function get billingIconTexture() : Texture
      {
         var _loc1_:PlayerBillingDescription = offerBilling.getMinSlotBilling();
         return AssetStorage.rsx.getTexture(_loc1_.imageTexture,_loc1_.imageAtlas);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferWelcomeBackBonusesPopup(this);
         return new SpecialOfferWelcomeBackBonusesPopup(this);
      }
      
      public function action_toBilling() : void
      {
         PopupList.instance.dialog_bank(!!_popup?_popup.stashParams:null);
         close();
      }
      
      public function action_toChest() : void
      {
         var _loc1_:ChestPopupMediator = new ChestPopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("chest",!!_popup?_popup.stashParams:null));
         close();
      }
      
      private function handler_remove() : void
      {
         close();
      }
   }
}
