package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class ClanEditRolesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanEditRolesPopupMediator;
      
      private var clip:ClanEditRolesPopupClip;
      
      public function ClanEditRolesPopup(param1:ClanEditRolesPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "clan_settings_edit_roles";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.rolesWasChanged.unsubscribe(handler_rolesWasChanged);
         mediator.rolesIsUpdating.unsubscribe(handler_rolesIsUpdating);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanEditRolesPopupClip,"dialog_clan_edit_roles");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.tf_header.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_ROLE_NAMES_TITLE");
         clip.tf_label_save_roles.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_ROLE_NAMES_SAVE");
         setupRole(clip.tf_label_role_owner,clip.tf_input_role_owner,mediator.defaultOwner,mediator.currentOwner);
         setupRole(clip.tf_label_role_officer,clip.tf_input_role_officer,mediator.defaultOfficer,mediator.currentOfficer);
         setupRole(clip.tf_label_role_member,clip.tf_input_role_member,mediator.defaultMember,mediator.currentMember);
         setupRole(clip.tf_label_role_warlord,clip.tf_input_role_warlord,mediator.defaultWarlord,mediator.currentWarlord);
         clip.button_save_roles.cost = mediator.changeRolesCost;
         clip.button_save_roles.signal_click.add(mediator.action_updateRoleNames);
         mediator.rolesWasChanged.onValue(handler_rolesWasChanged);
         mediator.rolesIsUpdating.signal_update.add(handler_rolesIsUpdating);
      }
      
      private function setupRole(param1:ClipLabel, param2:ClipInput, param3:String, param4:String) : void
      {
         param1.text = param3;
         param2.prompt = param3;
         param2.maxChars = mediator.maxChars;
         param2.text = param4;
         param2.addEventListener("change",handler_inputChanged);
         param2.addEventListener("focusOut",handler_focusOut);
      }
      
      private function handler_focusOut(param1:Event) : void
      {
         if(clip.tf_input_role_owner.text == mediator.defaultOwner)
         {
            clip.tf_input_role_owner.text = "";
         }
         if(clip.tf_input_role_officer.text == mediator.defaultOfficer)
         {
            clip.tf_input_role_officer.text = "";
         }
         if(clip.tf_input_role_member.text == mediator.defaultMember)
         {
            clip.tf_input_role_member.text = "";
         }
      }
      
      private function handler_inputChanged(param1:Event) : void
      {
         clip.tf_input_role_owner.text = mediator.verifyRoleName(clip.tf_input_role_owner.text);
         clip.tf_input_role_officer.text = mediator.verifyRoleName(clip.tf_input_role_officer.text);
         clip.tf_input_role_member.text = mediator.verifyRoleName(clip.tf_input_role_member.text);
         clip.tf_input_role_warlord.text = mediator.verifyRoleName(clip.tf_input_role_warlord.text);
         mediator.updateRoles(clip.tf_input_role_owner.text,clip.tf_input_role_officer.text,clip.tf_input_role_member.text,clip.tf_input_role_warlord.text);
      }
      
      private function handler_rolesIsUpdating(param1:Boolean) : void
      {
         clip.tf_label_is_updating.visible = true;
         clip.tf_label_save_roles.visible = false;
         clip.button_save_roles.graphics.visible = false;
         if(param1)
         {
            clip.tf_label_is_updating.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_IS_SAVING");
         }
         else
         {
            clip.tf_label_is_updating.text = Translate.translate("UI_DIALOG_CLAN_EDIT_SETTINGS_SAVED");
         }
      }
      
      private function handler_rolesWasChanged(param1:Boolean) : void
      {
         clip.tf_label_is_updating.visible = false;
         clip.tf_label_save_roles.visible = true;
         clip.button_save_roles.graphics.visible = true;
         var _loc2_:* = !!param1?1:0.3;
         clip.button_save_roles.graphics.alpha = _loc2_;
         clip.tf_label_save_roles.alpha = _loc2_;
         clip.button_save_roles.isEnabled = param1;
      }
   }
}
