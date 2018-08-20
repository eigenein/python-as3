package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.expedition.mediator.ExpeditionBriefingPopupMediator;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class ExpeditionBriefingPanelClip extends GuiClipNestedContainer
   {
       
      
      private var data:ExpeditionValueObject;
      
      private var mediator:ExpeditionBriefingPopupMediator;
      
      public var tf_label_rewards:ClipLabel;
      
      public const tf_name:ClipLabel = new ClipLabel();
      
      public const item_reward:Vector.<RewardItemClip> = new Vector.<RewardItemClip>();
      
      public const layout_reward:ClipLayout = ClipLayout.horizontalMiddleCentered(3,item_reward);
      
      public const button_farm:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_start:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const heroes:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public var tf_story:ClipLabel;
      
      public var layout_story:ClipLayout;
      
      public var tf_duration:ClipLabel;
      
      public var icon_time:ClipSprite;
      
      public var tf_label_duration:ClipLabel;
      
      public var layout_time:ClipLayout;
      
      public var layout_time_bg:ClipSprite;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var icon_power:ClipSprite;
      
      public var layout_power:ClipLayout;
      
      public var layout_power_bg:ClipSprite;
      
      public var tf_unlock_condition:ClipLabel;
      
      public var button_lock_info:ClipButtonLabeled;
      
      public var layout_state_locked:ClipLayout;
      
      public var tf_label_inProgress:ClipLabel;
      
      public var layout_state_inProgress:ClipLayout;
      
      public var layout_state_ready:ClipLayout;
      
      public var layout_state_farm_ready:ClipLayout;
      
      public var tf_duration_progress:ClipLabel;
      
      public var tf_label_duration_progress:ClipLabel;
      
      public var icon_time2:ClipSprite;
      
      public var layout_progress:ClipLayout;
      
      public var layout_progress_bg:ClipSprite;
      
      public var tf_title:ClipLabel;
      
      public var tf_story_location:ClipLabel;
      
      public var rarity:ExpeditionBriefingPopupRarityClip;
      
      public function ExpeditionBriefingPanelClip()
      {
         tf_label_rewards = new ClipLabel();
         tf_story = new ClipLabel();
         layout_story = ClipLayout.horizontalMiddleCentered(4,tf_story);
         tf_duration = new ClipLabel(true);
         icon_time = new ClipSprite();
         tf_label_duration = new ClipLabel(true);
         layout_time = ClipLayout.horizontalMiddleCentered(-4,tf_label_duration,icon_time,tf_duration);
         layout_time_bg = new ClipSprite();
         tf_label_power = new ClipLabel(true);
         tf_power = new ClipLabel(true);
         icon_power = new ClipSprite();
         layout_power = ClipLayout.horizontalMiddleCentered(2,tf_label_power,icon_power,tf_power);
         layout_power_bg = new ClipSprite();
         tf_unlock_condition = new ClipLabel();
         button_lock_info = new ClipButtonLabeled();
         layout_state_locked = ClipLayout.verticalMiddleCenter(4,tf_unlock_condition,button_lock_info);
         tf_label_inProgress = new ClipLabel();
         layout_state_inProgress = ClipLayout.none(tf_label_inProgress,heroes);
         layout_state_ready = ClipLayout.none(button_start);
         layout_state_farm_ready = ClipLayout.none(button_farm);
         tf_duration_progress = new ClipLabel(true);
         tf_label_duration_progress = new ClipLabel(true);
         icon_time2 = new ClipSprite();
         layout_progress = ClipLayout.horizontalMiddleCentered(4,tf_label_duration_progress,icon_time2,tf_duration_progress);
         layout_progress_bg = new ClipSprite();
         tf_title = new ClipLabel();
         tf_story_location = new ClipLabel();
         rarity = new ExpeditionBriefingPopupRarityClip();
         super();
      }
      
      public function dispose() : void
      {
         if(data)
         {
            unsubscribe();
            data = null;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_farm.initialize(Translate.translate("UI_DIALOG_SOCIAL_QUEST_FARM"),handler_buttonFarm);
         button_start.initialize(Translate.translate("UI_DIALOG_MISSION_START_GO"),handler_buttonStart);
         tf_label_power.text = Translate.translate("UI_DIALOG_EXPEDITION_HERO_POWER_REQUIREMENT");
         tf_label_rewards.text = Translate.translate("UI_DIALOG_MISSION_REWARDS");
         tf_label_inProgress.text = Translate.translate("UI_EXPEDITION_BRIEFING_PANEL_TF_LABEL_INPROGRESS");
         tf_label_duration.text = Translate.translate("UI_DIALOG_EXPEDITION_DURATION");
      }
      
      public function setData(param1:ExpeditionValueObject, param2:ExpeditionBriefingPopupMediator) : void
      {
         this.mediator = param2;
         this.data = param1;
         if(param1 != null)
         {
            tf_name.text = param1.name;
            tf_power.text = String(param1.power);
            param1.heroesAreLocked.onValue(handler_heroesAreLocked);
            updateStatus();
            param1.signal_statusUpdate.add(updateStatus);
            handler_timer();
            param1.signal_timer.add(handler_timer);
            if(param1.story)
            {
               tf_story.text = param1.story.desc_before;
               tf_title.text = param1.story.title;
               tf_story_location.text = param1.story.location;
            }
            rarity.setRarity(param1.rarity);
            param2.signal_unlockConditions.add(updateStatus);
         }
      }
      
      protected function updateStatus() : void
      {
         var _loc3_:int = 0;
         if(!data)
         {
            return;
         }
         var _loc2_:Boolean = data.isLocked;
         var _loc5_:Boolean = data.isInProgress;
         tf_unlock_condition.text = data.requirementString;
         tf_unlock_condition.graphics.visible = _loc2_;
         handler_timer();
         var _loc1_:Vector.<InventoryItem> = data.reward;
         var _loc4_:int = Math.min(item_reward.length,_loc1_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            item_reward[_loc3_].data = _loc1_[_loc3_];
            item_reward[_loc3_].graphics.visible = true;
            _loc3_++;
         }
         _loc4_ = item_reward.length;
         _loc3_ = _loc1_.length;
         while(_loc3_ < _loc4_)
         {
            item_reward[_loc3_].graphics.visible = false;
            _loc3_++;
         }
         layout_state_inProgress.graphics.visible = data.isInProgress;
         layout_state_locked.graphics.visible = data.isLocked;
         layout_state_ready.graphics.visible = data.isReadyToStart;
         layout_state_farm_ready.graphics.visible = data.isReadyToFarm;
         var _loc6_:* = data.isInProgress || data.isReadyToFarm;
         layout_progress.graphics.visible = _loc6_;
         layout_progress_bg.graphics.visible = _loc6_;
         _loc6_ = !data.isInProgress && !data.isReadyToFarm;
         layout_power.graphics.visible = _loc6_;
         layout_power_bg.graphics.visible = _loc6_;
         _loc6_ = !data.isInProgress && !data.isReadyToFarm;
         layout_time.graphics.visible = _loc6_;
         layout_time_bg.graphics.visible = _loc6_;
         if(data.isLocked)
         {
            if(data.isLockedByTeamLevel)
            {
               tf_unlock_condition.text = Translate.translateArgs("UI_EXPEDITION_BRIEFING_PANEL_TF_UNLOCK_CONDITION_LEVEL",data.teamLevel);
               button_lock_info.graphics.visible = false;
            }
            if(data.isLockedByVipLevel)
            {
               tf_unlock_condition.text = Translate.translateArgs("UI_EXPEDITION_BRIEFING_PANEL_TF_UNLOCK_CONDITION_VIP",data.vipLevel);
               button_lock_info.label = Translate.translate("UI_EXPEDITION_BRIEFING_PANEL_BUTTON_LOCK_VIP");
            }
            if(data.isLockedBySubscription)
            {
               tf_unlock_condition.text = Translate.translate("UI_EXPEDITION_BRIEFING_PANEL_TF_UNLOCK_CONDITION_SUBSCRIPTION");
               button_lock_info.label = Translate.translate("UI_EXPEDITION_BRIEFING_PANEL_BUTTON_LOCK_SUBSCRIPTION");
            }
         }
      }
      
      protected function unsubscribe() : void
      {
         data.signal_timer.remove(handler_timer);
         data.signal_statusUpdate.remove(updateStatus);
         data.heroesAreLocked.unsubscribe(handler_heroesAreLocked);
         mediator.signal_unlockConditions.remove(updateStatus);
      }
      
      private function handler_heroesAreLocked(param1:Boolean) : void
      {
         heroes.graphics.visible = param1;
         if(param1)
         {
            heroes.setTeam(data.heroes);
         }
      }
      
      private function handler_timer() : void
      {
         button_start.graphics.visible = data.isReadyToStart;
         var _loc1_:Boolean = data.isReadyToFarm;
         button_farm.graphics.visible = _loc1_;
         if(data.isInProgress)
         {
            var _loc2_:Boolean = true;
            layout_progress.graphics.visible = _loc2_;
            layout_progress_bg.graphics.visible = _loc2_;
            tf_label_duration_progress.text = Translate.translate("UI_DIALOG_EXPEDITION_TIME_LEFT");
            tf_duration_progress.text = data.timeLeft;
            icon_time2.graphics.visible = false;
         }
         else if(_loc1_)
         {
            _loc2_ = true;
            layout_progress.graphics.visible = _loc2_;
            layout_progress_bg.graphics.visible = _loc2_;
            tf_label_duration_progress.text = Translate.translate("UI_DIALOG_EXPEDITION_IS_OVER");
            icon_time2.graphics.visible = false;
            tf_duration_progress.text = "";
         }
         else
         {
            _loc2_ = false;
            layout_progress.graphics.visible = _loc2_;
            layout_progress_bg.graphics.visible = _loc2_;
            tf_duration.text = data.duration;
         }
      }
      
      private function handler_buttonStart() : void
      {
         if(data)
         {
            data.action_start();
         }
      }
      
      private function handler_buttonFarm() : void
      {
         if(data)
         {
            data.action_farm();
         }
      }
   }
}
