package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.popup.friends.socialquest.RewardItemClip;
   
   public class ExpeditionPopupPanelClip extends GuiClipNestedContainer
   {
       
      
      private var data:ExpeditionValueObject;
      
      public const tf_name:ClipLabel = new ClipLabel();
      
      public const tf_label_duration:ClipLabel = new ClipLabel();
      
      public const tf_duration:ClipLabel = new ClipLabel();
      
      public const item_reward:Vector.<RewardItemClip> = new Vector.<RewardItemClip>();
      
      public const layout_reward:ClipLayout = ClipLayout.horizontalRight(3,item_reward);
      
      public const tf_unlock_condition:ClipLabel = new ClipLabel();
      
      public const tf_label_power:ClipLabel = new ClipLabel(true);
      
      public const tf_power:ClipLabel = new ClipLabel(true);
      
      public const layout_power:ClipLayout = ClipLayout.horizontalLeft(2,tf_label_power,tf_power);
      
      public const button_farm:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_start:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const heroes:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public function ExpeditionPopupPanelClip()
      {
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
      }
      
      public function setData(param1:ExpeditionValueObject) : void
      {
         if(this.data)
         {
            unsubscribe();
         }
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
            graphics.visible = true;
         }
         else
         {
            graphics.visible = false;
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
         layout_power.graphics.visible = data.isReadyToStart;
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
      }
      
      protected function unsubscribe() : void
      {
         data.signal_timer.remove(handler_timer);
         data.signal_statusUpdate.remove(updateStatus);
         data.heroesAreLocked.unsubscribe(handler_heroesAreLocked);
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
            tf_duration.text = data.timeLeft;
            tf_label_duration.text = Translate.translate("UI_DIALOG_EXPEDITION_TIME_LEFT");
         }
         else if(_loc1_)
         {
            tf_duration.text = Translate.translate("UI_DIALOG_EXPEDITION_IS_OVER");
            tf_label_duration.text = "";
         }
         else
         {
            tf_duration.text = data.duration;
            tf_label_duration.text = Translate.translate("UI_DIALOG_EXPEDITION_DURATION");
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
