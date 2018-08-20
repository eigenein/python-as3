package game.mediator.gui.popup.chat.sendreplay
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   
   public class SendReplayPopUpClipShort extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var bg:GuiClipScale9Image;
      
      public var tf_replay:ClipLabel;
      
      public var replay_url_input:ClipInput;
      
      public var replay_url_bg:GuiClipScale9Image;
      
      public var copy_btn:ClipButtonLabeled;
      
      public function SendReplayPopUpClipShort()
      {
         button_close = new ClipButton();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_replay = new ClipLabel(true);
         replay_url_input = new ClipInput();
         replay_url_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         copy_btn = new ClipButtonLabeled();
         super();
      }
   }
}
