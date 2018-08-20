package game.view.specialoffer.multibundle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.command.social.BillingBuyCommandBase;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.mediator.gui.popup.billing.specialoffer.MultiBundleOfferValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferMultiBundle;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import org.osflash.signals.Signal;
   
   public class CyberMondayTripleSkinCoinPopupMediator extends PopupMediator
   {
       
      
      private var offer:PlayerSpecialOfferMultiBundle;
      
      private var _bundleList:Vector.<MultiBundleOfferValueObject>;
      
      private var currentTransactionVo:MultiBundleOfferValueObject;
      
      private var _headerText:String;
      
      public function CyberMondayTripleSkinCoinPopupMediator(param1:Player, param2:PlayerSpecialOfferMultiBundle)
      {
         super(param1);
         if(param2)
         {
            this.offer = param2;
            param2.signal_removed.add(close);
            _bundleList = param2.bundles;
            _headerText = Translate.translate(param2.titleLocale);
         }
         else
         {
            _bundleList = new Vector.<MultiBundleOfferValueObject>();
         }
      }
      
      public function get billingList() : Vector.<MultiBundleOfferValueObject>
      {
         return _bundleList;
      }
      
      public function get signal_updateTime() : Signal
      {
         return !!offer?offer.signal_updated:GameTimer.instance.oneSecTimer;
      }
      
      public function get timeLeftString() : String
      {
         return !!offer?offer.timerStringDHorHMS:"time left";
      }
      
      public function get asset() : AssetClipLink
      {
         return !!offer?offer.popupAsset:new AssetClipLink(AssetStorage.rsx.getByName("offer_cyber_monday_2017"),"dialog_bundle_skin_coins");
      }
      
      public function get headerText() : String
      {
         return _headerText;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new CyberMondayTripleSkinCoinPopup(this);
         return new CyberMondayTripleSkinCoinPopup(this);
      }
      
      public function action_buy(param1:MultiBundleOfferValueObject) : void
      {
         if(!param1.billingVO)
         {
            return;
         }
         currentTransactionVo = param1;
         Stash.click("billing_buy:" + param1.billingVO.desc.id,_popup.stashParams);
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
         currentTransactionVo.setBought(true);
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
         currentTransactionVo.setBought(true);
         var _loc4_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc4_.title = Translate.translate(param1.billing.name);
         _loc4_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc4_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         var _loc3_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         _loc4_.reward = _loc3_;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc4_);
         _loc2_.open();
      }
   }
}
