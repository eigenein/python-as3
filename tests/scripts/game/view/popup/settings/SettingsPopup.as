package game.view.popup.settings
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.settings.SettingsPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class SettingsPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private const clip:SettingsPopupClip = AssetStorage.rsx.popup_theme.create_dialog_settings();
      
      private var mediator:SettingsPopupMediator;
      
      public function SettingsPopup(param1:SettingsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         clip.button_close.signal_click.clear();
         var _loc3_:int = 0;
         var _loc2_:* = clip.volume_item;
         for each(var _loc1_ in clip.volume_item)
         {
            _loc1_.dispose();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_title.text = Translate.translate("UI_POPUP_SETTINGS_TITLE");
         clip.volume_item[0].mediator = mediator.soundsVolume;
         clip.volume_item[1].mediator = mediator.musicVolume;
         clip.volume_item[2].mediator = mediator.screenShake;
         clip.settings_item[0].mediator = mediator.showSkillDetails;
         clip.settings_item[1].mediator = mediator.showProfileToClanMembers;
         clip.settings_item[2].mediator = mediator.foulLanguageFilter;
         clip.layout_settings.height = NaN;
         clip.layout_settings.addChild(clip.volume_item[0].container);
         clip.layout_settings.addChild(clip.volume_item[1].container);
         clip.layout_settings.addChild(clip.volume_item[2].container);
         clip.layout_settings.addChild(clip.settings_item[0].container);
         clip.layout_settings.addChild(clip.settings_item[1].container);
         clip.layout_settings.addChild(clip.settings_item[2].container);
         clip.layout_settings.addChild(clip.button_blacklist.container);
         clip.settings_item[1].container.visible = mediator.socialProfileAvaliable;
         clip.layout_settings.validate();
         clip.bg.graphics.height = clip.layout_settings.y + clip.layout_settings.height + 12;
         clip.button_blacklist.initialize(Translate.translate("UI_POPUP_SETTINGS_BLACK_LIST_SHOW"),mediator.showBlackList);
      }
   }
}
