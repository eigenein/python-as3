package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import game.assets.storage.AssetStorage;
   import starling.animation.Tween;
   
   public class HomeScreenSkyPyramidButton extends HomeScreenBuildingButton
   {
       
      
      private var _music:ButtonHoverSound;
      
      public var anim_clip:HomeScreenSkyPyramidButtonAnimation;
      
      public var image_multiHitArea:HomeScreenDoubleImageHitArea;
      
      public function HomeScreenSkyPyramidButton()
      {
         anim_clip = new HomeScreenSkyPyramidButtonAnimation();
         image_multiHitArea = new HomeScreenDoubleImageHitArea();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation.setNativeSkinPart(anim_clip.graphics,"marker_PyramidAnim");
         animation.graphics.touchable = false;
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         .super.isEnabled = param1;
         if(param1)
         {
         }
      }
      
      override public function set hoverAnimationIntensity(param1:int) : void
      {
         .super.hoverAnimationIntensity = param1;
         adjustIntensity(anim_clip.fire_hover,param1);
         adjustIntensity(anim_clip.fire_idle,100 - param1);
         adjustIntensity(anim_clip.stars_hover,param1);
         adjustIntensity(anim_clip.stars_idle,100 - param1);
         anim_clip.triangle_down.gotoAndStop(param1 / 100 * anim_clip.triangle_down.lastFrame * 0.5);
         anim_clip.triangle_up.gotoAndStop(param1 / 100 * anim_clip.triangle_up.lastFrame * 0.5);
      }
      
      override protected function createTween() : void
      {
         tween = new Tween(this,2);
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(0.5,1.5,AssetStorage.sound.pyramidHover);
         }
         return _music;
      }
   }
}
