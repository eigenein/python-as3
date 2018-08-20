package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.expedition.mediator.SubscriptionActivateRewardPopupMediator;
   import game.mechanics.zeppelin.popup.ZeppelinPopupBase;
   
   public class SubscriptionActivateRewardPopup extends ZeppelinPopupBase
   {
       
      
      private var mediator:SubscriptionActivateRewardPopupMediator;
      
      private var clip:SubscriptionActivateRewardPopupClip;
      
      public function SubscriptionActivateRewardPopup(param1:SubscriptionActivateRewardPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_artifact_subscription);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = AssetStorage.rsx.dialog_artifact_subscription.create(SubscriptionActivateRewardPopupClip,"dialog_subscription_activate_reward");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.tf_benefit_3.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_3");
         clip.tf_benefit_2.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_2");
         clip.tf_benefit_1.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_TF_BENEFIT_1");
         clip.tf_label_desc.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_ACTIVATE_REWARD_TF_LABEL_DESC");
         clip.tf_label_reward_daily.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_ACTIVATE_REWARD_TF_LABEL_REWARD_DAILY");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_SUBSCRIPTION_ACTIVATE_REWARD_TF_LABEL_REWARD");
         clip.button_ok.label = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         clip.list_item_1.setData(mediator.activationReward);
         clip.list_item_2.setData(mediator.dailyReward);
         clip.tf_header.text = mediator.title;
         clip.button_ok.signal_click.add(close);
      }
   }
}
