package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestRewardPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.sound.SoundSource;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import org.osflash.signals.Signal;
   import starling.core.Starling;
   
   public class TitanArtifactChestRewardPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
      
      private static var _sound:SoundSource;
       
      
      private var mediator:TitanArtifactChestRewardPopupMediator;
      
      private var clip:TitanArtifactChestRewardFullScreenPopupClipBase;
      
      private var rewardList:Vector.<InventoryItem>;
      
      private var dropLayer:ArtifactFlyingDropLayer;
      
      private var openingInProgress:Boolean = true;
      
      private var enterFrameCounter:int = 0;
      
      private var timer_reward:Timer;
      
      private var _signal_close:Signal;
      
      public function TitanArtifactChestRewardPopup(param1:TitanArtifactChestRewardPopupMediator)
      {
         timer_reward = new Timer(2300,1);
         _signal_close = new Signal();
         super(param1);
         this.mediator = param1;
      }
      
      public static function get sound() : SoundSource
      {
         if(!_sound)
         {
            _sound = AssetStorage.sound.titanArtifactChest;
         }
         return _sound;
      }
      
      override public function close() : void
      {
         if(openingInProgress)
         {
            return;
         }
         super.close();
         if(dropLayer)
         {
            dropLayer.dispose();
         }
         if(timer_reward)
         {
            timer_reward.stop();
         }
         sound.stop();
         clip.artifact_chest_animation.dispose();
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_ALTAR_REWARD;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         return _loc2_;
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
            clip = AssetStorage.rsx.titan_artifact_chest_graphics.create(TitanArtifactChestX1RewardFullScreenPopupClip,"titan_artifact_chest_x1_reward_popup");
         }
         else if(mediator.openAmount == 10)
         {
            clip = AssetStorage.rsx.titan_artifact_chest_graphics.create(TitanArtifactChestX10RewardFullScreenPopupClip,"titan_artifact_chest_x10_reward_popup");
         }
         else if(mediator.openAmount == 100)
         {
            _loc6_ = AssetStorage.rsx.titan_artifact_chest_graphics.create(TitanArtifactChestX100RewardFullScreenPopupClip,"titan_artifact_chest_x100_reward_popup");
            _loc6_.setMergedRewardList(mediator.mergedRewardsList);
            _loc6_.multi_reward_list_100.button_browes.signal_click.add(mediator.action_showX100Rewards);
            clip = _loc6_;
            dropLayer.simplifiedAnimation = true;
         }
         var _loc1_:* = 2;
         if(mediator.hasSpiritInReward)
         {
            _loc1_ = Number(_loc1_ + 1);
            clip.additionalStartDelay = 1;
         }
         addChild(dropLayer.graphics);
         addChild(clip.graphics);
         clip.setReward(mediator.rewardList);
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
         clip.button_close.graphics.visible = false;
         clip.cost_button_more.graphics.visible = false;
         clip.cost_button_more.graphics.touchable = false;
         clip.tf_open_pack.visible = false;
         clip.button_ok.graphics.visible = false;
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_REWARD_MORE");
         clip.cost_button_more.signal_click.add(openNext);
         clip.button_close.signal_click.add(close);
         clip.ribbon.tf_header.text = Translate.translate("UI_SPIRIT_VALLEY_POPUP_ALTAR");
         clip.button_ok.signal_click.add(close);
         clip.button_ok.label = Translate.translate("UI_POPUP_CHEST_REWARD_OK");
         clip.artifact_chest_animation.signal_completed.add(handler_animCompleted);
         addChildAt(clip.artifact_chest_animation.graphics,0);
         clip.artifact_chest_animation.playOnce();
         sound.play();
         if(mediator.reOpen)
         {
            _loc3_ = 15;
            _loc1_ = Number(_loc1_ - _loc3_ / 60);
            clip.artifact_chest_animation.gotoAndPlay(_loc3_);
         }
         Starling.juggler.delayCall(handler_chestIsOpened,_loc1_);
         clip.showGuiWithDelay(_loc1_);
         clip.graphics.alpha = 0;
         clip.graphics.visible = true;
         width = 1000;
         height = 600;
         timer_reward.start();
         timer_reward.addEventListener("timerComplete",reward_timer_complete);
      }
      
      private function openNext() : void
      {
         sound.stop();
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
         Tutorial.events.triggerEvent_titanArtifactChestOpenComplete();
      }
      
      protected function reward_timer_complete(param1:TimerEvent) : void
      {
         mediator.action_showSpiritReward();
      }
      
      private function handler_animCompleted() : void
      {
         clip.artifact_chest_animation.gotoAndPlay(436);
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
         showHiddenElements();
      }
   }
}
