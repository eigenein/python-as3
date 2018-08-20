package game.view.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.view.popup.ClipBasedPopup;
   
   public class RewardSpiritPopup extends ClipBasedPopup
   {
       
      
      private var clip:RewardSpiritPopupClip;
      
      public var artifact:TitanArtifactDescription;
      
      public function RewardSpiritPopup(param1:TitanArtifactDescription)
      {
         super(null);
         this.artifact = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 600;
         height = 500;
         clip = AssetStorage.rsx.popup_theme.create(RewardSpiritPopupClip,"dialog_spirit_reward");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         clip.tf_name.text = artifact.name;
         clip.item.setData(artifact);
         clip.tf_header.text = Translate.translate("UI_DIALOG_REWARD_SPIRIT_HDR");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_REWARD_SPIRIT_DESC");
         clip.okButton.signal_click.add(close);
         clip.okButton.label = Translate.translate("UI_POPUP_HERO_UPGRADE_OK");
         whenDisplayed(playSound);
      }
      
      private function playSound() : void
      {
         AssetStorage.sound.heroUp.play();
      }
   }
}
