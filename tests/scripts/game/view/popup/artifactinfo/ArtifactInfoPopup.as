package game.view.popup.artifactinfo
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class ArtifactInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ArtifactInfoPopupMediator;
      
      public var clip:ArtifactInfoPopupClip;
      
      public function ArtifactInfoPopup(param1:ArtifactInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ArtifactInfoPopupClip,"dialog_artifact_fragment_info");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.artifact_renderer.setData(mediator.artifact);
         clip.tf_name.text = mediator.artifact.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_FRAGMENT");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_ARTIFACT_INFO_DESC");
         clip.tf_expedition.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_EXPEDITIONS");
         clip.tf_chest.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_CHEST");
         clip.tf_store.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_MERCHANT");
         clip.btn_expedition.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_FIND");
         clip.btn_expedition.signal_click.add(mediator.action_navigate_expeditions);
         clip.btn_chest.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_FIND");
         clip.btn_chest.signal_click.add(mediator.action_navigate_chest);
         clip.btn_store.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_GO");
         clip.btn_store.signal_click.add(mediator.action_navigate_merchant);
      }
   }
}
