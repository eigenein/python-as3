package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   
   public class ExpeditionMapPopupPanelClip extends DataClipButton
   {
       
      
      private var data:ExpeditionValueObject;
      
      public var tf_status:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var tf_progress_timer:ClipLabel;
      
      public var flag_anim:GuiAnimation;
      
      public var icon_lock:ClipSprite;
      
      public var icon_power:ClipSprite;
      
      public var icon_sub:GuiClipNestedContainer;
      
      public var icon_vip:GuiClipNestedContainer;
      
      public var rarity:ExpeditionMapFlagRibbon;
      
      public var bg:ClipSprite;
      
      public var layout_power:ClipLayout;
      
      public function ExpeditionMapPopupPanelClip()
      {
         tf_status = new ClipLabel();
         tf_power = new ClipLabel(true);
         tf_progress_timer = new ClipLabel();
         flag_anim = new GuiAnimation();
         icon_lock = new ClipSprite();
         icon_power = new ClipSprite();
         icon_sub = new GuiClipNestedContainer();
         icon_vip = new GuiClipNestedContainer();
         rarity = new ExpeditionMapFlagRibbon();
         bg = new ClipSprite();
         layout_power = ClipLayout.horizontalMiddleCentered(2,icon_power,tf_power);
         super(ExpeditionValueObject);
      }
      
      public function dispose() : void
      {
         if(data)
         {
            unsubscribe();
            data = null;
         }
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
            if(param1.isFarmed)
            {
               stopAll();
               return;
            }
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
            stopAll();
         }
      }
      
      override protected function getClickData() : *
      {
         return data;
      }
      
      protected function updateStatus() : void
      {
         var _loc3_:int = 0;
         if(!data || data.isFarmed)
         {
            stopAll();
            return;
         }
         graphics.visible = true;
         var _loc1_:Boolean = data.isLocked;
         var _loc2_:Boolean = data.isInProgress;
         icon_lock.graphics.visible = _loc1_;
         icon_vip.graphics.visible = data.attribute_vip;
         icon_sub.graphics.visible = data.attribute_subscription;
         flag_anim.graphics.visible = !data.isReadyToFarm;
         if(data.isReadyToFarm)
         {
            _loc3_ = 1;
         }
         else if(data.isInProgress)
         {
            _loc3_ = 2;
         }
         else
         {
            _loc3_ = 3;
         }
         rarity.setRarity(data.rarity,_loc3_);
         handler_timer();
         layout_power.graphics.visible = data.isReadyToStart || data.isLocked;
         tf_progress_timer.graphics.visible = data.isReadyToFarm || data.isInProgress;
      }
      
      protected function unsubscribe() : void
      {
         data.signal_timer.remove(handler_timer);
         data.signal_statusUpdate.remove(updateStatus);
         data.heroesAreLocked.unsubscribe(handler_heroesAreLocked);
      }
      
      private function stopAll() : void
      {
         graphics.visible = false;
         rarity.setRarity(0,0);
      }
      
      private function handler_heroesAreLocked(param1:Boolean) : void
      {
      }
      
      private function handler_timer() : void
      {
         var _loc1_:Boolean = data.isReadyToFarm;
         icon_power.graphics.visible = !data.isInProgress;
         if(data.isInProgress)
         {
            tf_progress_timer.text = data.timeLeft;
            tf_status.text = Translate.translate("UI_EXPEDITION_FLAG_IN_PROGRESS");
         }
         else if(_loc1_)
         {
            tf_progress_timer.text = Translate.translate("UI_EXPEDITION_FLAG_FINISHED");
            tf_status.text = Translate.translate("UI_EXPEDITION_FLAG_COLLECT_REWARD");
         }
         else
         {
            tf_status.text = data.duration;
         }
      }
   }
}
