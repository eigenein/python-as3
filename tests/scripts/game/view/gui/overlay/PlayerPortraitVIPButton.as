package game.view.gui.overlay
{
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.popup.theme.LabelStyle;
   
   public class PlayerPortraitVIPButton extends ClipButton
   {
       
      
      public var label:GuiClipLabel;
      
      public var labelBackground:GuiClipScale3Image;
      
      public function PlayerPortraitVIPButton()
      {
         super();
         label = new GuiClipLabel(LabelStyle.buttonLabel_size18_vip);
         labelBackground = new GuiClipScale3Image(26,1);
      }
   }
}
