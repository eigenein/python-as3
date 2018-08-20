package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.assets.RequestableAsset;
   import game.assets.HeroRsxAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.mechanics.expedition.mediator.ExpeditionRewardPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ExpeditionRewardPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var asset_uiLoaded:Boolean;
      
      private var asset_storyLoaded:Boolean;
      
      private var mediator:ExpeditionRewardPopupMediator;
      
      private var clip:ExpeditionRewardPopupClip;
      
      private var storyAssetProgress:AssetProgressProvider;
      
      private var _progressAsset:RequestableAsset;
      
      private var dropLayer:ArtifactFlyingDropLayer;
      
      public function ExpeditionRewardPopup(param1:ExpeditionRewardPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_expedition);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_zeppelin,AssetStorage.rsx.dialog_expedition);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         super.initialize();
         if(mediator.expedition.storyDesc_unitId)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            _loc1_ = AssetStorage.hero.getById(mediator.expedition.storyDesc_unitId);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc1_,handler_storyAssetLoaded);
            storyAssetProgress = AssetStorage.instance.globalLoader.getAssetProgress(_loc1_);
            if(!storyAssetProgress.completed)
            {
               storyAssetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(storyAssetProgress);
            }
            else
            {
               asset_storyLoaded = true;
            }
         }
         else
         {
            asset_storyLoaded = true;
         }
         if(!asset.completed)
         {
            if(!progressbar)
            {
               progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
               addChild(progressbar.graphics);
            }
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
               asset_uiLoaded = true;
            }
         }
         if(asset_uiLoaded && asset_storyLoaded)
         {
            _onBothAssetsLoaded();
         }
      }
      
      override protected function handler_assetLoaded(param1:RequestableAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         if(!progressbar)
         {
         }
         onAssetLoaded(this.asset);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         asset_uiLoaded = true;
         if(asset_uiLoaded && asset_storyLoaded)
         {
            _onBothAssetsLoaded();
         }
      }
      
      private function handler_storyAssetLoaded(param1:HeroRsxAsset) : void
      {
         asset_storyLoaded = true;
         if(asset_uiLoaded && asset_storyLoaded)
         {
            _onBothAssetsLoaded();
         }
      }
      
      override protected function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(progressbar)
         {
            _loc3_ = 0;
            _loc2_ = 0;
            if(assetProgress)
            {
               _loc3_ = _loc3_ + assetProgress.progressTotal;
               _loc2_ = _loc2_ + assetProgress.progressCurrent;
            }
            if(storyAssetProgress)
            {
               _loc3_ = _loc3_ + storyAssetProgress.progressTotal;
               _loc2_ = _loc2_ + storyAssetProgress.progressTotal;
            }
            progressbar.maxValue = _loc3_;
            progressbar.value = _loc2_;
         }
      }
      
      private function _onBothAssetsLoaded() : void
      {
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         dropLayer = new ArtifactFlyingDropLayer();
         dropLayer.signal_item.add(handler_dropLayerItem);
         dropLayer.baseParabolaHeight = 100;
         clip = AssetStorage.rsx.dialog_expedition.create(ExpeditionRewardPopupClip,"popup_expedition_reward");
         addChild(clip.graphics);
         addChild(dropLayer.graphics);
         addChild(dropLayer.overlay);
         width = clip.layout_rewards.width;
         height = clip.layout_rewards.height;
         clip.button_ok.signal_click.add(close);
         clip.scene.start(mediator.expedition);
         clip.scene.signal_end.add(handler_scene_end);
         clip.scene.signal_death_start.add(handler_scene_death_start);
         clip.layout_rewards.graphics.visible = false;
         clip.tf_title.text = mediator.expedition.name;
         clip.rarity.setRarity(mediator.expedition.rarity);
         if(mediator.expedition.story)
         {
            clip.tf_story.text = mediator.expedition.story.desc_after;
         }
         clip.tf_label_reward.text = Translate.translate("UI_POPUP_QUEST_REWARD_LABEL");
         clip.button_ok.label = Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL");
         clip.button_ok.signal_click.add(close);
         clip.setRewardList(mediator.expedition.reward);
         clip.tf_header.text = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
         AssetStorage.sound.dailyBonus.play();
      }
      
      private function handler_dropLayerItem(param1:InventoryItem) : void
      {
         clip.showDropItem(param1);
      }
      
      protected function handler_scene_death_start() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<InventoryItem> = mediator.expedition.reward;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc1_ in _loc3_)
         {
            _loc2_++;
            clip.dropItem(dropLayer,_loc1_,_loc2_);
         }
      }
      
      protected function handler_scene_end() : void
      {
         clip.layout_rewards.graphics.visible = true;
         clip.layout_rewards.graphics.alpha = 0;
         var _loc1_:Tween = new Tween(clip.layout_rewards.graphics,0.5);
         _loc1_.animate("alpha",1);
         Starling.juggler.add(_loc1_);
      }
   }
}
