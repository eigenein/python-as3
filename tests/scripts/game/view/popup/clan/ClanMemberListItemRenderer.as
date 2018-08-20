package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.info.ClanMemberListValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class ClanMemberListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanInfoPopupMemberListItemRendererClip;
      
      private var _signal_dismiss:Signal;
      
      private var _signal_editRole:Signal;
      
      private var _signal_profile:Signal;
      
      public function ClanMemberListItemRenderer()
      {
         _signal_dismiss = new Signal(ClanMemberListValueObject);
         _signal_editRole = new Signal(ClanMemberListValueObject);
         _signal_profile = new Signal(ClanMemberListValueObject);
         super();
      }
      
      override public function dispose() : void
      {
         unsubscribe();
         super.dispose();
      }
      
      public function get signal_dismiss() : Signal
      {
         return _signal_dismiss;
      }
      
      public function get signal_editRole() : Signal
      {
         return _signal_editRole;
      }
      
      public function get signal_profile() : Signal
      {
         return _signal_profile;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:* = null;
         unsubscribe();
         .super.data = param1;
         if(_data)
         {
            _loc2_ = _data as ClanMemberListValueObject;
            _loc2_.signal_updateRole.add(handler_updateRole);
            _loc2_.signal_updatePoints.add(handler_updatePoints);
         }
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:ClanMemberListValueObject = data as ClanMemberListValueObject;
         if(_loc1_)
         {
            clip.tf_nickname.text = _loc1_.nickname;
            clip.tf_role.text = _loc1_.roleString;
            clip.tf_points_daily.text = _loc1_.activityPoints.toString();
            clip.tf_points_dungeon.text = _loc1_.dungeonActivityPoints.toString();
            clip.portrait.setData(_loc1_.userInfo);
            clip.button_dismiss.graphics.visible = _loc1_.canDismiss;
            clip.button_edit.graphics.visible = _loc1_.canEdit;
            clip.button_profile.graphics.visible = _loc1_.showProfile;
            if(_loc1_.showProfile)
            {
               clip.layout_name.addChild(clip.button_profile.graphics);
            }
            else if(clip.button_profile.graphics.parent == clip.layout_name)
            {
               clip.layout_name.removeChild(clip.button_profile.graphics);
            }
            clip.button_profile.label = Translate.translate("UI_POPUP_USER_INFO_PROFILE");
            clip.tf_level.text = Translate.translateArgs("UI_COMMON_LEVEL",_loc1_.level);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanInfoPopupMemberListItemRendererClip,"clan_member_list_item_renderer");
         addChild(clip.graphics);
         clip.button_dismiss.signal_click.add(handler_dismissClick);
         clip.button_edit.signal_click.add(handler_editClick);
         clip.button_profile.signal_click.add(handler_profileClick);
      }
      
      private function unsubscribe() : void
      {
         var _loc1_:* = null;
         if(_data)
         {
            _loc1_ = _data as ClanMemberListValueObject;
            _loc1_.signal_updateRole.remove(handler_updateRole);
            _loc1_.signal_updatePoints.remove(handler_updatePoints);
         }
      }
      
      private function handler_dismissClick() : void
      {
         _signal_dismiss.dispatch(data as ClanMemberListValueObject);
      }
      
      private function handler_editClick() : void
      {
         _signal_editRole.dispatch(data as ClanMemberListValueObject);
      }
      
      private function handler_profileClick() : void
      {
         _signal_profile.dispatch(data as ClanMemberListValueObject);
      }
      
      private function handler_updateRole(param1:ClanMemberListValueObject) : void
      {
         clip.tf_role.text = param1.roleString;
      }
      
      private function handler_updatePoints(param1:ClanMemberListValueObject) : void
      {
         clip.tf_points_daily.text = param1.activityPoints.toString();
         clip.tf_points_dungeon.text = param1.dungeonActivityPoints.toString();
      }
   }
}
