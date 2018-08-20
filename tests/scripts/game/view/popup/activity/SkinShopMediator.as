package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.assets.battle.AssetClipLink;
   import game.command.social.BillingBuyCommandBase;
   import game.command.social.SocialBillingBuyCommand;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.mediator.gui.popup.billing.specialoffer.TripleSkinBundleValueObject;
   import game.model.GameModel;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferDailyReward;
   import game.model.user.specialoffer.PlayerSpecialOfferTripleSkinBundle;
   import game.stat.Stash;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import org.osflash.signals.Signal;
   
   public class SkinShopMediator
   {
       
      
      private var _offer:PlayerSpecialOfferTripleSkinBundle;
      
      private var _dailyRewardOffer:PlayerSpecialOfferDailyReward;
      
      private var _billingList:Vector.<TripleSkinBundleValueObject>;
      
      private var _signal_updateTime:Signal;
      
      private var _headerText:String;
      
      private var _signal_OfferRemoved:Signal;
      
      public function SkinShopMediator(param1:PlayerSpecialOfferTripleSkinBundle, param2:PlayerSpecialOfferDailyReward)
      {
         _signal_OfferRemoved = new Signal();
         super();
         _dailyRewardOffer = param2;
         _offer = param1;
         _offer.updateDataList();
         _offer.signal_removed.add(handler_offerRemoved);
         _billingList = offer.dataList;
         _signal_updateTime = offer.signal_updated;
         _headerText = Translate.translate(offer.titleLocale);
      }
      
      public function get offer() : PlayerSpecialOfferTripleSkinBundle
      {
         return _offer;
      }
      
      public function get dailyRewardOffer() : PlayerSpecialOfferDailyReward
      {
         return _dailyRewardOffer;
      }
      
      public function get billingList() : Vector.<TripleSkinBundleValueObject>
      {
         return _billingList;
      }
      
      public function get signal_updateTime() : Signal
      {
         return _signal_updateTime;
      }
      
      public function get timeLeftString() : String
      {
         return offer.timerStringDHorHMS;
      }
      
      public function get asset() : AssetClipLink
      {
         return offer.popupAsset;
      }
      
      public function get headerText() : String
      {
         return _headerText;
      }
      
      public function get signal_OfferRemoved() : Signal
      {
         return _signal_OfferRemoved;
      }
      
      public function action_no_hero_info(param1:TripleSkinBundleValueObject) : void
      {
         PopupList.instance.message(Translate.translate("UI_TRIPLE_SKI_BUNDLE_RENDERER_MSG_NO_HERO_TEXT"),Translate.translate("UI_TRIPLE_SKI_BUNDLE_RENDERER_MSG_NO_HERO_HEADER"));
      }
      
      public function action_buy(param1:TripleSkinBundleValueObject) : void
      {
         if(!param1.billingVO)
         {
            return;
         }
         var _loc3_:PopupStashEventParams = new PopupStashEventParams();
         _loc3_.windowName = "skin_shop";
         Stash.click("billing_buy:" + param1.billingVO.desc.id,_loc3_);
         var _loc2_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(param1.billingVO);
         _loc2_.signal_paymentBoxError.add(handler_paymentError);
         _loc2_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc2_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentSuccess(param1:SocialBillingBuyCommand) : void
      {
         var _loc3_:int = 0;
         var _loc5_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc5_.title = Translate.translate(param1.billing.name);
         _loc5_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc5_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         var _loc4_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         _loc5_.reward = _loc4_;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc5_);
         _loc2_.open();
         _loc3_ = 0;
         while(_loc3_ < offer.dataList.length)
         {
            offer.dataList[_loc3_].updatePlayerData(GameModel.instance.player);
            _loc3_++;
         }
      }
      
      private function handler_offerRemoved() : void
      {
         signal_OfferRemoved.dispatch();
      }
   }
}
