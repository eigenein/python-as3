package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.view.popup.PromptPopup;
   import game.view.popup.PromptPopupClip;
   import game.view.popup.message.MessagePopupClip;
   
   public class ClanLeaveConfirmationPopup extends PromptPopup
   {
       
      
      public function ClanLeaveConfirmationPopup(param1:ClanPrivateInfoValueObject)
      {
         var _loc2_:String = Translate.translate("UI_POPUP_CLAN_LEAVE_MSG");
         if(param1.clanWarLeagueId == 1 && !param1.serverTimeInFreeClanChangeInterval)
         {
            _loc2_ = _loc2_ + ("\n\n" + Translate.translate("UI_POPUP_CLAN_LEAVE_GOLD_LEAGUE_MSG"));
         }
         super(_loc2_,Translate.translate("UI_POPUP_CLAN_LEAVE_TITLE"),Translate.translate("UI_POPUP_CLAN_LEAVE_YES"),Translate.translate("UI_POPUP_CLAN_LEAVE_NO"));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip.bg.graphics.height = clip.layout_text.graphics.height - 10;
      }
      
      override protected function createClip() : MessagePopupClip
      {
         var _loc1_:PromptPopupClip = AssetStorage.rsx.popup_theme.create(PromptPopupClip,"popup_prompt_wide");
         return _loc1_;
      }
   }
}
