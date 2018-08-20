package game.view.popup.tower.screen
{
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.HoverClipButton;
   
   public class TowerScreenChestButton extends HoverClipButton
   {
       
      
      public var hover_back:GuiAnimation;
      
      public var hover_front:GuiAnimation;
      
      public function TowerScreenChestButton()
      {
         hover_back = new GuiAnimation();
         hover_front = new GuiAnimation();
         super();
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         if(_hoverAnimationIntensity == param1)
         {
            return;
         }
         _hoverAnimationIntensity = param1;
         adjustIntensity(hover_front,param1);
         adjustIntensity(hover_back,param1);
      }
   }
}
