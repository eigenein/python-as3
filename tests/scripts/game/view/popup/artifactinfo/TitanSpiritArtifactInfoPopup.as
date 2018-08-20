package game.view.popup.artifactinfo
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanSpiritArtifactInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanSpiritArtifactInfoPopupMediator;
      
      public var clip:TitanSpiritArtifactInfoPopupClip;
      
      public function TitanSpiritArtifactInfoPopup(param1:TitanSpiritArtifactInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(TitanSpiritArtifactInfoPopupClip,"dialog_titan_spirit_artifact_fragment_info");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.artifact_renderer.setData(mediator.artifact);
         clip.tf_name.text = mediator.artifact.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_FRAGMENT");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_ARTIFACT_INFO_DESC");
         clip.tf_chest.text = Translate.translate("UI_SPIRIT_VALLEY_POPUP_ALTAR");
         clip.btn_chest.signal_click.add(mediator.action_navigate_chest);
         clip.btn_chest.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_FIND");
      }
   }
}
