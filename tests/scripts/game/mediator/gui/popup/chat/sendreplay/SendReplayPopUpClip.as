package game.mediator.gui.popup.chat.sendreplay
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.chat.ChatListItemRendererReplayClip;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   
   public class SendReplayPopUpClip extends SendReplayPopUpClipShort
   {
       
      
      public var tf_message_input:ClipInput;
      
      public var tf_title:ClipLabel;
      
      public var action_btn:ClipButtonLabeled;
      
      public var replay_info:ChatListItemRendererReplayClip;
      
      public var message_bg:GuiClipScale9Image;
      
      public function SendReplayPopUpClip()
      {
         tf_message_input = new ClipInput();
         tf_title = new ClipLabel();
         action_btn = new ClipButtonLabeled();
         replay_info = new ChatListItemRendererReplayClip();
         message_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_message_input.promptShowDelay = 0.3;
         tf_message_input.maxChars = DataStorage.rule.chatRule.maxMessageLength;
      }
   }
}
