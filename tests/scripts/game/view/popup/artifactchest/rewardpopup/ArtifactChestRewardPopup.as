package game.view.popup.artifactchest.rewardpopup
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.model.user.inventory.InventoryItem;
   import game.sound.SoundSource;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.ClipBasedPopup;
   import org.osflash.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ArtifactChestRewardPopup extends ClipBasedPopup
   {
      
      private static var _sound:SoundSource;
      
      private static var _lootEpicSound:SoundSource;
      
      private static var _lootAverageSound:SoundSource;
       
      
      private var mediator:ArtifactChestRewardPopupMediator;
      
      private var clip:ArtifactChestRewardFullScreenPopupClipBase;
      
      private var rewardList:Vector.<InventoryItem>;
      
      private var dropLayer:ArtifactFlyingDropLayer;
      
      private var openingInProgress:Boolean = true;
      
      private var enterFrameCounter:int = 0;
      
      private var progressBarTween:Tween;
      
      private var _signal_close:Signal;
      
      private var soundTimoutId:int = -1;
      
      private var lootAverageSoundSoundTimoutId:int = -1;
      
      private var lootEpicSoundTimoutId:int = -1;
      
      public function ArtifactChestRewardPopup(param1:ArtifactChestRewardPopupMediator)
      {
         _signal_close = new Signal();
         super(param1);
         this.mediator = param1;
      }
      
      public static function get sound() : SoundSource
      {
         if(!_sound)
         {
            _sound = AssetStorage.sound.artifactChest;
         }
         return _sound;
      }
      
      public static function get lootEpicSound() : SoundSource
      {
         if(!_lootEpicSound)
         {
            _lootEpicSound = AssetStorage.sound.artifactChestLootEpic;
         }
         return _lootEpicSound;
      }
      
      public static function get lootAverageSound() : SoundSource
      {
         if(!_lootAverageSound)
         {
            _lootAverageSound = AssetStorage.sound.artifactChestLootAverage;
         }
         return _lootAverageSound;
      }
      
      override public function close() : void
      {
         if(openingInProgress)
         {
            return;
         }
         super.close();
         if(progressBarTween)
         {
            Starling.juggler.remove(progressBarTween);
            if(mediator.levelUpRewards && mediator.levelUpRewards.length)
            {
               mediator.action_showLevelUpReward();
            }
         }
         if(dropLayer)
         {
            dropLayer.dispose();
         }
         stopSound();
         clip.artefact_chest_animation.dispose();
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      override protected function initialize() : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc3_:int = 0;
         super.initialize();
         dropLayer = new ArtifactFlyingDropLayer();
         dropLayer.signal_item.add(handler_dropLayerItem);
         if(mediator.openAmount == 1)
         {
            clip = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestX1RewardFullScreenPopupClip,"artifact_chest_x1_reward_popup");
            mediator.registerSpecialOffer((clip as ArtifactChestX1RewardFullScreenPopupClip).layout_special_offer);
         }
         else if(mediator.openAmount == 10)
         {
            clip = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestX10RewardFullScreenPopupClip,"artifact_chest_x10_reward_popup");
         }
         else if(mediator.openAmount == 100)
         {
            _loc6_ = AssetStorage.rsx.dialog_artifact_chest.create(ArtifactChestX100RewardFullScreenPopupClip,"artifact_chest_x100_reward_popup");
            _loc6_.setMergedRewardList(mediator.mergedRewardsList);
            _loc6_.multi_reward_list_100.button_browes.signal_click.add(mediator.action_showX100Rewards);
            clip = _loc6_;
            dropLayer.simplifiedAnimation = true;
         }
         addChild(dropLayer.graphics);
         addChild(clip.graphics);
         clip.setReward(mediator.reward.rewardList.concat());
         clip.setBuyMoreCost(mediator);
         addChild(dropLayer.overlay);
         clip.hideDropInList();
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = clip.rewardList;
         for each(var _loc2_ in clip.rewardList)
         {
            _loc4_++;
            clip.dropItem(dropLayer,_loc2_,_loc4_);
         }
         clip.progressbar.tf_progress_value.graphics.visible = false;
         clip.progressbar.tf_level.text = mediator.artifactChest.level.toString();
         clip.button_close.graphics.visible = false;
         clip.cost_button_more.graphics.visible = false;
         clip.cost_button_more.graphics.touchable = false;
         clip.tf_open_pack.visible = false;
         clip.button_ok.graphics.visible = false;
         if(mediator.levelUpRewards && mediator.levelUpRewards.length)
         {
            clip.progressbar.minValue = 0;
            clip.progressbar.maxValue = mediator.artifactChestLevelExp - mediator.artifactChestPrevLevelExp;
            clip.progressbar.value = mediator.artifactChest.prevExperienceValue - mediator.artifactChestPrevLevelExp;
         }
         else
         {
            clip.progressbar.minValue = 0;
            clip.progressbar.maxValue = mediator.artifactChestNextLevelExp - mediator.artifactChestLevelExp;
            clip.progressbar.value = mediator.artifactChest.experience - mediator.artifactChestLevelExp;
            showHiddenElements();
         }
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_REWARD_MORE");
         clip.cost_button_more.signal_click.add(openNext);
         clip.button_close.signal_click.add(close);
         clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST");
         clip.button_ok.signal_click.add(close);
         clip.button_ok.label = Translate.translate("UI_POPUP_CHEST_REWARD_OK");
         clip.artefact_chest_animation.signal_completed.add(handler_animCompleted);
         addChildAt(clip.artefact_chest_animation.graphics,0);
         clip.artefact_chest_animation.playOnce();
         var _loc1_:* = 1.5;
         if(mediator.reOpen)
         {
            _loc3_ = 15;
            _loc1_ = Number(_loc1_ - _loc3_ / 60);
            clip.artefact_chest_animation.gotoAndPlay(_loc3_);
         }
         Starling.juggler.delayCall(handler_chestIsOpened,_loc1_);
         clip.showGuiWithDelay(_loc1_);
         clip.graphics.alpha = 0;
         clip.graphics.visible = true;
         if(mediator.levelUpRewards && mediator.levelUpRewards.length)
         {
            progressBarTween = new Tween(clip.progressbar,1,"easeOut");
            progressBarTween.delay = _loc1_ + 1.5 + 0.5;
            progressBarTween.onComplete = progressBarTween1Complete;
            progressBarTween.animate("value",clip.progressbar.maxValue);
            Starling.juggler.add(progressBarTween);
         }
         playSound();
         width = 1000;
         height = 650;
      }
      
      private function playSound() : void
      {
         if(mediator.openAmount == 10)
         {
            lootAverageSoundSoundTimoutId = setTimeout(function():void
            {
               lootAverageSound.play();
            },1200);
         }
         else if(mediator.openAmount == 100)
         {
            lootEpicSoundTimoutId = setTimeout(function():void
            {
               lootEpicSound.play();
            },1200);
         }
         soundTimoutId = setTimeout(function():void
         {
            sound.play();
         },0);
      }
      
      private function stopSound() : void
      {
         if(soundTimoutId != -1)
         {
            clearTimeout(soundTimoutId);
            soundTimoutId = -1;
         }
         if(lootAverageSoundSoundTimoutId != -1)
         {
            clearTimeout(lootAverageSoundSoundTimoutId);
            lootAverageSoundSoundTimoutId = -1;
         }
         if(lootEpicSoundTimoutId != -1)
         {
            clearTimeout(lootEpicSoundTimoutId);
            lootEpicSoundTimoutId = -1;
         }
         sound.stop();
         lootAverageSound.stop();
         lootEpicSound.stop();
      }
      
      private function openNext() : void
      {
         mediator.action_reOpen();
         clip.cost_button_more.graphics.touchable = false;
         clip.graphics.alpha = 1;
         clip.tweenHideGui(0.15);
      }
      
      private function showHiddenElements() : void
      {
         var _loc1_:* = !Tutorial.flags.hideChestReBuyButton;
         clip.button_close.graphics.visible = _loc1_;
         clip.tf_open_pack.visible = _loc1_;
         clip.cost_button_more.graphics.visible = _loc1_;
         clip.button_ok.graphics.visible = !_loc1_;
         clip.progressbar.tf_progress_value.graphics.visible = true;
      }
      
      private function handler_animCompleted() : void
      {
         clip.artefact_chest_animation.gotoAndPlay(207);
      }
      
      private function progressBarTween1Complete() : void
      {
         Starling.juggler.remove(progressBarTween);
         clip.progressbar.minValue = 0;
         clip.progressbar.maxValue = mediator.artifactChestNextLevelExp - mediator.artifactChestLevelExp;
         clip.progressbar.value = mediator.artifactChestNextLevelExp - mediator.artifactChestLevelExp;
         progressBarTween = new Tween(clip.progressbar,1,"easeOut");
         progressBarTween.delay = 0.1;
         progressBarTween.onComplete = progressBarTween2Complete;
         progressBarTween.animate("value",mediator.artifactChest.experience - mediator.artifactChestLevelExp);
         Starling.juggler.add(progressBarTween);
      }
      
      private function progressBarTween2Complete() : void
      {
         Starling.juggler.remove(progressBarTween);
         showHiddenElements();
         mediator.action_showLevelUpReward();
      }
      
      private function handler_dropLayerItem(param1:InventoryItem) : void
      {
         clip.showDropItem(param1);
      }
      
      private function handler_chestIsOpened() : void
      {
         openingInProgress = false;
         var _loc1_:* = !Tutorial.flags.hideChestReBuyButton;
         clip.cost_button_more.graphics.touchable = _loc1_;
      }
   }
}
