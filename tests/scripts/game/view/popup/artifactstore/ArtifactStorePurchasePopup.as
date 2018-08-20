package game.view.popup.artifactstore
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.quest.QuestRewardPopupClip;
   
   public class ArtifactStorePurchasePopup extends ClipBasedPopup
   {
       
      
      private var artifact:InventoryItem;
      
      private var clip:QuestRewardPopupClip;
      
      public function ArtifactStorePurchasePopup(param1:InventoryItem)
      {
         super(null);
         this.artifact = param1;
      }
      
      override public function close() : void
      {
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardPopupClip,"popup_quest_reward") as QuestRewardPopupClip;
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         clip.tf_label_reward.text = artifact.name;
         clip.button_ok.label = Translate.translate("UI_DIALOG_ARTIFACT_STORE_RESULT_OK");
         clip.button_ok.signal_click.add(close);
         clip.setReward(new <InventoryItem>[artifact]);
      }
   }
}
