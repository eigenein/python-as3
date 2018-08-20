package game.view.popup.blasklist
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class BlackListPopUpRendererClip extends GuiClipNestedContainer
   {
       
      
      public var action_button:ClipButton;
      
      public var tf_nick:ClipLabel;
      
      public function BlackListPopUpRendererClip()
      {
         action_button = new ClipButton();
         tf_nick = new ClipLabel(true);
         super();
      }
   }
}
