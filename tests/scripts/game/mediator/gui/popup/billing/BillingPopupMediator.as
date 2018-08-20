package game.mediator.gui.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.command.social.SocialBillingBuyCommand;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.VipLevelUpPopupHandler;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.mediator.gui.popup.billing.success.BillingPurchaseSuccessPopupMediator;
   import game.mediator.gui.popup.billing.vip.VipBenefitPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingData;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.social.GMRUserAgreementCheck;
   import game.stat.Stash;
   import game.stat.VKPixel;
   import game.view.popup.MessagePopup;
   import game.view.popup.PopupBase;
   import game.view.popup.billing.BillingPopup;
   import idv.cjcat.signals.Signal;
   
   public class BillingPopupMediator extends PopupMediator
   {
      
      public static const SUBSCRIPTION_SLOT:int = 1;
      
      public static const SLOT_COUNT:int = 6;
       
      
      private var _vipUpdateSignal:Signal;
      
      public const signal_billingsUpdated:Signal = new Signal();
      
      public const signal_billingsAvailableToggled:Signal = new Signal(Boolean);
      
      public const signal_sideBarUpdated:Signal = new Signal();
      
      private var _data:Vector.<BillingPopupValueObject>;
      
      private var _billingBySlot:Vector.<BillingPopupValueObject>;
      
      private var raidPromo:BillingRaidPromoMediator;
      
      public const sideBarMediator:PopupSideBarMediator = new PopupSideBarMediator();
      
      public function BillingPopupMediator(param1:Player)
      {
         _billingBySlot = new Vector.<BillingPopupValueObject>(6);
         super(param1);
         _data = new Vector.<BillingPopupValueObject>();
         raidPromo = new BillingRaidPromoMediator(param1);
         param1.billingData.whenReady(setupBillings);
         param1.billingData.signal_updated.add(setupBillings);
         _vipUpdateSignal = param1.signal_update.vip_points;
         sideBarMediator.addValueObjectSource(param1.specialOffer.hooks.billingSideBarValueObjects);
         sideBarMediator.addValueObjectSource(raidPromo.sideBarValueObjects);
      }
      
      public function get signal_updateVip() : Signal
      {
         return _vipUpdateSignal;
      }
      
      public function get playerVipPoints() : int
      {
         return player.vipPoints;
      }
      
      public function get playerVipLevel() : int
      {
         return player.vipLevel.level;
      }
      
      public function get playerVipPointsCurrentLvl() : int
      {
         return player.vipLevel.exp;
      }
      
      public function get hasNextVipLevel() : Boolean
      {
         return player.vipLevel.nextLevel;
      }
      
      public function get playerVipPointsNextLvl() : int
      {
         return !!player.vipLevel.nextLevel?player.vipLevel.nextLevel.exp:int(player.vipPoints);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(false);
         return _loc1_;
      }
      
      public function increaseVip() : void
      {
      }
      
      override public function open(param1:PopupStashEventParams = null) : void
      {
         super.open(param1);
         VKPixel.send("bank_gems_open");
         if(GMRUserAgreementCheck.instance)
         {
            GMRUserAgreementCheck.instance.action_userAgreementShow();
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BillingPopup(this);
         return _popup;
      }
      
      public function action_buy(param1:BillingPopupValueObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:PopupStashEventParams = _popup.stashParams;
         if(param1.available)
         {
            VipLevelUpPopupHandler.instance.hold();
            _loc3_ = new BillingConfirmPopupMediator(GameModel.instance.player,param1);
            _loc3_.signal_refused.addOnce(onBuyRefuse);
            _loc3_.signal_success.addOnce(handler_buySuccess);
            if(DataStorage.rule.skipBillingConfirmationPopupRule)
            {
               Stash.click("buy:" + param1.desc.id,_loc2_);
               _loc3_.action_confirm();
            }
            else
            {
               _loc3_.open(Stash.click("buy:" + param1.desc.id,_loc2_));
            }
            try
            {
               VKPixel.send("bank_gems_click:" + param1.desc.id);
            }
            catch(error:Error)
            {
            }
            signal_billingsAvailableToggled.dispatch(false);
         }
         else if(param1.isSubscription)
         {
            showActiveSubscriptionInfo(param1 as BillingPopupSubscriptionValueObject);
         }
      }
      
      public function action_showVipBenefits() : void
      {
         var _loc1_:PopupStashEventParams = _popup.stashParams;
         var _loc2_:VipBenefitPopupMediator = new VipBenefitPopupMediator(GameModel.instance.player);
         _loc2_.open(Stash.click("bonus",_loc1_));
         close();
      }
      
      public function getBillingBySlot(param1:int) : BillingPopupValueObject
      {
         if(param1 > _billingBySlot.length)
         {
            return null;
         }
         return _billingBySlot[param1 - 1];
      }
      
      public function getNewVipLevelByBilling(param1:BillingPopupValueObject) : int
      {
         return DataStorage.level.getVipLevelByVipPoints(playerVipPoints + param1.vipPoints).level;
      }
      
      override protected function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function setupBillings(param1:PlayerBillingData) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function showActiveSubscriptionInfo(param1:BillingPopupSubscriptionValueObject) : void
      {
         var _loc3_:String = Translate.translate("UI_DIALOG_BILLING_SUBSCRIPTION_ALREADY");
         var _loc4_:String = Translate.translateArgs("UI_DIALOG_BILLING_SUBSCRIPTION_LEFT",param1.durationLeft,param1.toRewnewLeft);
         var _loc2_:MessagePopup = new MessagePopup(_loc4_,_loc3_);
         PopUpManager.addPopUp(_loc2_,false);
      }
      
      private function setupBillingsBySlots() : void
      {
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc4_:* = 6;
         _billingBySlot.length = 0;
         _billingBySlot.length = _loc4_;
         var _loc7_:int = 0;
         var _loc6_:* = _data;
         for each(var _loc2_ in _data)
         {
            _loc5_ = _loc2_.desc;
            _loc3_ = _loc5_.slot;
            if(_loc3_ != 0)
            {
               if(_loc3_ > _loc4_)
               {
                  _loc4_ = _loc3_;
                  _billingBySlot.length = _loc4_;
               }
               _loc1_ = _billingBySlot[_loc3_ - 1];
               if(_loc1_ == null || _loc1_.desc.inSlotPriority > _loc5_.inSlotPriority)
               {
                  _billingBySlot[_loc3_ - 1] = _loc2_;
               }
            }
         }
         if(_billingBySlot.length > 6)
         {
            _billingBySlot.sort(sort_priority);
            _billingBySlot.length = 6;
         }
         if(player.vipPoints > 0)
         {
            _billingBySlot.sort(sort_slot_reversed);
         }
         else
         {
            _billingBySlot.sort(sort_slot);
         }
      }
      
      private function sort_priority(param1:BillingPopupValueObject, param2:BillingPopupValueObject) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param1.desc.priority - param2.desc.priority;
      }
      
      private function sort_slot(param1:BillingPopupValueObject, param2:BillingPopupValueObject) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param1.desc.slot - param2.desc.slot;
      }
      
      private function sort_slot_reversed(param1:BillingPopupValueObject, param2:BillingPopupValueObject) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param2.desc.slot - param1.desc.slot;
      }
      
      protected function onBuyRefuse() : void
      {
         VipLevelUpPopupHandler.instance.release();
         signal_billingsAvailableToggled.dispatch(true);
      }
      
      private function handler_buySuccess(param1:SocialBillingBuyCommand) : void
      {
         var _loc2_:BillingPurchaseSuccessPopupMediator = new BillingPurchaseSuccessPopupMediator(GameModel.instance.player,param1);
         _loc2_.open(_popup.stashParams);
         _loc2_.signal_close.addOnce(handler_successPopupClosed);
         AssetStorage.sound.buySuccess.play();
      }
      
      private function handler_successPopupClosed(param1:BillingPurchaseSuccessPopupMediator) : void
      {
         VipLevelUpPopupHandler.instance.release();
         if(param1.cmd.vipLevelPrev != param1.cmd.vipLevelObtained)
         {
         }
      }
      
      private function handler_promoBillingClick(param1:BillingPopupValueObject) : void
      {
         var _loc2_:RaidPromoPopupMediator = new RaidPromoPopupMediator(player);
         _loc2_.open(Stash.click("raid_promo_billing",_popup.stashParams));
      }
   }
}
