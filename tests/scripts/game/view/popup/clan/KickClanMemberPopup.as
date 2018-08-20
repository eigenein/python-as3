package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanMemberListPrivateValueObject;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.view.popup.PromptPopup;
   import game.view.popup.message.MessagePopupClip;
   
   public class KickClanMemberPopup extends PromptPopup
   {
       
      
      private var _kickClip:KickClanMemberPopupClip;
      
      public function KickClanMemberPopup(param1:ClanMemberListPrivateValueObject, param2:ClanPrivateInfoValueObject)
      {
         var _loc3_:String = Translate.translateArgs("UI_DIALOG_CLAN_INFO_DISMISS_PROMPT",param1.nickname);
         if(param2.clanWarLeagueId == 1 && !param2.serverTimeInFreeClanChangeInterval)
         {
            _loc3_ = _loc3_ + ("\n\n" + Translate.translate("UI_DIALOG_CLAN_INFO_DISMISS_GOLD_LEAGUE"));
         }
         super(_loc3_,Translate.translateArgs("UI_DIALOG_CLAN_INFO_DISMISS_PROMPT_TITLE",param1.nickname),Translate.translate("UI_POPUP_CLAN_DISMISS_YES"),Translate.translate("UI_POPUP_CLAN_DISMISS_NO"));
         data = param1;
      }
      
      public function get doAddToBlackList() : Boolean
      {
         return _kickClip.check_box.isSelected;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _kickClip.button_close.signal_click.add(handler_close);
         _kickClip.button_cancel.graphics.removeFromParent();
         _kickClip.check_box.label.text = Translate.translateArgs("UI_DIALOG_CLAN_INFO_DISMISS_ADD_TO_BLACK_LIST");
         _kickClip.check_box.label.validate();
         _kickClip.check_box.label.width = _kickClip.check_box.label.width;
         _kickClip.check_box.graphics.dispatchEventWith("layoutDataChange");
         _kickClip.bg.graphics.height = _kickClip.layout_buttons.graphics.y + _kickClip.layout_buttons.graphics.height + 10;
         width = _kickClip.bg.graphics.width;
         height = _kickClip.bg.graphics.height;
      }
      
      override protected function createClip() : MessagePopupClip
      {
         _kickClip = AssetStorage.rsx.popup_theme.create(KickClanMemberPopupClip,"kick_clan_member_popup");
         return _kickClip;
      }
   }
}
