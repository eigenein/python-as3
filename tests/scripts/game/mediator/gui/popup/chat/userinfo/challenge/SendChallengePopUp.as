package game.mediator.gui.popup.chat.userinfo.challenge
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.chat.ChatPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class SendChallengePopUp extends ClipBasedPopup
   {
       
      
      private var clip:SendChallengePopUpClip;
      
      private var mediator:ChatPopupMediator;
      
      private var _isTitanBattle:Boolean;
      
      public function SendChallengePopUp(param1:ChatPopupMediator, param2:Boolean)
      {
         super(param1);
         this._isTitanBattle = param2;
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = new SendChallengePopUpClip();
         AssetStorage.rsx.popup_theme.factory.create(clip,AssetStorage.rsx.popup_theme.data.getClipByName("challenge_popup"));
         addChild(clip.graphics);
         clip.button_close.signal_click.add(handler_closeClick);
         clip.tf_title.text = Translate.translate("UI_POPUP_CHALLENGE_COMMENT");
         clip.action_btn.label = Translate.translate("UI_POPUP_CHALLENGE_ACTION");
         clip.tf_message_input.prompt = Translate.translate("UI_DIALOG_CHAT_INPUT_MESSAGE_PROMPT");
         clip.action_btn.signal_click.add(handler_actionClick);
      }
      
      private function handler_closeClick() : void
      {
         mediator.closeChallengePopUp(this);
      }
      
      private function handler_actionClick() : void
      {
         mediator.sendChallenge(clip.tf_message_input.text,_isTitanBattle);
         mediator.closeChallengePopUp(this);
      }
   }
}
