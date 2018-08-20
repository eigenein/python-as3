package game.mechanics.clan_war.popup.war
{
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.ClanWarDefensePopupMediator;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarDefensePopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ClanWarDefensePopupMediator;
      
      private var clip:ClanWarDefensePopupClip;
      
      public function ClanWarDefensePopup(param1:ClanWarDefensePopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = param1.create(ClanWarDefensePopupClip,"popup_building_selected_defense");
         addChild(clip.graphics);
         clip.tf_header.text = mediator.text_header;
         clip.list.itemRendererType = ClanWarDefenseListItemRenderer;
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
