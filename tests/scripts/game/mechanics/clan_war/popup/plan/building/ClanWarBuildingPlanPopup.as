package game.mechanics.clan_war.popup.plan.building
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.ClanWarBuildingPlanPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarBuildingPlanPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ClanWarBuildingPlanPopupMediator;
      
      private var clip:ClanWarBuildingPlanPopupClip;
      
      public function ClanWarBuildingPlanPopup(param1:ClanWarBuildingPlanPopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = param1.create(ClanWarBuildingPlanPopupClip,"popup_building_selected");
         addChild(clip.graphics);
         clip.tf_warning.text = Translate.translate("UI_POPUP_BUILDING_SELECTED_TF_WARNING");
         clip.tf_header.text = mediator.text_header;
         clip.tf_desc.text = mediator.text_desc;
         clip.list.itemRendererType = ClanWarDefenderRenderer;
         clip.list.addDataListener("ListItemRenderer.EVENT_SELECT",mediator.action_select);
         clip.list.addDataListener("ListItemRenderer.EVENT_REMOVE",mediator.action_remove);
         clip.list.dataProvider = mediator.defenderListData;
         clip.button_close.signal_click.add(close);
         clip.list.layout = new VerticalLayout();
         (clip.list.layout as VerticalLayout).gap = 10;
         var _loc2_:int = 10;
         (clip.list.layout as VerticalLayout).paddingBottom = _loc2_;
         (clip.list.layout as VerticalLayout).paddingTop = _loc2_;
      }
   }
}
