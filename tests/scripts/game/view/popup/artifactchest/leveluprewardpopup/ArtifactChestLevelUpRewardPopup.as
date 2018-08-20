package game.view.popup.artifactchest.leveluprewardpopup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   import org.osflash.signals.Signal;
   
   public class ArtifactChestLevelUpRewardPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ArtifactChestLevelUpRewardPopupMediator;
      
      private var clip:ArtifactChestLevelUpRewardPopupCip;
      
      private var _signal_close:Signal;
      
      public function ArtifactChestLevelUpRewardPopup(param1:ArtifactChestLevelUpRewardPopupMediator)
      {
         _signal_close = new Signal();
         super(param1);
         this.mediator = param1;
      }
      
      override public function close() : void
      {
         super.close();
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestLevelUpRewardPopupCip,"artifact_chest_new_level_reward_popup");
         addChild(clip.graphics);
         if(mediator.levelUpReward.outputDisplay.length >= 1)
         {
            clip.reward_item2.setData(mediator.levelUpReward.outputDisplay[0]);
         }
         if(mediator.levelUpReward.outputDisplay.length >= 2)
         {
            clip.reward_item1.setData(mediator.levelUpReward.outputDisplay[1]);
         }
         clip.tf_label_item_name.text = Translate.translate("UI_POPUP_CHEST_REWARD");
         clip.tf_level.text = mediator.newLevel.toString();
         clip.button_close.signal_click.add(close);
         clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_LEVEL_UP");
         clip.key_content.container.visible = mediator.playerInClan;
         clip.key_content.tf_key.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_KEY");
         clip.key_content.tf_key_desc.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_KEY_DESC");
         clip.button_ok.signal_click.add(close);
         clip.button_ok.label = Translate.translate("UI_DIALOG_LEVEL_UP_OK");
         clip.button_ok.graphics.y = !!mediator.playerInClan?555:Number(455);
         width = 1000;
         height = !!mediator.playerInClan?650:Number(600);
      }
   }
}
