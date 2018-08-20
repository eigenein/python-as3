package game.view.popup.artifactchest
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.artifact.ArtifactChestDropItem;
   import game.data.storage.artifact.ArtifactDescription;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.artifactchest.reward.ArtifactChestArtifactRewardRenderer;
   import game.view.popup.artifactchest.reward.ArtifactChestRewardRenderer;
   import game.view.popup.chest.ChestPopupTitle;
   import game.view.popup.common.PopupReloadController;
   
   public class ArtifactChestPopup extends AsyncClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var mediator:ArtifactChestPopupMediator;
      
      private var clip:ArtifactChestPopupClip;
      
      private var popupTitle:ChestPopupTitle;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      private var artifactsTimer:Timer;
      
      private var itemsRenderers:Vector.<ArtifactChestRewardRenderer>;
      
      private var artifactsRenderers:Vector.<ArtifactChestArtifactRewardRenderer>;
      
      private var slot_chest:SpecialOfferViewSlot;
      
      private var slot_open_pack:SpecialOfferViewSlot;
      
      private var slot_open_pack100:SpecialOfferViewSlot;
      
      private var reloadController:PopupReloadController;
      
      public function ArtifactChestPopup(param1:ArtifactChestPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_artifact_chest);
         this.mediator = param1;
         reloadController = new PopupReloadController(this,param1);
      }
      
      override public function dispose() : void
      {
         reloadController.dispose();
         mediator.signal_chestExperienceChange.remove(updateProgress);
         mediator.signal_starmoneySpent.remove(updateX100);
         mediator.signal_artifactChestKeysUpdate.remove(updateX10);
         artifactsTimer.stop();
         artifactsTimer.removeEventListener("timer",handler_artifactsTimer);
         itemsRenderers.length = 0;
         artifactsRenderers.length = 0;
         if(slot_chest)
         {
            slot_chest.dispose();
         }
         if(slot_open_pack)
         {
            slot_open_pack.dispose();
         }
         if(slot_open_pack100)
         {
            slot_open_pack100.dispose();
         }
         super.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.ARTIFACT_CHEST;
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
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         if(_isDisposed)
         {
            return;
         }
         width = 1000;
         height = 640;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         clip = param1.create(ArtifactChestPopupClip,"artifact_chest_popup");
         addChild(clip.graphics);
         mediator.specialOfferHooks.registerArtifactChestPopupClip(clip);
         popupTitle = new ChestPopupTitle(Translate.translate("UI_DIALOG_ARTIFACT_CHEST"),clip.header_layout_container);
         popupTitle.minBgWidth = 550;
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_open_single.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_OPEN_SINGLE");
         clip.tf_open_pack_key.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_OPEN_PACK");
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_OPEN_PACK");
         clip.tf_open_pack100.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_OPEN_PACK100");
         clip.tf_drop.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_DROP");
         clip.tf_drop_pack1.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_DROP_PACK1");
         clip.tf_drop_pack2.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_DROP_PACK2");
         clip.tf_drop_pack3.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_DROP_PACK3");
         clip.cost_button_single.cost = mediator.openCostX1.outputDisplayFirst;
         clip.cost_button_pack_key.cost = mediator.openCostX10Free.outputDisplayFirst;
         clip.cost_button_pack.cost = mediator.openCostX10.outputDisplayFirst;
         clip.cost_button_pack100.cost = mediator.openCostX100.outputDisplayFirst;
         clip.cost_button_single.signal_click.add(handler_openChestSingle);
         clip.cost_button_pack_key.signal_click.add(handler_openChestPackKey);
         clip.cost_button_pack.signal_click.add(handler_openChestPack);
         clip.cost_button_pack100.signal_click.add(handler_openChestPack100);
         slot_chest = new SpecialOfferViewSlot(clip.anim_idle.graphics,mediator.specialOfferHooks.artifactChest);
         slot_open_pack = new SpecialOfferViewSlot(clip.cost_button_pack.graphics,mediator.specialOfferHooks.artifactChestOpenPack,clip.container,clip.container);
         slot_open_pack100 = new SpecialOfferViewSlot(clip.cost_button_pack100.graphics,mediator.specialOfferHooks.artifactChestOpenX100,clip.container,clip.container);
         var _loc5_:Vector.<ArtifactChestDropItem> = mediator.dropItems;
         artifactsRenderers = new Vector.<ArtifactChestArtifactRewardRenderer>();
         itemsRenderers = new Vector.<ArtifactChestRewardRenderer>();
         ArtifactChestRewardRenderer.mediator = mediator;
         ArtifactChestArtifactRewardRenderer.mediator = mediator;
         _loc3_ = 0;
         while(_loc3_ < 26)
         {
            if(_loc5_[_loc3_].outputDisplayFirst.item is ArtifactDescription)
            {
               _loc4_ = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestArtifactRewardRenderer,"artifact_chest_reward");
               _loc4_.setData(_loc5_[_loc3_]);
               clip.slot[_loc3_ + 1].container.addChild(_loc4_.graphics);
               artifactsRenderers.push(_loc4_);
            }
            else
            {
               _loc2_ = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestRewardRenderer,"artifact_chest_reward");
               _loc2_.setData(_loc5_[_loc3_]);
               clip.slot[_loc3_ + 1].container.addChild(_loc2_.graphics);
               itemsRenderers.push(_loc2_);
            }
            _loc3_++;
         }
         artifactsTimer = new Timer(1500,2147483647);
         artifactsTimer.addEventListener("timer",handler_artifactsTimer);
         artifactsTimer.start();
         updateProgress();
         updateX100();
         updateX10();
         mediator.signal_chestExperienceChange.add(handler_chestExperienceChange);
         mediator.signal_starmoneySpent.add(updateX100);
         mediator.signal_artifactChestKeysUpdate.add(updateX10);
      }
      
      private function updateProgress() : void
      {
         clip.tf_level.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_LEVEL") + " " + mediator.artifactChest.level.toString();
         clip.progressbar.minValue = 0;
         clip.progressbar.maxValue = mediator.artifactChestNextLevelExp - mediator.artifactChestLevelExp;
         clip.progressbar.value = mediator.artifactChest.experience - mediator.artifactChestLevelExp;
         clip.progressbar.tf_level.text = mediator.artifactChest.level.toString();
      }
      
      private function updateX100() : void
      {
         clip.cost_button_pack100.graphics.visible = mediator.x100Avaliable;
         clip.tf_open_pack100.visible = mediator.x100Avaliable;
      }
      
      private function updateX10() : void
      {
         var _loc1_:* = mediator.artifactChestKeysAmount < 10;
         clip.tf_open_single.visible = !!_loc1_?true:false;
         clip.tf_open_pack_key.visible = !!_loc1_?false:true;
         clip.cost_button_single.graphics.visible = !!_loc1_?true:false;
         clip.cost_button_pack_key.graphics.visible = !!_loc1_?false:true;
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_openChestPack() : void
      {
         mediator.action_open(10,false);
      }
      
      private function handler_openChestPackKey() : void
      {
         mediator.action_open(10,true);
      }
      
      private function handler_openChestPack100() : void
      {
         mediator.action_open(100,false);
      }
      
      private function handler_openChestSingle() : void
      {
         mediator.action_open(1,true);
      }
      
      protected function handler_artifactsTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         artifactsTimer.delay = 3000;
         _loc2_ = 0;
         while(_loc2_ < artifactsRenderers.length)
         {
            artifactsRenderers[_loc2_].changeImage(_loc2_ * 80 / 1000);
            _loc2_++;
         }
      }
      
      private function handler_chestExperienceChange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         updateProgress();
         _loc1_ = 0;
         while(_loc1_ < itemsRenderers.length)
         {
            itemsRenderers[_loc1_].updateLockState();
            _loc1_++;
         }
         _loc2_ = 0;
         while(_loc2_ < artifactsRenderers.length)
         {
            artifactsRenderers[_loc2_].updateLockState();
            _loc2_++;
         }
      }
   }
}
