package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.hero.HeroArtifactListPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class HeroArtifactListPopup extends AsyncClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:HeroArtifactListPopupMediator;
      
      private var clip:HeroListDialogClip;
      
      private var list:List;
      
      private var slider:GameScrollBar;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function HeroArtifactListPopup(param1:HeroArtifactListPopupMediator)
      {
         super(param1,AssetStorage.rsx.artifact_icons);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(!asset.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         height = 500;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         if(assetProgress)
         {
            assetProgress.signal_onProgress.remove(handler_assetProgress);
         }
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_artifact_list();
         addChild(clip.graphics);
         PopupTitle.create(Translate.translate("UI_DIALOG_HERO_RUNE_LIST_TITLE"),clip.header_layout_container);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         slider = new GameScrollBar();
         slider.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(slider);
         clip.button_close.signal_click.add(close);
         list = new HeroList(slider,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.team_list_container.graphics.width;
         list.height = clip.team_list_container.graphics.height;
         (list.layout as TiledRowsLayout).paddingTop = 24;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.itemRendererType = HeroArtifactListItemRenderer;
         list.dataProvider = new ListCollection(mediator.data);
         clip.team_list_container.layoutGroup.addChild(list);
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_listRendererAdded(param1:Event, param2:HeroArtifactListItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:HeroArtifactListItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
      }
      
      private function handler_heroSelect(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_select(param1);
      }
   }
}
