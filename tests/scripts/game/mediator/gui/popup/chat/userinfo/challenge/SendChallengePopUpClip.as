package game.mediator.gui.popup.chat.userinfo.challenge
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.data.storage.DataStorage;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   
   public class SendChallengePopUpClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_message_input:ClipInput;
      
      public var tf_title:ClipLabel;
      
      public var action_btn:ClipButtonLabeled;
      
      public var bg:GuiClipScale9Image;
      
      public var message_bg:GuiClipScale9Image;
      
      public function SendChallengePopUpClip()
      {
         button_close = new ClipButton();
         tf_message_input = new ClipInput();
         tf_title = new ClipLabel();
         action_btn = new ClipButtonLabeled();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
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
