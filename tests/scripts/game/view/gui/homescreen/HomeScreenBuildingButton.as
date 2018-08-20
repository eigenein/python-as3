package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipHitTestImage;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.filters.ColorMatrixFilter;
   
   public class HomeScreenBuildingButton extends HomeScreenGuiClipButton
   {
       
      
      private var hoverSound:ButtonHoverSound;
      
      public var hitTest_image:GuiClipHitTestImage;
      
      public var animation:GuiAnimation;
      
      public var hover_front:GuiAnimation;
      
      public var hover_back:GuiAnimation;
      
      protected var tween:Tween;
      
      protected var _hoverAnimationIntensity:int = -1;
      
      public function HomeScreenBuildingButton()
      {
         hoverSound = createHoverSound();
         hitTest_image = new GuiClipHitTestImage();
         super();
         createTween();
      }
      
      public function get hoverAnimationIntensity() : int
      {
         return _hoverAnimationIntensity;
      }
      
      public function set hoverAnimationIntensity(param1:int) : void
      {
         if(_hoverAnimationIntensity == param1)
         {
            return;
         }
         _hoverAnimationIntensity = param1;
         adjustIntensity(hover_front,param1);
         adjustIntensity(hover_back,param1);
      }
      
      protected function createTween() : void
      {
         tween = new Tween(this,0.5);
      }
      
      protected function adjustIntensity(param1:GuiAnimation, param2:int) : void
      {
         if(param1)
         {
            param1.graphics.alpha = param2 / 100;
            param1.graphics.visible = param2 > 0;
            if(param2 > 0 && !param1.isPlaying)
            {
               param1.play();
            }
            else if(param2 == 0 && param1.isPlaying)
            {
               param1.stop();
            }
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",100);
            Starling.juggler.add(tween);
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            if(labelBackground)
            {
               labelBackground.graphics.filter = _loc3_;
            }
            if(hoverSound)
            {
               hoverSound.mouseOver();
            }
         }
         else
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",0);
            Starling.juggler.add(tween);
            if(labelBackground && labelBackground.graphics.filter)
            {
               labelBackground.graphics.filter.dispose();
               labelBackground.graphics.filter = null;
            }
            if(hoverSound)
            {
               hoverSound.mouseOut();
            }
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(hitTest_image.graphics)
         {
            if(hover_back && hover_back.graphics)
            {
               hover_back.graphics.touchable = false;
            }
            if(animation && animation.graphics)
            {
               animation.graphics.touchable = false;
            }
            if(hover_front && hover_front.graphics)
            {
               hover_front.graphics.touchable = false;
            }
         }
         hoverAnimationIntensity = 0;
      }
      
      protected function createHoverSound() : ButtonHoverSound
      {
         return null;
      }
   }
}
