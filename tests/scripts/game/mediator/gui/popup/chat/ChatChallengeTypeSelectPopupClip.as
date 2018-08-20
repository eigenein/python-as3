package game.mediator.gui.popup.chat
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class ChatChallengeTypeSelectPopupClip extends GuiClipNestedContainer
   {
       
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const button_hero:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_titan:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_close:ClipButton = new ClipButton();
      
      public function ChatChallengeTypeSelectPopupClip()
      {
         super();
      }
   }
}
