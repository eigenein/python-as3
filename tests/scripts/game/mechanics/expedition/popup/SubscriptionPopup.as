package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.timer.GameTimer;
   import game.mechanics.expedition.mediator.SubscriptionPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class SubscriptionPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:SubscriptionPopupMediator;
      
      private var clip:SubscriptionPopupClip;
      
      public function SubscriptionPopup(param1:SubscriptionPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_artifact_subscription);
      }
      
      override public function dispose() : void
      {
         mediator.currentSubscriptionLevel.signal_update.remove(handler_level);
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(SubscriptionPopupClip,"dialog_subscription");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.tf_header.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_SUBSCRIPTION");
         clip.tf_benefit_weekly.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_WEEKLY");
         clip.tf_benefit_3.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_3");
         clip.tf_benefit_2.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_2");
         clip.tf_benefit_1.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_1");
         clip.button_vk_resume.tf_vk_pending_cancel.label = Translate.translate("UI_DIALOG_SUBSCRIPTION_VK_RESUME");
         clip.button_vk_resume.signal_click.add(mediator.action_resumeVK);
         clip.tf_benefit_server.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_SERVER");
         clip.button_ok.signal_click.add(mediator.action_buy);
         clip.button_close.signal_click.add(close);
         clip.tf_benefit_header.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_HEADER");
         clip.block_bonus.reward_item.data = mediator.activationReward;
         GameTimer.instance.oneSecTimer.add(handler_timer);
         mediator.currentSubscriptionLevel.signal_update.add(handler_level);
         handler_level();
         updateState();
      }
      
      private function updateState() : void
      {
         clip.tf_active_state.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_STATE_AUTO");
         var _loc1_:Boolean = mediator.state_canProlong;
         var _loc3_:Boolean = mediator.state_lastChanceToRenew;
         clip.block_bonus.graphics.visible = _loc1_;
         clip.button_ok.graphics.visible = _loc1_;
         clip.tf_activate.graphics.visible = _loc1_;
         clip.tf_active_state.graphics.visible = !_loc1_ && !mediator.state_isPendingCancel;
         if(_loc3_)
         {
            clip.tf_renew_red.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_RENEW_RED",mediator.time_renewLastChance);
         }
         clip.tf_renew_red.visible = _loc3_;
         clip.renew_red.graphics.visible = _loc3_;
         clip.tf_active_duration_state.visible = mediator.state_isActive;
         clip.tf_active_duration_state.y = 420;
         clip.layout_vk_resume.graphics.visible = mediator.state_isPendingCancel;
         var _loc2_:Boolean = false;
         if(!mediator.state_isActive)
         {
            if(mediator.state_lastChanceToRenew)
            {
               clip.tf_activate.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_RENEW",mediator.billingCost);
               clip.button_ok.label = Translate.translate("UI_DIALOG_SUBSCRIPTION_BUTTON_RENEW");
               clip.block_bonus.tf_label_activation_bonus.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_LABEL_RENEW_BONUS");
               _loc2_ = true;
            }
            else
            {
               clip.tf_activate.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVATE",mediator.billingCost);
               clip.button_ok.label = Translate.translate("UI_DIALOG_SUBSCRIPTION_BUTTON_ACTIVATE");
               clip.block_bonus.tf_label_activation_bonus.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_LABEL_ACTIVATION_BONUS");
            }
         }
         else if(mediator.state_isAuto)
         {
            clip.tf_active_duration_state.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_DURATION_STATE",mediator.time_durationLeft);
            clip.tf_active_state.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_STATE_AUTO",mediator.time_nextProlong);
         }
         else if(mediator.state_canProlong)
         {
            clip.tf_active_duration_state.y = 400;
            clip.tf_active_duration_state.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_DURATION_STATE",mediator.time_durationLeft);
            clip.tf_activate.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVATE_PROLONG",mediator.billingCost);
            clip.button_ok.label = Translate.translate("UI_DIALOG_SUBSCRIPTION_BUTTON_PROLONG");
            clip.block_bonus.tf_label_activation_bonus.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_LABEL_PROLONG_BONUS");
         }
         else
         {
            clip.tf_active_duration_state.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_DURATION_STATE",mediator.time_durationLeft);
            clip.tf_active_state.text = Translate.translateArgs("UI_DIALOG_SUBSCRIPTION_TF_ACTIVE_STATE_MANUAL",mediator.time_nextProlong);
         }
         clip.block_bonus.playback.gotoAndStop(!!_loc2_?1:0);
      }
      
      private function handler_timer() : void
      {
         updateState();
      }
      
      private function handler_level(param1:int = 0) : void
      {
         clip.level_list.list.dataProvider = new ListCollection(mediator.levels);
         clip.level_list.list_frame.dataProvider = new ListCollection(mediator.levels);
         clip.level_list.scrollTo(mediator.currentSubscriptionLevel.value);
      }
   }
}
