package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanEditSettingsPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanEditSettingsPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanEditSettingsPopupMediator;
      
      private var clip:ClanEditSettingsPopupClip;
      
      public function ClanEditSettingsPopup(param1:ClanEditSettingsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "clan_settings";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.team_level.signal_change.remove(handler_levelChanged);
         mediator.levelWasChanged.unsubscribe(handler_levelWasChanged);
         mediator.levelIsUpdating.unsubscribe(handler_levelIsUpdating);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanEditSettingsPopupClip,"dialog_clan_edit_settings");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.tf_header.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_TITLE");
         clip.tf_label_max_level.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_LEVEL");
         clip.button_save_level.label = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_OK");
         clip.button_save_level.signal_click.add(handler_updateSettingsClick);
         clip.team_level.minValue = mediator.minLevel;
         clip.team_level.maxValue = mediator.maxLevel;
         clip.team_level.step = mediator.step;
         clip.team_level.value = mediator.value;
         clip.team_level.signal_change.add(handler_levelChanged);
         clip.button_roles.label = Translate.translate("UI_DIALOG_CLAN_INFO_ROLES");
         clip.button_roles.signal_click.add(mediator.action_edit_roles);
         clip.button_banner.label = Translate.translate("UI_DIALOG_CLAN_INFO_BANNER");
         clip.button_banner.graphics.visible = mediator.hasPermission_edit_banner;
         clip.button_banner.signal_click.add(mediator.action_editBanner);
         clip.button_name.label = Translate.translate("UI_DIALOG_CLAN_INFO_TITLE");
         clip.button_name.signal_click.add(mediator.action_edit_title);
         clip.black_list_label.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_SHOW_BLACK_LIST");
         clip.black_list_btn.signal_click.add(mediator.action_showBlackList);
         mediator.signal_roleUpdated.add(handler_roleUpdated);
         mediator.levelWasChanged.onValue(handler_levelWasChanged);
         mediator.levelIsUpdating.signal_update.add(handler_levelIsUpdating);
      }
      
      private function updateRoleButtons() : void
      {
         clip.button_name.graphics.visible = mediator.hasPermission_edit_title;
         clip.button_banner.graphics.visible = mediator.hasPermission_edit_banner;
      }
      
      private function handler_updateSettingsClick() : void
      {
         mediator.action_updateLevel(clip.team_level.value);
      }
      
      private function handler_levelIsUpdating(param1:Boolean) : void
      {
         clip.tf_label_level_is_updating.visible = true;
         clip.button_save_level.graphics.visible = false;
         if(param1)
         {
            clip.tf_label_level_is_updating.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_IS_SAVING");
         }
         else
         {
            clip.tf_label_level_is_updating.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_SAVED");
         }
      }
      
      private function handler_levelWasChanged(param1:Boolean) : void
      {
         clip.tf_label_level_is_updating.visible = false;
         clip.button_save_level.graphics.visible = true;
         clip.button_save_level.graphics.alpha = !!param1?1:0.3;
         clip.button_save_level.isEnabled = param1;
      }
      
      private function handler_levelChanged() : void
      {
         mediator.action_levelChanged(clip.team_level.value);
      }
      
      private function handler_roleUpdated() : void
      {
         updateRoleButtons();
      }
   }
}
