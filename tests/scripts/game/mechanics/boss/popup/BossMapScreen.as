package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.assets.RequestableAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.mediator.BossMapScreenMediator;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupTitle;
   import starling.core.Starling;
   
   public class BossMapScreen extends AsyncClipBasedPopupWithPreloader implements IEscClosable
   {
       
      
      private var mediator:BossMapScreenMediator;
      
      private var clip:BossMapScreenClip;
      
      private var popupTitle:PopupTitle;
      
      private var mapAsset:RsxGameAsset;
      
      private var mapIndex:int;
      
      private var mapClip:BossMapClip;
      
      private var mapProgressbar:ClipProgressBar;
      
      private var mapAssetProgress:AssetProgressProvider;
      
      private var _progressAsset:RequestableAsset;
      
      public function BossMapScreen(param1:BossMapScreenMediator)
      {
         super(param1,AssetStorage.rsx.dialog_boss);
         this.mediator = param1;
         stashParams.windowName = "bossMap";
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_boss,AssetStorage.rsx.boss_icons);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            clip.renderer_left.dispose();
            clip.renderer_center.dispose();
            clip.renderer_right.dispose();
         }
         mediator.mapProgress.mapClip.unsubscribe(handler_mapClip);
         mediator.mapProgress.assetProgress.unsubscribe(handler_mapAssetProgress);
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         width = Starling.current.stage.stageWidth;
         height = Starling.current.stage.stageHeight;
         clip = param1.create(BossMapScreenClip,"dialog_boss_screen_new");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         popupTitle = PopupTitle.create(mediator.locationName,clip.header_layout_container);
         clip.button_shop.initialize(Translate.translate("UI_DIALOG_BOSS_SHOP"),mediator.action_toShop);
         clip.renderer_left.mediator = mediator.getFrameRendererMediator(mediator.prevBoss);
         clip.renderer_left.signal_click.add(handler_arrowLeftClick);
         clip.renderer_center.mediator = mediator.getFrameRendererMediator(mediator.currentBoss);
         clip.renderer_right.mediator = mediator.getFrameRendererMediator(mediator.nextBoss);
         clip.renderer_right.signal_click.add(handler_arrowRightClick);
         clip.arrow_left.signal_click.add(handler_arrowLeftClick);
         clip.arrow_right.signal_click.add(handler_arrowRightClick);
         clip.renderer_left_marker.graphics.visible = false;
         clip.renderer_right_marker.graphics.visible = false;
         updateBossSelectorState();
         mediator.action_getBossData();
         mediator.signal_bossDataReceived.addOnce(updateState);
         mediator.mapProgress.mapClip.onValue(handler_mapClip);
         mediator.mapProgress.assetProgress.onValue(handler_mapAssetProgress);
      }
      
      private function updateState() : void
      {
         popupTitle.text = mediator.locationName;
         clip.tf_label_description.text = mediator.description;
         clip.renderer_left_marker.graphics.visible = mediator.prevBossMarker;
         clip.renderer_right_marker.graphics.visible = mediator.nextBossMarker;
      }
      
      private function updateBossSelectorState() : void
      {
         clip.renderer_left.setData(mediator.prevBoss);
         clip.renderer_center.setData(mediator.currentBoss);
         clip.renderer_right.setData(mediator.nextBoss);
      }
      
      private function handler_mapClip(param1:BossMapClip) : void
      {
         if(param1)
         {
            param1.graphics.y = -clip.container_map.graphics.y;
            clip.container_map.removeChildren();
            clip.container_map.addChild(param1.graphics);
            param1.signal_clickAttack.clear();
            param1.signal_clickRaid.clear();
            param1.signal_clickChestOpen.clear();
            param1.signal_clickAttack.add(mediator.action_attack);
            param1.signal_clickRaid.add(mediator.action_raid);
            param1.signal_clickChestOpen.add(mediator.action_open);
         }
      }
      
      private function handler_mapAssetProgress(param1:AssetProgressProvider) : void
      {
         if(param1)
         {
            if(!mapProgressbar)
            {
               mapProgressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
               mapProgressbar.graphics.x = int((clip.bg_preloader.graphics.width - mapProgressbar.graphics.width) / 2);
               mapProgressbar.graphics.y = int((clip.bg_preloader.graphics.height - mapProgressbar.graphics.height) / 2);
               addChild(mapProgressbar.graphics);
            }
            param1.signal_onProgress.add(handler_mapAssetProgressUpdated);
         }
         else if(this.mapAssetProgress)
         {
            this.mapAssetProgress.signal_onProgress.remove(handler_mapAssetProgressUpdated);
         }
         this.mapAssetProgress = param1;
      }
      
      private function handler_mapAssetProgressUpdated(param1:AssetProgressProvider) : void
      {
         if(mapProgressbar)
         {
            mapProgressbar.maxValue = param1.progressTotal;
            mapProgressbar.value = param1.progressCurrent;
            if(param1.completed)
            {
               mapProgressbar.graphics.removeFromParent(true);
               mapProgressbar = null;
            }
         }
      }
      
      private function handler_arrowRightClick() : void
      {
         clip.container_map.removeChildren();
         mediator.action_setNextBoss();
         updateBossSelectorState();
         updateState();
      }
      
      private function handler_arrowLeftClick() : void
      {
         clip.container_map.removeChildren();
         mediator.action_setPrevBoss();
         updateBossSelectorState();
         updateState();
      }
   }
}
