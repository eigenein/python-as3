package game.view.popup.artifactstore
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.artifact.ArtifactDescription;
   import game.mediator.gui.popup.artifacts.PlayerHeroWithArtifactsVO;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroList;
   import starling.events.Event;
   
   public class ArtifactStorePopup extends AsyncClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:ArtifactStorePopupMediator;
      
      private var clip:ArtifactStorePopupClip;
      
      private var miniList:HeroPopupMiniHeroList;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function ArtifactStorePopup(param1:ArtifactStorePopupMediator)
      {
         super(param1,AssetStorage.rsx.artifact_graphics);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         mediator.signal_heroUpdated.remove(handler_heroUpdate);
         mediator.signal_heroArtifactUpgrade.remove(handler_heroArtifactUpgrde);
         mediator.signal_playerInventoryUpdate.remove(handler_playerInventoryUpdate);
         _loc1_ = 0;
         while(_loc1_ < clip.item.length)
         {
            clip.item[_loc1_].dispose();
            _loc1_++;
         }
         super.dispose();
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
         var _loc2_:int = 0;
         height = 500;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         if(assetProgress)
         {
            assetProgress.signal_onProgress.remove(handler_assetProgress);
         }
         mediator.signal_heroUpdated.add(handler_heroUpdate);
         mediator.signal_heroArtifactUpgrade.add(handler_heroArtifactUpgrde);
         mediator.signal_playerInventoryUpdate.add(handler_playerInventoryUpdate);
         clip = AssetStorage.rsx.artifact_graphics.create(ArtifactStorePopupClip,"dialog_artifact_store");
         addChild(clip.graphics);
         PopupTitle.create(Translate.translate("UI_DIALOG_ARTIFACT_STORE_TITLE"),clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_ARTIFACT_STORE_DESC");
         clip.btn_action.label = Translate.translate("UI_DIALOG_ARTIFACT_STORE_ACTION");
         clip.btn_action.signal_click.add(mediator.action_navigate_subscription);
         clip.tf_desc.visible = !mediator.playerHasSubscription;
         clip.btn_action.graphics.visible = !mediator.playerHasSubscription;
         _loc2_ = 0;
         while(_loc2_ < clip.item.length)
         {
            clip.item[_loc2_].mediator = mediator;
            _loc2_++;
         }
         createMiniList();
         update();
      }
      
      private function handler_heroArtifactUpgrde() : void
      {
         update();
      }
      
      private function handler_heroUpdate() : void
      {
         update();
      }
      
      private function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<ArtifactDescription> = mediator.storeArtifacts;
         _loc2_ = 0;
         while(_loc2_ < clip.item.length)
         {
            clip.item[_loc2_].setData(_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      private function createMiniList() : void
      {
         miniList = new HeroPopupMiniHeroList(clip.minilist_layout_container,clip.miniList_leftArrow,clip.miniList_rightArrow,7);
         miniList.dataProvider = mediator.miniHeroListDataProvider;
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
         miniList.addEventListener("change",handler_miniListSelectionChange);
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_miniListSelectionChange(param1:Event) : void
      {
         mediator.action_miniListSelectionUpdate(miniList.selectedItem as PlayerHeroWithArtifactsVO);
         miniList.selectedItem = mediator.miniHeroListSelectedItem;
      }
      
      private function handler_playerInventoryUpdate() : void
      {
         update();
      }
   }
}
