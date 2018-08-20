package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerSkipPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class TowerSkipPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TowerSkipPopupMediator;
      
      private var clip:TowerSkipPopupClip;
      
      public function TowerSkipPopup(param1:TowerSkipPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.tower_floors.create(TowerSkipPopupClip,"dialog_tower_skip");
         addChild(clip.graphics);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_TOWER_SKIP_TF_DESC");
         clip.title = Translate.translate("UI_DIALOG_TOWER_SKIP_TF_TITLE");
         clip.button_tower_skip_inst0.label = Translate.translate("UI_DIALOG_TOWER_SKIP_BUTTON_LABEL_SELECT");
         clip.tf_open_all_desc.text = Translate.translate("UI_DIALOG_TOWER_SKIP_TF_OPEN_ALL_DESC");
         clip.tf_select_desc.text = Translate.translate("UI_DIALOG_TOWER_SKIP_TF_SELECT_DESC");
         clip.button_close.signal_click.add(mediator.close);
         clip.button_tower_skip_full_inst0.signal_click.add(mediator.action_skipFull);
         clip.button_tower_skip_inst0.signal_click.add(mediator.action_skipSelect);
         clip.tf_ribbon_select.text = Translate.translateArgs("UI_DIALOG_TOWER_SKIP_TF_RIBBON_SELECT",mediator.minChests);
         updateMaxChests();
      }
      
      private function updateMaxChests() : void
      {
         clip.tf_ribbon_all.text = Translate.translateArgs("UI_DIALOG_TOWER_SKIP_TF_RIBBON_ALL",mediator.maxChests);
         clip.button_tower_skip_full_inst0.tf_label.text = Translate.translate("UI_DIALOG_TOWER_SKIP_BUTTON_LABEL_OPEN_ALL");
         clip.button_tower_skip_full_inst0.tf_cost.text = mediator.openCost.toString();
      }
   }
}
