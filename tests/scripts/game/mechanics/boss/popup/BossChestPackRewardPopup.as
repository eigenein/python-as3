package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.mediator.BossChestPackRewardPopupMediator;
   import game.view.popup.AsyncClipBasedPopup;
   
   public class BossChestPackRewardPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:BossChestPackRewardPopupMediator;
      
      private var clip:BossChestPackRewardPopupClip;
      
      public function BossChestPackRewardPopup(param1:BossChestPackRewardPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_boss);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:int = 0;
         clip = param1.create(BossChestPackRewardPopupClip,"boss_chest_pack_reward_popup");
         addChild(clip.graphics);
         width = 625;
         height = 680;
         clip.button_close.signal_click.add(mediator.close);
         _loc2_ = 0;
         while(_loc2_ < mediator.rewards.length)
         {
            clip.item_reward_[_loc2_].setData(mediator.rewards[_loc2_]);
            _loc2_++;
         }
         if(Translate.has("UI_DIALOG_BOSS_CHEST_REWARD_TITLE"))
         {
            clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_BOSS_CHEST_REWARD_TITLE");
         }
         else
         {
            clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_CHESTREWARD_TITLE");
         }
         if(Translate.has("UI_DIALOG_BOSS_CHEST_REWARD_REWARD"))
         {
            clip.tf_reward.text = Translate.translate("UI_DIALOG_BOSS_CHEST_REWARD_REWARD");
         }
         else
         {
            clip.tf_reward.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_REWARD");
         }
         if(Translate.has("UI_DIALOG_BOSS_CHEST_REWARD_BONUS"))
         {
            clip.tf_bonus.text = Translate.translate("UI_DIALOG_BOSS_CHEST_REWARD_BONUS");
         }
         else
         {
            clip.tf_bonus.text = Translate.translateArgs("UI_CHEST_FREE","");
         }
         clip.tf_reopen.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_REWARD_MORE");
         clip.btn_reopen.cost = mediator.reopenCost.outputDisplayFirst;
         clip.btn_reopen.signal_click.add(mediator.action_reopen);
      }
   }
}
