package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   import game.view.gui.worldmap.WorldMapView;
   
   public class HomeScreenPortalGuiClipButton extends HomeScreenBuildingButton implements ITutorialButtonBoundsProvider
   {
       
      
      public var image_multiHitArea:HomeScreenDoubleImageHitArea;
      
      public var untouchable:Vector.<GuiAnimation>;
      
      public function HomeScreenPortalGuiClipButton()
      {
         image_multiHitArea = new HomeScreenDoubleImageHitArea();
         untouchable = new Vector.<GuiAnimation>();
         super();
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         .super.hoverAnimationIntensity = param1;
         adjustAnimationObject(animation,param1);
      }
      
      protected function adjustAnimationObject(param1:GuiAnimation, param2:int) : void
      {
         param1.playbackSpeed = 1 + 1.5 * param2 / 100;
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return 0;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return -20;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return 120;
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return WorldMapView.music;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation.graphics.touchable = false;
         hover_front.graphics.touchable = false;
         var _loc4_:int = 0;
         var _loc3_:* = untouchable;
         for each(var _loc2_ in untouchable)
         {
            _loc2_.graphics.touchable = false;
         }
      }
   }
}
