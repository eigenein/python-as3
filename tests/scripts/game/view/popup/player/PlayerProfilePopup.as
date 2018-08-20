package game.view.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.PlayerProfilePopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupTitle;
   
   public class PlayerProfilePopup extends ClipBasedPopup
   {
       
      
      private var mediator:PlayerProfilePopupMediator;
      
      private var clip:PlayerProfilePopupClip;
      
      private var title:PopupTitle;
      
      public function PlayerProfilePopup(param1:PlayerProfilePopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "persona_params";
         param1.signal_updateAvatar.add(handler_updateAvatar);
         param1.signal_updateNickname.add(handler_updateNickname);
      }
      
      override public function dispose() : void
      {
         mediator.signal_updateAvatar.remove(handler_updateAvatar);
         mediator.signal_updateNickname.remove(handler_updateNickname);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_player_profile();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.button_avatar.signal_click.add(mediator.action_changeAvatar);
         clip.button_avatar.label = Translate.translate("UI_DIALOG_PLAYER_PROFILE_CHANGE_AVATAR");
         clip.button_nickname.label = Translate.translate("UI_DIALOG_PLAYER_PROFILE_CHANGE_NICKNAME");
         clip.button_nickname.signal_click.add(mediator.action_changeNickname);
         clip.grp_team_level.tf_label.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_LABEL_TEAM_LEVEL");
         clip.grp_team_level.tf_number.text = mediator.teamLevel.toString();
         clip.grp_team_xp.tf_label.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_LABEL_TEAM_XP");
         if(mediator.maxTeamLevel)
         {
            clip.grp_team_xp.tf_number.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_TEAM_XP_MAX");
         }
         else
         {
            clip.grp_team_xp.tf_number.text = mediator.teamExp + "/" + mediator.teamExpNext;
         }
         clip.grp_id.tf_label.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_LABEL_ID");
         clip.grp_id.tf_number.text = mediator.id;
         clip.grp_hero_lvl.tf_label.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_LABEL_HERO_LVL");
         clip.grp_hero_lvl.tf_number.text = mediator.maxHeroLevel.toString();
         clip.tf_vip.text = mediator.vipLevelLabel;
         clip.button_server_list.label = Translate.translate("UI_DIALOG_PLAYER_PROFILE_CHANGE_SERVER");
         clip.button_server_list.signal_click.add(handler_serverList);
         clip.tf_label_server.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_YOUR_SERVER");
         clip.tf_server_name.text = mediator.serverName;
         clip.grp_tiime_zone.tf_label.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_TIME_ZONE");
         clip.grp_tiime_zone.tf_number.text = mediator.timeZoneString;
         clip.grp_tiime_zone.edit_button.signal_click.add(mediator.handler_editTimeZone);
         clip.grp_tiime_zone.edit_button.graphics.visible = mediator.timeZone != mediator.localTimeZone;
         handler_updateAvatar();
         title = PopupTitle.create(mediator.nickname,clip.header_layout_container);
      }
      
      private function handler_updateNickname() : void
      {
         title.text = mediator.nickname;
      }
      
      private function handler_updateAvatar() : void
      {
         clip.portrait.setData(mediator.userInfo);
      }
      
      private function handler_serverList() : void
      {
         mediator.action_changeServer();
      }
   }
}
