package game.mechanics.zeppelin.popup.clip
{
   import engine.core.clipgui.GuiAnimation;
   
   public class ZeppelinPopupChestButton extends ZeppelinPopupButton
   {
       
      
      public var animation_closed:GuiAnimation;
      
      public var hover_back_2:GuiAnimation;
      
      public function ZeppelinPopupChestButton()
      {
         super();
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         _hoverAnimationIntensity = param1;
         adjustIntensity(hover_back_2,param1 * 0.45);
         if(_redMarkerState && _redMarkerState.value)
         {
            param1 = 100;
         }
         adjustIntensity(hover_front,param1);
         adjustIntensity(hover_back,param1);
      }
      
      override protected function handler_markerStateUpdate() : void
      {
         super.handler_markerStateUpdate();
         if(_redMarkerState.value)
         {
            animation_closed.graphics.visible = false;
            animation_closed.stopOnFrame(0);
            animation.graphics.visible = true;
            animation.playLoop();
         }
         else
         {
            animation_closed.graphics.visible = true;
            animation_closed.playLoop();
            animation.graphics.visible = false;
            animation.stopOnFrame(0);
         }
         hoverAnimationIntensity = 0;
      }
   }
}
