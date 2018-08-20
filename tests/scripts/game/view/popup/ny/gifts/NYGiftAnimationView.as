package game.view.popup.ny.gifts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import game.view.gui.components.ClipButton;
   
   public class NYGiftAnimationView extends ClipButton
   {
       
      
      private var currentAnim:GuiAnimation;
      
      public var idle:GuiAnimation;
      
      public var hover:GuiAnimation;
      
      public var rays:GuiAnimation;
      
      public var region:GuiClipImage;
      
      public function NYGiftAnimationView()
      {
         idle = new GuiAnimation();
         hover = new GuiAnimation();
         rays = new GuiAnimation();
         region = new GuiClipImage();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         region.graphics.alpha = 0;
         idle.graphics.touchable = false;
         rays.graphics.touchable = false;
         hover.graphics.touchable = false;
         hover.stop();
         hover.hide();
         changeAnimTo(idle,true);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         var _loc3_:* = param1;
         if("hover" === _loc3_)
         {
            playHoverAnimation();
         }
      }
      
      public function playHoverAnimation() : void
      {
         changeAnimTo(hover,false);
      }
      
      private function changeAnimTo(param1:GuiAnimation, param2:Boolean) : void
      {
         if(param1 == currentAnim)
         {
            return;
         }
         if(currentAnim)
         {
            currentAnim.stop();
            currentAnim.hide();
            if(!currentAnim.isLooping)
            {
               currentAnim.signal_completed.remove(onAnimEnd);
            }
         }
         currentAnim = param1;
         currentAnim.show(this.container);
         if(!param2)
         {
            currentAnim.playOnce();
            currentAnim.signal_completed.add(onAnimEnd);
         }
         else
         {
            currentAnim.playLoop();
         }
      }
      
      private function onAnimEnd() : void
      {
         changeAnimTo(idle,true);
      }
   }
}
