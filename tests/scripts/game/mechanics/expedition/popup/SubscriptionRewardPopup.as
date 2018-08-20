package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.expedition.mediator.SubscriptionRewardPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class SubscriptionRewardPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:SubscriptionRewardPopupMediator;
      
      private var clip:SubscriptionRewardPopupClip;
      
      public function SubscriptionRewardPopup(param1:SubscriptionRewardPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_artifact_subscription);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:int = 0;
         if(mediator.rewards.length == 2)
         {
            clip = AssetStorage.rsx.dialog_artifact_subscription.create(SubscriptionRewardPopupClip,"popup_subscription_reward_2");
         }
         else
         {
            clip = AssetStorage.rsx.dialog_artifact_subscription.create(SubscriptionRewardPopupClip,"popup_subscription_reward_1");
         }
         addChild(clip.graphics);
         var _loc2_:int = clip.reward.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.reward[_loc3_].setData(mediator.rewards[_loc3_]);
            _loc3_++;
         }
         clip.tf_header.text = Translate.translateArgs("UI_POPUP_SUBSCRIPTION_REWARD_1_TF_HEADER",mediator.rewards.length);
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_CHEST_REWARD");
         clip.button_ok.signal_click.add(mediator.action_close);
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
      }
   }
}
