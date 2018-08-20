package game.mediator.gui.popup.settings
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.social.GMRSocialAdapter;
   import com.progrestar.common.social.SocialAdapter;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.blasklist.BlackListPopUpClipMediator;
   import game.view.popup.settings.SettingsPopup;
   
   public class SettingsPopupMediator extends PopupMediator
   {
       
      
      public const soundsVolume:SettingVolumeSliderMediator = new SettingVolumeSliderMediator(GameModel.instance.player.settings.soundsVolume,GameModel.instance.player.settings.playSounds,Translate.translate("UI_POPUP_SETTINGS_SOUNDS_VOLUME"),0,1,0.01);
      
      public const musicVolume:SettingVolumeSliderMediator = new SettingVolumeSliderMediator(GameModel.instance.player.settings.musicVolume,GameModel.instance.player.settings.playMusic,Translate.translate("UI_POPUP_SETTINGS_MUSIC_VOLUME"),0,1,0.01);
      
      public const screenShake:SettingSliderMediator = new SettingSliderMediator(GameModel.instance.player.settings.screenShake,Translate.translate("UI_POPUP_SETTINGS_SCREEN_SHAKE"),0,1,0.01);
      
      public const showSkillDetails:SettingToggleButtonMediator = new SettingToggleButtonMediator(GameModel.instance.player.settings.showSkillDetails,Translate.translate("UI_POPUP_SETTINGS_SKILL_DETAILS"));
      
      public const showProfileToClanMembers:SettingToggleButtonMediator = new SettingToggleButtonMediator(GameModel.instance.player.settings.showProfileToClanMembers,Translate.translate("UI_POPUP_SETTINGS_SKILL_DETAILS_SHOW_PROFILE"));
      
      public const foulLanguageFilter:SettingToggleButtonMediator = new SettingToggleButtonMediator(GameModel.instance.player.settings.foulLanguageFilter,Translate.translate("UI_POPUP_SETTINGS_FOUL_LANGUAGE_FILTER"));
      
      public function SettingsPopupMediator(param1:Player)
      {
         super(param1);
      }
      
      override protected function dispose() : void
      {
         soundsVolume.saveAndDispose();
         musicVolume.saveAndDispose();
         screenShake.saveAndDispose();
         super.dispose();
      }
      
      public function get socialProfileAvaliable() : Boolean
      {
         return !(SocialAdapter.instance is GMRSocialAdapter);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SettingsPopup(this);
         return new SettingsPopup(this);
      }
      
      public function showBlackList() : void
      {
         var _loc1_:BlackListPopUpClipMediator = new BlackListPopUpClipMediator(player);
         _loc1_.open(_popup.stashParams);
      }
   }
}
