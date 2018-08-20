package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   
   public class HomeScreenGuiChestClipButton extends HomeScreenBuildingButton implements ITutorialButtonBoundsProvider
   {
       
      
      public var animation_idle:GuiAnimation;
      
      public var animation_idle2:GuiAnimation;
      
      public var hover_back_2:GuiAnimation;
      
      public var animation_closed:GuiAnimation;
      
      public function HomeScreenGuiChestClipButton()
      {
         super();
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return 64;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return 274;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return 90;
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
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         hover_back.graphics.touchable = false;
         animation_idle.graphics.touchable = false;
         hover_back_2.graphics.touchable = false;
         hover_front.graphics.touchable = false;
      }
   }
}
