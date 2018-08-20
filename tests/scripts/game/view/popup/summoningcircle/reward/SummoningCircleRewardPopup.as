package game.view.popup.summoningcircle.reward
{
   import com.progrestar.common.lang.Translate;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import org.osflash.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class SummoningCircleRewardPopup extends AsyncClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var mediator:SummoningCircleRewardPopupMediator;
      
      private var clip:SummoningCircleRewardFullscreenPopupClip;
      
      private var _signal_close:Signal;
      
      private var timer:Timer;
      
      private var timer_titan:Timer;
      
      private var enterFrameCounter:int = 0;
      
      public function SummoningCircleRewardPopup(param1:SummoningCircleRewardPopupMediator)
      {
         _signal_close = new Signal();
         timer = new Timer(1900,1);
         timer_titan = new Timer(1900,1);
         super(param1,AssetStorage.rsx.clan_screen);
         this.mediator = param1;
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
            if(timer_titan)
            {
               timer_titan.stop();
            }
            HeroRewardPopupHandler.instance.release();
         }
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.REWARD_CLAN_SUMMONING_CIRCLE;
      }
      
      public function get signal_close() : Signal
      {
         return _signal_close;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc10_:int = 0;
         var _loc7_:Vector.<InventoryItem> = mediator.rewardList;
         var _loc9_:String = "summon_circle_reward_popup";
         if(_loc7_.length == 10)
         {
            _loc9_ = "summon_circle_reward10_popup";
         }
         else if(_loc7_.length > 10)
         {
            _loc9_ = "summon_circle_reward50_popup";
         }
         clip = AssetStorage.rsx.clan_screen.create(SummoningCircleRewardFullscreenPopupClip,_loc9_);
         addChild(clip.graphics);
         if(!mediator.paid)
         {
            clip.cost_button_more.cost = mediator.openFreeCost;
            clip.tf_bonus.visible = false;
            clip.reward_bonus.graphics.visible = false;
            clip.bonus_shadow.graphics.visible = false;
            clip.button_ok.graphics.y = clip.button_ok.graphics.y - 50;
            clip.cost_button_more.graphics.y = clip.cost_button_more.graphics.y - 50;
            clip.tf_open_pack.y = clip.tf_open_pack.y - 50;
         }
         else
         {
            if(mediator.amount == 1)
            {
               clip.cost_button_more.cost = mediator.openPaidCost;
            }
            else
            {
               clip.cost_button_more.cost = mediator.openPaidX10Cost;
            }
            clip.tf_bonus.text = Translate.translate("UI_DIALOG_SUMMONING_CIRCLE_BONUS");
            clip.reward_bonus.setData(mediator.bonusReward);
         }
         if(_loc7_.length == 1)
         {
            _loc2_ = mediator.rewardList[0];
            clip.reward_item.setData(_loc2_);
            clip.tf_item_name.text = _loc2_.name;
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
            if(_loc7_.length <= 10)
            {
               _loc5_ = clip.multi_reward_list;
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc4_ = _loc5_.reward_item_[_loc8_];
                  if(_loc4_)
                  {
                     _loc4_.setData(_loc7_[_loc8_]);
                  }
                  _loc8_++;
               }
            }
            else
            {
               _loc6_ = clip.multi_reward_extended_list;
               _loc6_.tf_reward_title.text = Translate.translate("UI_POPUP_CHEST_REWARD");
               _loc6_.button_browes.signal_click.add(mediator.action_showExtendedRewardsPopup);
               _loc3_ = mediator.mergedRewardsList;
               _loc10_ = 0;
               while(_loc10_ < 10)
               {
                  _loc4_ = _loc6_.reward_item_[_loc10_];
                  if(_loc4_)
                  {
                     _loc4_.setData(_loc3_[_loc10_]);
                  }
                  _loc10_++;
               }
            }
         }
         clip.tf_open_pack.text = Translate.translate("UI_POPUP_SUMMONING_CIRCLE_REWARD_MORE");
         clip.cost_button_more.signal_click.add(closeAndOpenNext);
         clip.button_close.signal_click.add(close);
         clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_SUMMONING_CIRCLE");
         clip.button_ok.signal_click.add(close);
         clip.button_ok.label = Translate.translate("UI_POPUP_CHEST_REWARD_OK");
         var _loc11_:* = !Tutorial.flags.hideChestReBuyButton;
         clip.button_close.graphics.visible = _loc11_;
         clip.cost_button_more.graphics.visible = _loc11_;
         clip.tf_open_pack.visible = _loc11_;
         clip.button_ok.graphics.visible = !_loc11_;
         clip.ball_animation.signal_completed.add(handler_animCompleted);
         addChildAt(clip.ball_animation.graphics,0);
         if(mediator.reward.hasShardedTitans || mediator.reward.hasTitans)
         {
            timer_titan.start();
            timer_titan.addEventListener("timerComplete",hero_timer_complete);
         }
         clip.graphics.visible = false;
         clip.ball_animation.playOnce();
         timer.addEventListener("timerComplete",timer_complete);
         timer.start();
         width = 1000;
         height = 650;
      }
      
      private function closeAndOpenNext() : void
      {
         mediator.action_reSummon();
      }
      
      private function handler_animCompleted() : void
      {
         clip.ball_animation.gotoAndPlay(220);
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
         if(mediator.rewardList.length > 1)
         {
            _loc3_ = clip.multi_reward_list;
            _loc4_ = mediator.rewardList.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc2_ = _loc3_["reward_item_" + (_loc5_ + 1)] as InventoryItemRenderer;
               if(_loc2_)
               {
                  animate(_loc2_,_loc5_);
               }
               _loc5_++;
            }
         }
      }
      
      public function animate(param1:InventoryItemRenderer, param2:int) : void
      {
         var _loc5_:DisplayObject = param1.graphics;
         var _loc3_:Number = _loc5_.x;
         var _loc4_:Number = _loc5_.y;
         _loc5_.x = _loc5_.x + 0.25 * _loc5_.width;
         _loc5_.y = _loc5_.y + 0.25 * _loc5_.height;
         _loc5_.alpha = 0;
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
