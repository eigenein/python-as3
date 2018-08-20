package game.mechanics.clan_war.popup.plan.selectdefender
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.ClanWarSelectDefenderPopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarSelectDefenderPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ClanWarSelectDefenderPopupMediator;
      
      private var clip:ClanWarSelectDefenderPopupClip;
      
      public function ClanWarSelectDefenderPopup(param1:ClanWarSelectDefenderPopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = param1.create(ClanWarSelectDefenderPopupClip,"clan_war_defender_select_popup");
         addChild(clip.graphics);
         clip.tf_header.text = mediator.title;
         clip.tf_desc.text = Translate.translate("UI_CLAN_WAR_DEFENDER_SELECT_POPUP_TF_DESC");
         clip.button_close.signal_click.add(close);
         clip.list.itemRendererType = ClanWarSelectDefenderRenderer;
         clip.list.addDataListener("ListItemRenderer.EVENT_SELECT",mediator.action_select);
         clip.list.dataProvider = mediator.defenderListData;
         clip.list.layout = new TiledRowsLayout();
         (clip.list.layout as TiledRowsLayout).useSquareTiles = false;
         (clip.list.layout as TiledRowsLayout).gap = 8;
         var _loc2_:int = 8;
         (clip.list.layout as TiledRowsLayout).paddingBottom = _loc2_;
         (clip.list.layout as TiledRowsLayout).paddingTop = _loc2_;
         clip.button_members.label = Translate.translate("UI_CLAN_WAR_VIEW_ASSIGN_CHAMPIONS");
         clip.button_members.signal_click.add(mediator.action_assignChampions);
      }
   }
}
