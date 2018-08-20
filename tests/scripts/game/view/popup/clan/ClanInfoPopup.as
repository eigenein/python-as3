package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanInfoPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.clan.editicon.ClanIconClip;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.events.Event;
   
   public class ClanInfoPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanInfoPopupMediator;
      
      private var icon:ClanIconClip;
      
      private var clip:ClanInfoPopupClip;
      
      public function ClanInfoPopup(param1:ClanInfoPopupMediator = null)
      {
         super(param1);
         mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.signal_iconUpdated.remove(handler_iconUpdated);
         mediator.signal_titleUpdated.remove(handler_titleUpdated);
         removeEventListener("addedToStage",handler_addedToStage);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanInfoPopupClip,"dialog_clan_info");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.member_list.list.dataProvider = mediator.roster;
         clip.member_list.button_switch_activity_period.signal_click.add(mediator.action_switchActivityPeriod);
         clip.member_list.button_switch_activity_type.signal_click.add(mediator.action_switchActivityType);
         mediator.useSumForSorting.onValue(handler_useSumForSorting);
         mediator.useDungeonActivityForSorting.onValue(handler_useDungeonActivityForSorting);
         updateTitle();
         mediator.signal_titleUpdated.add(handler_titleUpdated);
         mediator.signal_memberCountUpdate.add(handler_updateMembersStr);
         handler_updateMembersStr();
         clip.button_log.signal_click.add(mediator.action_showLog);
         icon = AssetStorage.rsx.clan_icons.createFlagClip();
         var _loc1_:* = 0.7;
         icon.graphics.scaleY = _loc1_;
         icon.graphics.scaleX = _loc1_;
         clip.layout_banner.addChild(icon.graphics);
         handler_iconUpdated();
         mediator.signal_iconUpdated.add(handler_iconUpdated);
         clip.button_leave.signal_click.add(mediator.action_leave);
         clip.button_log.label = Translate.translate("UI_DIALOG_ARENA_LOGS");
         updateRoleButtons();
         clip.button_close.signal_click.add(close);
         clip.member_list.signal_dismiss.add(mediator.action_dismissMember);
         clip.member_list.signal_edit.add(mediator.action_editMember);
         clip.member_list.signal_profile.add(mediator.action_memberProfile);
         mediator.signal_roleUpdated.add(handler_roleUpdated);
         addEventListener("addedToStage",handler_addedToStage);
      }
      
      private function updateRoleButtons() : void
      {
         if(mediator.hasPermission_disband)
         {
            clip.button_leave.label = Translate.translate("UI_DIALOG_CLAN_INFO_DISBAND");
         }
         else
         {
            clip.button_leave.label = Translate.translate("UI_DIALOG_CLAN_INFO_LEAVE");
         }
      }
      
      private function updatePoints(param1:int) : void
      {
      }
      
      private function updateTitle() : void
      {
         clip.tf_guild_name.text = mediator.title;
      }
      
      private function handler_iconUpdated() : void
      {
         AssetStorage.rsx.clan_icons.setupFlag(icon,mediator.icon);
      }
      
      private function handler_titleUpdated() : void
      {
         updateTitle();
      }
      
      private function handler_roleUpdated() : void
      {
         clip.member_list.list.dataProvider = mediator.roster;
         updateRoleButtons();
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         mediator.action_addedToStage();
      }
      
      private function handler_updateMembersStr() : void
      {
         var _loc1_:String = ColorUtils.hexToRGBFormat(16711677) + mediator.memberCount + "/" + mediator.memberCountMax;
         clip.tf_members.text = Translate.translateArgs("UI_DIALOG_CLAN_INFO_MEMBERS",_loc1_);
      }
      
      private function handler_useSumForSorting(param1:Boolean) : void
      {
         clip.member_list.button_switch_activity_period.label = mediator.activityPeriodString;
      }
      
      private function handler_useDungeonActivityForSorting(param1:Boolean) : void
      {
         clip.member_list.button_switch_activity_type.label = mediator.activityTypeString;
      }
   }
}
