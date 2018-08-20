package game.view.popup.tower.screen
{
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.HoverClipButton;
   
   public class TowerScreenAltarButton extends HoverClipButton
   {
       
      
      public var anim_1:GuiAnimation;
      
      public var anim_2:GuiAnimation;
      
      public var anim_3:GuiAnimation;
      
      public var anim_4:GuiAnimation;
      
      public var anim_5:GuiAnimation;
      
      public var anim_hover_back:GuiAnimation;
      
      public var anim_hover_front:GuiAnimation;
      
      public function TowerScreenAltarButton()
      {
         anim_1 = new GuiAnimation();
         anim_2 = new GuiAnimation();
         anim_3 = new GuiAnimation();
         anim_4 = new GuiAnimation();
         anim_5 = new GuiAnimation();
         anim_hover_back = new GuiAnimation();
         anim_hover_front = new GuiAnimation();
         super();
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         if(_hoverAnimationIntensity == param1)
         {
            return;
         }
         _hoverAnimationIntensity = param1;
         adjustIntensity(anim_hover_back,param1);
         adjustIntensity(anim_hover_front,param1);
      }
   }
}
