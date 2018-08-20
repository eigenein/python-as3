package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.player.CommandOfferFarmReward;
   import game.command.social.BillingBuyCommandBase;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.specialoffer.welcomeback.SpecialOfferWelcomeBackPopupMediator;
   import org.osflash.signals.Signal;
   
   public class PlayerSpecialOfferWelcomeBack extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "welcomeBack";
       
      
      private var _billing:BillingPopupValueObject;
      
      private var _freeRewardData:RewardData;
      
      private var _freeReward:Vector.<InventoryItem>;
      
      private var _freeRewardObtained:BooleanPropertyWriteable;
      
      private const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(5);
      
      public const signal_paymentConfirm:Signal = new Signal();
      
      public function PlayerSpecialOfferWelcomeBack(param1:Player, param2:*)
      {
         _freeRewardObtained = new BooleanPropertyWriteable(false);
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_openPopup);
      }
      
      public function get freeReward() : Vector.<InventoryItem>
      {
         return _freeReward;
      }
      
      public function get paymentReward() : Vector.<InventoryItem>
      {
         return _billing.rewardList;
      }
      
      public function get freeRewardObtained() : BooleanProperty
      {
         return _freeRewardObtained;
      }
      
      public function get costString() : String
      {
         return !!_billing?_billing.costString:null;
      }
      
      public function get title() : String
      {
         return Translate.translateArgs(clientData.locale.title,Translate.genderTriggerString(GameModel.instance.player.male));
      }
      
      public function get description() : String
      {
         return Translate.translate(clientData.locale.description);
      }
      
      public function get button() : String
      {
         return Translate.translate(clientData.locale.button);
      }
      
      public function get offerTitle() : String
      {
         return Translate.translate(clientData.locale.offerTitle);
      }
      
      public function get offerDescription() : String
      {
         return Translate.translateArgs(clientData.locale.offerDescription,costString);
      }
      
      public function get offerButton() : String
      {
         return Translate.translate(clientData.locale.offerButton);
      }
      
      public function get offerDescriptionLocaleKey() : String
      {
         return clientData.locale.offerDescription;
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
      
      public function action_claimFree() : void
      {
         var _loc1_:CommandOfferFarmReward = GameModel.instance.actionManager.playerCommands.specialOfferFarmReward(id);
         _loc1_.onClientExecute(handler_farmFreeReward);
      }
      
      public function action_buy() : void
      {
         var _loc1_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(_billing);
         _loc1_.signal_paymentBoxError.add(handler_paymentError);
         _loc1_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc1_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      override protected function update(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         super.update(param1);
         _freeRewardData = new RewardData(param1.reward);
         var _loc3_:InventoryItemSortOrder = new InventoryItemSortOrder(clientData.rewardSortOrder);
         _freeReward = _loc3_.sortFastWithCopy(_freeRewardData.outputDisplay);
         _freeRewardObtained.value = param1.freeRewardObtained;
         var _loc7_:int = 0;
         var _loc6_:* = param1.billings;
         for each(var _loc4_ in param1.billings)
         {
            _loc2_ = _loc4_.id;
            _loc5_ = player.billingData.getById(_loc2_);
            if(_loc5_)
            {
               _billing = new BillingPopupValueObject(_loc5_,player);
            }
         }
      }
      
      private function handler_farmFreeReward(param1:CommandOfferFarmReward) : void
      {
         _freeRewardObtained.value = true;
         param1.farmReward(player);
         var _loc3_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc3_.title = title;
         _loc3_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc3_.description = null;
         _loc3_.reward = _freeReward;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc3_);
         _loc2_.open();
      }
      
      private function handler_openPopup(param1:PopupStashEventParams) : void
      {
         new SpecialOfferWelcomeBackPopupMediator(player,this).open(param1);
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
         signal_paymentConfirm.dispatch();
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
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
