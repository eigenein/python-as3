package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mechanics.boss.mediator.CooldownRefillPopupMediator;
   import game.util.TimeFormatter;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.arena.ArenaCooldownAlertPopupClip;
   
   public class BossCooldownRefillPopup extends ClipBasedPopup
   {
       
      
      private var clip:ArenaCooldownAlertPopupClip;
      
      private var mediator:CooldownRefillPopupMediator;
      
      public function BossCooldownRefillPopup(param1:CooldownRefillPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "boss_skip_cooldown";
         GameTimer.instance.oneSecTimer.add(handler_gameTimer);
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_gameTimer);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_arena_cd_alert();
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_DIALOG_ARENA_COOLDOWN_ALERT");
         clip.cooldowns_panel.skip_cost.costData = mediator.cost_skipCooldown;
         clip.cooldowns_panel.btn_skip_cooldown.signal_click.add(mediator.action_skipCooldown);
         clip.button_close.signal_click.add(close);
         handler_gameTimer();
      }
      
      private function handler_gameTimer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Boolean = mediator.skippedCooldowns < 1 && mediator.attemptsCount > 0;
         if(clip.graphics)
         {
            _loc2_ = mediator.battleCooldown;
            clip.cooldowns_panel.tf_timer.text = TimeFormatter.toMS2(_loc2_);
         }
         if(!_loc1_)
         {
            close();
         }
      }
   }
}
