package game.mediator.gui.popup.chat.responses
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class ChatChallengeResponsesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ChatChallengeResponsesPopupMediator;
      
      private var clip:ChatChallengeResponsesPopupClip;
      
      public function ChatChallengeResponsesPopup(param1:ChatChallengeResponsesPopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChatChallengeResponsesPopupClip,"dialog_chat_challenge_responses");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_RESPONSES");
         clip.portrait.setData(mediator.initiator);
         clip.tf_nickname.text = mediator.initiator.nickname;
         clip.tf_date.text = mediator.timeString;
         clip.team.setUnitTeam(mediator.team);
         clip.layout_top_right.width = mediator.team.length * clip.team.hero[0].graphics.width;
         clip.list.context = mediator;
         clip.list.list.dataProvider = mediator.responses;
      }
   }
}
