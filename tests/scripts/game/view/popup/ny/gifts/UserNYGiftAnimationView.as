package game.view.popup.ny.gifts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import game.view.gui.components.ClipButton;
   import game.view.popup.chest.SoundGuiAnimation;
   
   public class UserNYGiftAnimationView extends ClipButton
   {
       
      
      private var currentAnim:GuiAnimation;
      
      private var _giftOpened:Boolean;
      
      public var idle:GuiAnimation;
      
      public var hover:GuiAnimation;
      
      public var open:SoundGuiAnimation;
      
      public var idle2:GuiAnimation;
      
      public var rays:GuiAnimation;
      
      public var region:GuiClipImage;
      
      public function UserNYGiftAnimationView()
      {
         idle = new GuiAnimation();
         hover = new GuiAnimation();
         open = new SoundGuiAnimation();
         idle2 = new GuiAnimation();
         rays = new GuiAnimation();
         region = new GuiClipImage();
         super();
      }
      
      public function get giftOpened() : Boolean
      {
         return _giftOpened;
      }
      
      public function set giftOpened(param1:Boolean) : void
      {
         _giftOpened = param1;
         updateContent();
         if(param1)
         {
            changeAnimTo(idle2,true);
         }
         else
         {
            changeAnimTo(idle,true);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         region.graphics.alpha = 0;
         var _loc2_:Vector.<GuiAnimation> = new Vector.<GuiAnimation>();
         _loc2_.push(idle);
         _loc2_.push(idle2);
         _loc2_.push(hover);
         _loc2_.push(open);
         _loc2_.push(rays);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_].graphics.touchable = false;
            _loc2_[_loc3_].stop();
            _loc2_[_loc3_].hide();
            _loc3_++;
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         var _loc3_:* = param1;
         if("hover" === _loc3_)
         {
            changeAnimTo(hover,false);
         }
      }
      
      public function playOpenAnimation() : void
      {
         _giftOpened = true;
         updateContent();
         changeAnimTo(open,false);
      }
      
      private function updateContent() : void
      {
         region.graphics.touchable = !giftOpened;
         if(giftOpened)
         {
            rays.stop();
            rays.hide();
         }
         else
         {
            rays.playLoop();
            rays.show(this.container);
         }
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
         if(currentAnim == hover)
         {
            changeAnimTo(idle,true);
         }
         else
         {
            changeAnimTo(idle2,true);
         }
      }
   }
}
