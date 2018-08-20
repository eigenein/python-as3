package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   import org.osflash.signals.Signal;
   
   public class ChatChallengeTypeSelectPopup extends ClipBasedPopup
   {
       
      
      private var clip:ChatChallengeTypeSelectPopupClip;
      
      public const signal_battleType:Signal = new Signal(String);
      
      public function ChatChallengeTypeSelectPopup()
      {
         super(null);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChatChallengeTypeSelectPopupClip,"dialog_chat_challenge_select_type");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(handler_close);
         clip.tf_header.text = Translate.translate("UI_DIALOG_CHAT_CHALLENGE_SELECT_TYPE_HEADER");
         clip.button_hero.initialize(Translate.translate("UI_DIALOG_CHAT_CHALLENGE_TYPE_HERO"),handler_heroBattle);
         clip.button_titan.initialize(Translate.translate("UI_DIALOG_CHAT_CHALLENGE_TYPE_TITAN"),handler_titanBattle);
      }
      
      private function handler_close() : void
      {
         close();
      }
      
      private function handler_heroBattle() : void
      {
         signal_battleType.dispatch("hero");
         close();
      }
      
      private function handler_titanBattle() : void
      {
         signal_battleType.dispatch("titan");
         close();
      }
   }
}
