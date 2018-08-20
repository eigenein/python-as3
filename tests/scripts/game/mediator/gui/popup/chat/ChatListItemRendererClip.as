package game.mediator.gui.popup.chat
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.controls.LayoutGroup;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ChatListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_chat_message_header:SpecialClipLabel;
      
      public var tf_time:SpecialClipLabel;
      
      public var tf_chat_message:SpecialClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var bg_my:GuiClipScale9Image;
      
      public var bg_container:LayoutGroup;
      
      public var replay_content:ChatListItemRendererReplayClip;
      
      public var challenge_content:ChatListItemRendererChallengeClip;
      
      public var layout_group:ClipLayout;
      
      public var button_copy:ClipButton;
      
      public function ChatListItemRendererClip()
      {
         tf_chat_message_header = new SpecialClipLabel(true);
         tf_time = new SpecialClipLabel();
         tf_chat_message = new SpecialClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(24,24,24,12));
         bg_my = new GuiClipScale9Image(new Rectangle(12,24,12,12));
         bg_container = new LayoutGroup();
         replay_content = new ChatListItemRendererReplayClip();
         challenge_content = new ChatListItemRendererChallengeClip();
         layout_group = ClipLayout.vertical(0);
         button_copy = new ClipButton();
         super();
         tf_chat_message_header.width = NaN;
         tf_time.touchable = false;
         tf_chat_message.touchable = false;
         replay_content.tf_label.touchable = false;
         challenge_content.tf_label.touchable = false;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_chat_message.wordWrap = true;
         container.addChildAt(bg_container,0);
         bg_container.addChild(bg.graphics);
         bg_container.addChild(bg_my.graphics);
         button_copy.graphics.visible = false;
      }
   }
}
