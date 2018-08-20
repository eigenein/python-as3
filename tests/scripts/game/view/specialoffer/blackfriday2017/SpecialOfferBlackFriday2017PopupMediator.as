package game.view.specialoffer.blackfriday2017
{
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chest.ChestPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.specialoffer.PlayerSpecialOfferCostReplaceAllChests;
   import game.model.user.specialoffer.PlayerSpecialOfferPaymentRepeatWithTimer;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class SpecialOfferBlackFriday2017PopupMediator extends PopupMediator
   {
       
      
      private var offerRoot:PlayerSpecialOfferWithTimer;
      
      private var offerChest:PlayerSpecialOfferCostReplaceAllChests;
      
      private var offerBilling:PlayerSpecialOfferPaymentRepeatWithTimer;
      
      public function SpecialOfferBlackFriday2017PopupMediator(param1:Player, param2:PlayerSpecialOfferWithTimer, param3:int, param4:int)
      {
         super(param1);
         offerRoot = param2;
         offerChest = param1.specialOffer.getSpecialOfferById(param3) as PlayerSpecialOfferCostReplaceAllChests;
         offerBilling = param1.specialOffer.getSpecialOfferById(param4) as PlayerSpecialOfferPaymentRepeatWithTimer;
         offerRoot.signal_removed.add(handler_remove);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         offerRoot.signal_removed.remove(handler_remove);
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
      
      public function get localeTitleKey() : String
      {
         return offerChest.localeTitleKey;
      }
      
      public function get localeDescKey() : String
      {
         return offerChest.localeDescKey;
      }
      
      public function get chestSale() : String
      {
         return offerChest.saleDiscountString;
      }
      
      public function get summoningCircleSale() : String
      {
         return offerChest.summoningCircleDiscountString;
      }
      
      public function get artifactChestSale() : String
      {
         return offerChest.artifactChestDiscountString;
      }
      
      public function get hasBillingSpecialOffer() : Boolean
      {
         return offerBilling;
      }
      
      public function get billingSale() : String
      {
         return !!offerBilling?offerBilling.saleValueString:offerChest.defaultBillingSale;
      }
      
      public function get billingIconTexture() : Texture
      {
         var _loc2_:int = 0;
         _loc2_ = 6;
         var _loc3_:int = 6;
         if(offerBilling)
         {
            _loc3_ = Math.min(_loc3_,offerBilling.getMinSlotBilling().slot);
         }
         var _loc1_:PlayerBillingDescription = player.billingData.getBillingBySlot(_loc3_);
         return AssetStorage.rsx.getTexture(_loc1_.imageTexture,_loc1_.imageAtlas);
      }
      
      public function get asset() : RsxGameAsset
      {
         return AssetStorage.rsx.getByName(offerChest.assetIdent);
      }
      
      public function get popupClip() : AssetClipLink
      {
         return offerChest.popupClip;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialOfferBlackFriday2017Popup(this);
         return new SpecialOfferBlackFriday2017Popup(this);
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
      
      public function action_toSummoningCircle() : void
      {
         Game.instance.navigator.navigateToSummoningCircle(Stash.click("summoningCircle",!!_popup?_popup.stashParams:null));
         close();
      }
      
      public function action_toArtifactChest() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT_CHEST,Stash.click("artefactChest",!!_popup?_popup.stashParams:null));
         close();
      }
      
      private function handler_remove() : void
      {
         close();
      }
   }
}
