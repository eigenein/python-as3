package game.view.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.util.ExternalInterfaceProxy;
   import engine.context.platform.social.FBSocialFacadeHelper;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.billing.BillingPopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideBar;
   import starling.core.Starling;
   
   public class BillingPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var mediator:BillingPopupMediator;
      
      private var hoverController:BillingPopupHoverController;
      
      private var sideBar:PopupSideBar;
      
      private var _clip:BillingPopupClip;
      
      private var _newVipLevelProgressValue:Number;
      
      public function BillingPopup(param1:BillingPopupMediator)
      {
         hoverController = new BillingPopupHoverController();
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "bank_gems";
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = clip.billings_item.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            clip.billings_item[_loc1_].dispose();
            clip.billings_item[_loc1_].signal_click.remove(handler_billingClick);
            clip.billings_item[_loc1_].signal_hover.remove(hoverController.handler_billingHover);
            clip.billings_item[_loc1_].signal_out.remove(hoverController.handler_billingOut);
            _loc1_++;
         }
         mediator.signal_updateVip.remove(updateVipLabel);
         hoverController.hoveredBilling.unsubscribe(handler_showBillingHoverInfo);
         sideBar.dispose();
         Starling.juggler.removeTweens(this);
         super.dispose();
      }
      
      public function get clip() : BillingPopupClip
      {
         return _clip;
      }
      
      public function get newVipLevelProgressValue() : Number
      {
         return _newVipLevelProgressValue;
      }
      
      public function set newVipLevelProgressValue(param1:Number) : void
      {
         var _loc2_:int = 5 + (clip.layout_progress_bar.width - 5) * param1;
         clip.progress_bar_new.image.width = _loc2_;
         var _loc3_:int = clip.progress_bar_new.image.x + clip.progress_bar_new.image.width;
         var _loc4_:int = clip.bg_progress_new_value.graphics.x;
         clip.bg_progress_new_value.graphics.visible = clip.tf_progress_new_value.visible && _loc3_ > _loc4_;
         _newVipLevelProgressValue = param1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.BILLING;
      }
      
      override public function close() : void
      {
      }
      
      public function internalClose() : void
      {
         super.close();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         super.initialize();
         try
         {
            ExternalInterfaceProxy.call("InitiateCheckout");
         }
         catch(error:Error)
         {
         }
         _clip = AssetStorage.rsx.popup_theme.create_dialog_billing();
         addChild(clip.graphics);
         clip.title = Translate.translate("UI_DIALOG_BILLING_HEADER");
         clip.button_close.signal_click.add(internalClose);
         clip.button_benefits.initialize(Translate.translate("UI_DIALOG_BILLING_BENEFITS"),mediator.action_showVipBenefits);
         clip.vip_permanent_block.graphics.visible = Translate.has("UI_DIALOG_BILLING_PERMANENT_GRANTED") && Translate.has("UI_DIALOG_BILLING_PERMANENT");
         clip.vip_permanent_block.tf_vip_permanent_label1.text = Translate.translate("UI_DIALOG_BILLING_PERMANENT_GRANTED");
         clip.vip_permanent_block.tf_vip_permanent_label1.adjustSizeToFitWidth(100);
         clip.vip_permanent_block.tf_vip_permanent_label2.height = NaN;
         clip.vip_permanent_block.tf_vip_permanent_label2.text = Translate.translate("UI_DIALOG_BILLING_PERMANENT");
         clip.vip_permanent_block.tf_vip_permanent_label2.adjustSizeToFitWidth();
         mediator.signal_billingsAvailableToggled.add(updateBillingsAvailable);
         subscribeBillingButtons();
         mediator.signal_billingsUpdated.add(updateBillings);
         updateBillings();
         mediator.signal_updateVip.add(updateVipLabel);
         updateVipLabel();
         mediator.increaseVip();
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         sideBar = new PopupSideBar(this,mediator.sideBarMediator);
         addChild(sideBar.graphics);
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            _loc1_ = FBSocialFacadeHelper.countryCode;
            _loc2_ = DataStorage.rule.fbVATRule.getForCountryCode(_loc1_);
            if(_loc2_)
            {
               clip.tf_vat.text = Translate.translateArgs("UI_BILLING_POPUP_VAT",_loc2_);
            }
         }
         hoverController.hoveredBilling.onValue(handler_showBillingHoverInfo);
      }
      
      private function setupBilling(param1:BillingItemClip, param2:int) : void
      {
         param1.setData(mediator.getBillingBySlot(param2));
      }
      
      private function handler_billingClick(param1:BillingPopupValueObject) : void
      {
         mediator.action_buy(param1);
      }
      
      private function updateBillingsAvailable(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = clip.billings_item.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = clip.billings_item[_loc3_];
            _loc2_.isEnabled = param1;
            _loc3_++;
         }
      }
      
      private function subscribeBillingButtons() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = clip.billings_item.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            clip.billings_item[_loc1_].signal_click.add(handler_billingClick);
            clip.billings_item[_loc1_].signal_hover.add(hoverController.handler_billingHover);
            clip.billings_item[_loc1_].signal_out.add(hoverController.handler_billingOut);
            _loc1_++;
         }
      }
      
      private function updateBillings() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = clip.billings_item.length;
         var _loc5_:int = 0;
         var _loc7_:* = 0;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc1_ = clip.billings_item[_loc4_];
            setupBilling(_loc1_,_loc4_ + 1);
            _loc1_.tf_price.validate();
            _loc3_ = _loc1_.tf_price.width;
            if(_loc3_ > _loc7_)
            {
               _loc7_ = _loc3_;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            clip.billings_item[_loc4_].layoutPrice(_loc7_);
            _loc4_++;
         }
         updateBillingsAvailable(true);
      }
      
      private function updateVipLabel() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = NaN;
         var _loc2_:int = mediator.playerVipPoints;
         clip.vip_level.setVip(mediator.playerVipLevel);
         clip.points_needed_block.showGemIcon = mediator.playerVipLevel == 0;
         if(mediator.hasNextVipLevel)
         {
            _loc1_ = mediator.playerVipPointsCurrentLvl;
            _loc4_ = mediator.playerVipPointsNextLvl;
            _loc5_ = mediator.playerVipLevel + 1;
            clip.points_needed_block.setProgress(_loc4_ - _loc2_,_loc5_);
            clip.tf_progress_value.text = _loc2_ + "/" + _loc4_;
            _loc3_ = Number(_loc2_ / _loc4_);
         }
         else
         {
            clip.tf_progress_value.text = String(_loc2_);
            clip.points_needed_block.setMax();
            _loc3_ = 1;
         }
         Starling.juggler.removeTweens(this);
         newVipLevelProgressValue = _loc3_;
         clip.progress_bar.image.width = int(5 + (clip.layout_progress_bar.width - 5) * _loc3_);
      }
      
      private function handler_showBillingHoverInfo(param1:BillingPopupValueObject) : void
      {
         var _loc3_:* = NaN;
         var _loc4_:* = param1 != hoverController.BILLING_NOT_SELECTED;
         var _loc9_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc2_:int = mediator.playerVipPoints;
         var _loc7_:int = mediator.playerVipPointsNextLvl;
         if(_loc4_)
         {
            clip.tf_progress_new_value.text = "+" + param1.vipPoints;
            _loc2_ = _loc2_ + param1.vipPoints;
            _loc3_ = Number(_loc2_ / _loc7_);
            if(_loc3_ >= 1)
            {
               _loc3_ = 1;
               if(mediator.hasNextVipLevel)
               {
                  _loc5_ = true;
               }
            }
            if(_loc3_ > 0.7)
            {
               _loc9_ = true;
            }
         }
         else
         {
            _loc3_ = Number(_loc2_ / _loc7_);
         }
         Starling.juggler.tween(this,0.3,{
            "newVipLevelProgressValue":_loc3_,
            "transition":"easeOut"
         });
         if(_loc5_)
         {
            clip.vip_level.setVip(mediator.getNewVipLevelByBilling(param1));
            clip.animation_vip_level_up.show(clip.container);
            clip.vip_permanent_block.tweenActivate();
         }
         else
         {
            clip.vip_level.setVip(mediator.playerVipLevel);
            clip.animation_vip_level_up.hide();
            clip.vip_permanent_block.tweenDeactivate();
         }
         var _loc6_:int = 3;
         var _loc8_:Number = clip.tf_progress_new_value.textWidth;
         clip.bg_progress_new_value.graphics.x = clip.tf_progress_new_value.x + clip.tf_progress_new_value.width - _loc8_ - _loc6_;
         clip.bg_progress_new_value.graphics.width = _loc8_ + _loc6_ * 2;
         clip.tf_progress_new_value.graphics.visible = _loc4_;
      }
   }
}
