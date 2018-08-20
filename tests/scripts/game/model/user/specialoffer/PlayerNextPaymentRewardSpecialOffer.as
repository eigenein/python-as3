package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.command.social.SocialBillingBuyResult;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.SideBarBlockValueObject;
   import game.mediator.gui.popup.billing.bundle.HeroBundlePopupDescription;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.mediator.gui.popup.billing.bundle.HeroSpecialOfferPopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.gui.homescreen.HomeScreenGuiChestClipButton;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.specialoffer.nextpaymentreward.SpecialOfferNextPaymentHeroView;
   import game.view.specialoffer.nextpaymentreward.SpecialOfferNextPaymentRewardView;
   import org.osflash.signals.Signal;
   
   public class PlayerNextPaymentRewardSpecialOffer extends PlayerSpecialOfferWithTimer
   {
       
      
      private const autoPopupQueueEntry:AutoPopupQueueEntry = new AutoPopupQueueEntry(4);
      
      private var _reward:RewardData;
      
      private var billingsSideBarValueObject:SideBarBlockValueObject;
      
      public function PlayerNextPaymentRewardSpecialOffer(param1:Player, param2:*)
      {
         billingsSideBarValueObject = new SideBarBlockValueObject(0);
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_autoPopupOpen);
         billingsSideBarValueObject.signal_initialize.add(handler_initializeBillingsSideBarBlock);
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get heroDescription() : HeroDescription
      {
         var _loc2_:Array = reward.fragmentCollection.getCollectionByType(InventoryItemType.HERO).getArray();
         var _loc4_:int = 0;
         var _loc3_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_.item is HeroDescription)
            {
               return _loc1_.item as HeroDescription;
            }
         }
         return null;
      }
      
      override public function get signal_updated() : Signal
      {
         return GameTimer.instance.oneSecTimer;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.hooks._billingSideBarValueObjects.push(billingsSideBarValueObject);
         param1.hooks.homeScreenChest.add(handler_homeScreenChest);
         param1.hooks.billingResult.add(handler_billingResult);
         param1.addAutoPopup(autoPopupQueueEntry);
         param1.invalidateBillings();
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks._billingSideBarValueObjects.remove(billingsSideBarValueObject);
         param1.hooks.homeScreenChest.remove(handler_homeScreenChest);
         param1.hooks.billingResult.remove(handler_billingResult);
         autoPopupQueueEntry.dispose();
         param1.invalidateBillings();
      }
      
      public function action_details(param1:Boolean, param2:PopupStashEventParams) : void
      {
         var _loc3_:HeroSpecialOfferPopupMediator = createOfferPopup(param1,param2);
         _loc3_.open(param2);
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         _reward = new RewardData(param1.reward);
      }
      
      protected function createOfferPopup(param1:Boolean, param2:PopupStashEventParams) : HeroSpecialOfferPopupMediator
      {
         var _loc3_:* = null;
         autoPopupQueueEntry.dispose();
         var _loc4_:HeroBundlePopupDescription = new HeroBundlePopupDescription();
         if(clientData && clientData.locale)
         {
            _loc3_ = clientData.locale;
            _loc4_.buttonLabel = Translate.translate(_loc3_.button);
            _loc4_.title = Translate.translate(_loc3_.title);
            _loc4_.description = Translate.translate(_loc3_.description);
         }
         _loc4_.discountValue = 0;
         _loc4_.oldPrice = null;
         _loc4_.reward = _reward;
         if(!param1)
         {
            _loc4_.signal_click.add(handler_toBank);
         }
         _loc4_.signal_removed = signal_removed;
         _loc4_.signal_updateTimeLeft = signal_updated;
         _loc4_.timeLeftMethod = timeLeftMethod;
         _loc4_.stashWindowName = "specialOffer:" + id;
         return new HeroSpecialOfferPopupMediator(player,_loc4_);
      }
      
      private function timeLeftMethod() : String
      {
         return timerString;
      }
      
      private function handler_billingsSidebarValueObjects(param1:Vector.<SideBarBlockValueObject>) : void
      {
         var _loc2_:SideBarBlockValueObject = new SideBarBlockValueObject(0);
         _loc2_.signal_initialize.add(handler_initializeBillingsSideBarBlock);
         param1.push(_loc2_);
      }
      
      private function handler_initializeBillingsSideBarBlock(param1:SideBarBlockValueObject) : void
      {
         var _loc2_:SpecialOfferNextPaymentRewardView = new SpecialOfferNextPaymentRewardView(this);
         param1.sideBarBlock = _loc2_;
      }
      
      private function handler_autoPopupOpen(param1:PopupStashEventParams) : void
      {
         var _loc3_:PopupStashEventParams = Stash.click("specialOffer:" + id,param1);
         var _loc2_:Boolean = false;
         var _loc4_:HeroSpecialOfferPopupMediator = createOfferPopup(_loc2_,_loc3_);
         _loc4_.openDelayed(_loc3_);
      }
      
      private function handler_homeScreenChest(param1:HomeScreenGuiChestClipButton) : void
      {
         var _loc2_:SpecialOfferNextPaymentHeroView = new SpecialOfferNextPaymentHeroView(this);
         _loc2_.signal_click.add(handler_iconClick);
         _loc2_.displayStyle.apply(param1.container,param1.container.parent,param1.container.parent);
      }
      
      private function handler_billingResult(param1:SocialBillingBuyResult) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:RewardData = param1.getOfferReward(id);
         if(_loc3_)
         {
            _loc5_ = new HeroBundleRewardPopupDescription();
            if(clientData && clientData.locale)
            {
               _loc4_ = clientData.locale;
               _loc5_.title = Translate.translate(_loc4_.title);
            }
            _loc5_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
            _loc5_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
            _loc5_.reward = _loc3_.outputDisplay;
            _loc2_ = new HeroBundleRewardPopup(_loc5_);
            _loc2_.open();
         }
      }
      
      private function handler_iconClick() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "global";
         action_details(false,Stash.click("specialOffer:" + id,_loc1_));
      }
      
      private function handler_toBank() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.windowName = "specialOffer:" + id;
         PopupList.instance.dialog_bank(_loc1_);
      }
   }
}
