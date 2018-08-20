package game.view.popup.threeboxes.reward
{
   import com.progrestar.common.lang.Translate;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.chest.SoundGuiAnimation;
   import game.view.popup.chest.reward.ChestRewardFullscreenPopupClip;
   import game.view.popup.chest.reward.ChestRewardPopupClipMulti;
   import game.view.popup.chest.reward.ChestRewardPopupRenderer;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   import idv.cjcat.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class LootBoxRewardPopup extends ClipBasedPopup
   {
       
      
      private var mediator:LootBoxRewardPopupMediator;
      
      private var clip:ChestRewardFullscreenPopupClip;
      
      private var chest_animation:SoundGuiAnimation;
      
      private var timer:Timer;
      
      private var timer_hero:Timer;
      
      private var enterFrameCounter:int = 0;
      
      private var _signal_close:Signal;
      
      public function LootBoxRewardPopup(param1:LootBoxRewardPopupMediator)
      {
         timer = new Timer(1400,1);
         timer_hero = new Timer(1400,1);
         _signal_close = new Signal();
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "loot_box_reward";
      }
      
      override public function close() : void
      {
         if(!timer.running)
         {
            super.close();
            if(timer)
            {
               timer.stop();
            }
            if(timer_hero)
            {
               timer_hero.stop();
            }
            HeroRewardPopupHandler.instance.release();
         }
      }
      
      private function get vo() : LootBoxRewardVO
      {
         return mediator.reward;
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChestRewardFullscreenPopupClip,"loot_box_reward_popup");
         addChild(clip.graphics);
         if(!vo.pack)
         {
            clip.reward_item.setData(vo.reward.rewardList[0]);
            clip.tf_item_name.text = vo.reward.rewardList[0].name;
            clip.cost_button_more.cost = vo.box.x1Cost.outputDisplay[0];
            clip.multi_reward_list.graphics.visible = false;
            clip.tf_label_item_name_multi.visible = false;
            clip.tf_label_item_name.text = Translate.translate("UI_POPUP_CHEST_REWARD");
         }
         else
         {
            clip.tf_label_item_name_multi.text = Translate.translate("UI_POPUP_CHEST_REWARD");
            clip.tf_label_item_name.graphics.visible = false;
            clip.tf_item_name.graphics.visible = false;
            clip.reward_item.graphics.visible = false;
            _loc2_ = clip.multi_reward_list;
            _loc3_ = vo.reward.rewardList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc1_ = _loc2_["reward_item_" + (_loc5_ + 1)] as ChestRewardPopupRenderer;
               if(_loc1_)
               {
                  _loc1_.setData(vo.reward.rewardList[_loc5_]);
               }
               _loc5_++;
            }
            clip.cost_button_more.cost = vo.box.x10Cost.outputDisplay[0];
         }
         clip.tf_open_pack.text = Translate.translate("UI_POPUP_CHEST_REWARD_MORE");
         clip.cost_button_more.signal_click.add(closeAndOpenNext);
         clip.button_close.signal_click.add(close);
         var _loc4_:RewardDialogRibbonHeader = AssetStorage.rsx.popup_theme.create(RewardDialogRibbonHeader,"ribbon_header");
         _loc4_.tf_header.text = Translate.translate("LOOT_BOX_" + vo.box.id.toUpperCase());
         clip.placeholder_ribbon.container.addChild(_loc4_.graphics);
         chest_animation = AssetStorage.rsx.easter_graphics.create(SoundGuiAnimation,vo.box.id + "_animation");
         clip.placeholder_chest.container.addChild(chest_animation.graphics);
         clip.button_ok.signal_click.add(close);
         clip.button_ok.label = Translate.translate("UI_POPUP_CHEST_REWARD_OK");
         var _loc6_:* = !Tutorial.flags.hideChestReBuyButton;
         clip.button_close.graphics.visible = _loc6_;
         clip.cost_button_more.graphics.visible = _loc6_;
         clip.tf_open_pack.visible = _loc6_;
         clip.button_ok.graphics.visible = !_loc6_;
         chest_animation.signal_completed.add(handler_animCompleted);
         addChildAt(clip.placeholder_chest.container,0);
         if(vo.reward.hasShardedHeroes || vo.reward.hasHeroes)
         {
            timer_hero.start();
            timer_hero.addEventListener("timerComplete",hero_timer_complete);
         }
         clip.graphics.visible = false;
         chest_animation.playOnce();
         timer.addEventListener("timerComplete",timer_complete);
         timer.start();
         width = 1000;
         height = 650;
      }
      
      private function closeAndOpenNext() : void
      {
         mediator.action_reBuy();
      }
      
      private function handler_animCompleted() : void
      {
         chest_animation.gotoAndPlay(207);
      }
      
      protected function timer_complete(param1:TimerEvent) : void
      {
         var _loc2_:Tween = new Tween(clip.graphics,0.5);
         _loc2_.animate("alpha",1);
         Starling.juggler.add(_loc2_);
         clip.graphics.alpha = 0;
         clip.graphics.visible = true;
      }
      
      protected function hero_timer_complete(param1:TimerEvent) : void
      {
         HeroRewardPopupHandler.instance.release();
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         removeEventListener("addedToStage",handler_addedToStage);
         if(vo.pack)
         {
            _loc3_ = clip.multi_reward_list;
            _loc4_ = vo.reward.rewardList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = _loc3_["reward_item_" + (_loc5_ + 1)] as ChestRewardPopupRenderer;
               if(_loc2_)
               {
                  animate(_loc2_,_loc5_);
               }
               _loc5_++;
            }
         }
      }
      
      public function animate(param1:ChestRewardPopupRenderer, param2:int) : void
      {
         var _loc5_:DisplayObject = param1.graphics;
         var _loc3_:Number = _loc5_.x;
         var _loc4_:Number = _loc5_.y;
         _loc5_.x = _loc5_.x + 0.25 * _loc5_.width;
         _loc5_.y = _loc5_.y + 0.25 * _loc5_.height;
         _loc5_.alpha = 0;
         var _loc6_:* = 0.5;
         _loc5_.scaleY = _loc6_;
         _loc5_.scaleX = _loc6_;
         Starling.juggler.tween(_loc5_,0.5,{
            "transition":"easeOut",
            "delay":0.1 + param2 * 0.25,
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "x":_loc3_,
            "y":_loc4_
         });
      }
   }
}
