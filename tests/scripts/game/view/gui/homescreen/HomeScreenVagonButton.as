package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.view.popup.chest.SoundGuiAnimation;
   import game.view.popup.ny.welcome.NYWelcomePopupMediator;
   
   public class HomeScreenVagonButton extends HomeScreenBuildingButton
   {
       
      
      public var vendor_anim_periodic:GuiAnimation;
      
      public var vendor_anim_hover:SoundGuiAnimation;
      
      public var vendor_anim_up:GuiAnimation;
      
      public var vendor_anim_out:GuiAnimation;
      
      private var _currentAnim:GuiAnimation;
      
      private var _animations:Vector.<GuiAnimation>;
      
      private var _state:String = "up";
      
      private var _periodicDelay:int = 20000;
      
      private var _periodicDelayDispersion:Number = 0.5;
      
      private var _timeOutId:int;
      
      private var _music:ShopHoverSound;
      
      private var nextAnimationState:GuiAnimation;
      
      public function HomeScreenVagonButton()
      {
         vendor_anim_hover = new SoundGuiAnimation();
         _animations = new Vector.<GuiAnimation>(0);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         _animations.push(vendor_anim_periodic);
         _animations.push(vendor_anim_hover);
         _animations.push(vendor_anim_up);
         _animations.push(vendor_anim_out);
         hover_front.graphics.touchable = false;
         _loc2_ = 0;
         while(_loc2_ < _animations.length)
         {
            _animations[_loc2_].graphics.touchable = false;
            _animations[_loc2_].gotoAndStop(0);
            _animations[_loc2_].hide();
            _loc2_++;
         }
         updatePeriodicAnim();
         changeAnimTo(vendor_anim_up,true);
      }
      
      private function updatePeriodicAnim() : void
      {
         clearTimeout(_timeOutId);
         if(_currentAnim == vendor_anim_up)
         {
            changeAnimTo(vendor_anim_periodic,false);
         }
         var _loc1_:int = _periodicDelay * (1 + _periodicDelayDispersion * (1 - 2 * Math.random()));
         _timeOutId = setTimeout(updatePeriodicAnim,_loc1_);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         super.setupState(param1,param2);
         var _loc3_:* = param1;
         if("hover" !== _loc3_)
         {
            if("up" !== _loc3_)
            {
               if("down" !== _loc3_)
               {
               }
            }
            else
            {
               changeAnimTo(vendor_anim_out,false);
            }
         }
         else
         {
            changeAnimTo(vendor_anim_hover,true);
         }
         _state = param1;
      }
      
      private function changeAnimTo(param1:GuiAnimation, param2:Boolean) : void
      {
         if(param1 == _currentAnim)
         {
            return;
         }
         if(param2)
         {
            if(_currentAnim)
            {
               _currentAnim.stop();
               _currentAnim.hide();
               _currentAnim.signal_completed.remove(onAnimEnd);
            }
            _currentAnim = param1;
            _currentAnim.show(this.container);
            _currentAnim.playOnce();
            _currentAnim.signal_completed.add(onAnimEnd);
            nextAnimationState == null;
         }
         else
         {
            nextAnimationState = param1;
         }
      }
      
      private function onAnimEnd() : void
      {
         if(_currentAnim == vendor_anim_out || _currentAnim == vendor_anim_periodic)
         {
            nextAnimationState = vendor_anim_up;
         }
         if(_currentAnim == nextAnimationState || nextAnimationState == null)
         {
            _currentAnim.playOnce();
            return;
         }
         _currentAnim.stop();
         _currentAnim.hide();
         _currentAnim.signal_completed.remove(onAnimEnd);
         _currentAnim = nextAnimationState;
         _currentAnim.show(this.container);
         _currentAnim.playOnce();
         _currentAnim.signal_completed.add(onAnimEnd);
         nextAnimationState = null;
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return NYWelcomePopupMediator.music;
      }
   }
}
