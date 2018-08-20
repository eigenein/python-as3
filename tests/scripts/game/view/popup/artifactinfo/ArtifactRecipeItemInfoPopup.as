package game.view.popup.artifactinfo
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class ArtifactRecipeItemInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ArtifactRecipeItemInfoPopupMediator;
      
      public var clip:ArtifactRecipeItemInfoPopupClip;
      
      public function ArtifactRecipeItemInfoPopup(param1:ArtifactRecipeItemInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ArtifactRecipeItemInfoPopupClip,"dialog_artifact_recipe_info");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.item_renderer.setData(mediator.item);
         clip.tf_name.text = mediator.item.name;
         clip.tf_desc.text = Translate.translate("UI_DIALOG_ARTIFACT_INFO_DESC");
         clip.tf_expedition.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_EXPEDITIONS");
         clip.tf_chest.text = Translate.translate("UI_ZEPPELIN_POPUP_TF_CHEST");
         clip.btn_expedition.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_FIND");
         clip.btn_expedition.signal_click.add(mediator.action_navigate_expeditions);
         clip.btn_chest.label = Translate.translate("UI_DIALOG_ARTIFACT_INFO_GO");
         clip.btn_chest.signal_click.add(mediator.action_navigate_chest);
      }
   }
}
