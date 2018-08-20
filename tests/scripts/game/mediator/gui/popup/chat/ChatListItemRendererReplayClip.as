package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ChatListItemRendererReplayClip extends GuiClipNestedContainer
   {
       
      
      public var btn_option:ClipButton;
      
      public var tf_label:SpecialClipLabel;
      
      public const button_share:ChatChallengeResponsesUnderlinedButton = new ChatChallengeResponsesUnderlinedButton();
      
      public var msgLG:LayoutGroup;
      
      public function ChatListItemRendererReplayClip()
      {
         btn_option = new ClipButton();
         tf_label = new SpecialClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.paddingTop = 5;
         _loc2_.paddingBottom = 5;
         msgLG = new LayoutGroup();
         msgLG.x = tf_label.x;
         msgLG.y = tf_label.y - _loc2_.paddingTop;
         msgLG.layout = _loc2_;
         msgLG.addChild(tf_label);
         tf_label.x = 0;
         tf_label.y = 0;
         container.addChild(msgLG);
         button_share.label = Translate.translate("UI_DIALOG_CHAT_REPLAY_SHARE");
         button_share.graphics.x = 560 - button_share.graphics.width - 5;
         button_share.graphics.visible = false;
      }
   }
}
