package game.view.gui.overlay
{
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class PlayerPortraitNicknameButton extends ClipButton
   {
       
      
      public var labelBackground:GuiClipScale3Image;
      
      public var label:ClipLabel;
      
      public function PlayerPortraitNicknameButton()
      {
         label = new ClipLabel();
         super();
      }
   }
}
