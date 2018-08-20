package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.clan.ClanEnterCooldownPopupMediator;
   import game.model.GameModel;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanEnterCooldownPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanEnterCooldownPopupMediator;
      
      private var clip:ClanEnterCooldownPopupClip;
      
      public function ClanEnterCooldownPopup(param1:ClanEnterCooldownPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanEnterCooldownPopupClip,"popup_clan_cd_alert");
         addChild(clip.graphics);
         clip.tf_message.text = Translate.translateArgs("UI_CLAN_REENTER_COOLDOWN_MSG",Translate.genderTriggerString(GameModel.instance.context.platformFacade.user.male));
         clip.tf_header.text = Translate.translate("UI_CLAN_REENTER_COOLDOWN_TITLE");
         clip.cooldowns_panel.tf_timer_caption.text = Translate.translate("UI_CLAN_REENTER_COOLDOWN_TIMER");
         clip.bg.graphics.height = clip.layout_main.height + 20;
         clip.cooldowns_panel.skip_cost.costData = mediator.skipCost;
         GameTimer.instance.oneSecTimer.add(handler_timer);
         handler_timer();
         clip.cooldowns_panel.btn_skip_cooldown.signal_click.add(mediator.action_skipCooldown);
         clip.button_close.signal_click.add(close);
      }
      
      private function handler_timer() : void
      {
         if(mediator.canAutoClose)
         {
            close();
         }
         else
         {
            clip.cooldowns_panel.tf_timer.text = mediator.timeLeft;
         }
      }
   }
}
