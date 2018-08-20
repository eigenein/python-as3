package game.view.popup.chest
{
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   
   public class ChestIdleButton extends ClipButton
   {
       
      
      public var animation:GuiAnimation;
      
      public function ChestIdleButton()
      {
         super();
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            animation.playbackSpeed = 2;
         }
         else
         {
            animation.playbackSpeed = 1;
            _container.filter = null;
         }
      }
   }
}
