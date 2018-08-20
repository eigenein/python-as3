package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanPublicInfoPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.clan.editicon.ClanIconClip;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClanPublicInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanPublicInfoPopupMediator;
      
      private var icon:ClanIconClip;
      
      public function ClanPublicInfoPopup(param1:ClanPublicInfoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc2_:ClanPublicInfoPopupClip = AssetStorage.rsx.popup_theme.create(ClanPublicInfoPopupClip,"dialog_clan_info_public");
         addChild(_loc2_.graphics);
         width = _loc2_.dialog_frame.graphics.width;
         height = _loc2_.dialog_frame.graphics.height;
         _loc2_.button_close.signal_click.add(close);
         _loc2_.button_join.label = Translate.translate("UI_POPUP_CLAN_LIST_JOIN");
         _loc2_.button_join.signal_click.add(mediator.action_join);
         _loc2_.member_list.button_switch_activity_type.graphics.visible = false;
         _loc2_.member_list.button_switch_activity_period.graphics.visible = false;
         if(mediator.canJoin)
         {
            _loc2_.tf_not_enough_lvl.visible = false;
         }
         else
         {
            _loc2_.button_join.isEnabled = false;
            _loc2_.button_join.graphics.alpha = 0.5;
            _loc2_.tf_not_enough_lvl.text = mediator.canJoinMessage;
         }
         _loc2_.member_list.list.dataProvider = mediator.membersListCollection;
         _loc2_.tf_guild_name.text = mediator.title;
         _loc2_.tf_min_level.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_LEVEL") + ": " + ColorUtils.hexToRGBFormat(16711677) + mediator.minTeamLevel;
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         var _loc3_:* = 0.7;
         icon.graphics.scaleY = _loc3_;
         icon.graphics.scaleX = _loc3_;
         _loc2_.layout_banner.addChild(icon.graphics);
         AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.icon);
         var _loc1_:String = ColorUtils.hexToRGBFormat(16711677) + mediator.memberCount + "/" + mediator.memberCountMax;
         _loc2_.tf_members.text = Translate.translateArgs("UI_DIALOG_CLAN_INFO_MEMBERS",_loc1_);
         _loc2_.member_list.tf_label_points.text = Translate.translate("UI_DIALOG_CLAN_INFO_PERSON_ACTIVITY") + " " + mediator.activityPeriodString;
      }
   }
}
