package game.battle.view.hero
{
   import com.progrestar.common.util.assert;
   import idv.cjcat.signals.Signal;
   
   public class HeroAnimationController
   {
      
      public static const MOVING_NONE:int = 0;
      
      public static const MOVING_X:int = 1;
      
      public static const MOVING_Y:int = 2;
       
      
      public const onDeath:Signal = new Signal();
      
      private var animation:HeroAnimationRsx;
      
      private var disabled:Boolean = false;
      
      protected var activeAnimation:AnimationIdent;
      
      protected var defaultAnimation:AnimationIdent;
      
      public function HeroAnimationController(param1:HeroAnimationRsx)
      {
         super();
         this.animation = param1;
         param1.onAnimationComplete.add(onAnimationComplete);
      }
      
      public function dispose() : void
      {
         animation.onAnimationComplete.remove(onAnimationComplete);
      }
      
      public function set moving(param1:int) : void
      {
         var _loc2_:* = false;
         if(disabled)
         {
            return;
         }
         var _loc3_:AnimationIdent = null;
         if(param1 == 0)
         {
            _loc3_ = AnimationIdent.IDLE;
         }
         else if(param1 == 1)
         {
            _loc3_ = AnimationIdent.RUN;
         }
         else if(param1 == 2)
         {
            _loc2_ = defaultAnimation != AnimationIdent.STRAFE;
            _loc3_ = AnimationIdent.STRAFE;
         }
         if(!activeAnimation && _loc3_ != defaultAnimation)
         {
            animation.setCurrentAnimation(_loc3_,true);
            if(_loc2_)
            {
               animation.advanceTime(0.1);
            }
         }
         defaultAnimation = _loc3_;
      }
      
      public function get attacking() : Boolean
      {
         return activeAnimation != null && AnimationIdent.attacks.indexOf(activeAnimation) != -1;
      }
      
      public function get idlingOrMoving() : Boolean
      {
         return activeAnimation == null || activeAnimation == AnimationIdent.POSE;
      }
      
      public function get moving() : int
      {
         if(defaultAnimation == AnimationIdent.RUN)
         {
            return 1;
         }
         if(defaultAnimation == AnimationIdent.STRAFE)
         {
            return 2;
         }
         return 0;
      }
      
      public function get isDisabled() : Boolean
      {
         return disabled;
      }
      
      public function get dying() : Boolean
      {
         return activeAnimation == AnimationIdent.DIE;
      }
      
      public function stopAny() : void
      {
         if(activeAnimation)
         {
            activeAnimation = null;
            animation.setCurrentAnimation(defaultAnimation,true);
         }
      }
      
      public function stopActiveAnimationLoop() : void
      {
         if(animation.looping)
         {
            activeAnimation = null;
            animation.setCurrentAnimation(defaultAnimation,true);
         }
      }
      
      public function stopAnimation(param1:AnimationIdent, param2:Boolean) : void
      {
         if(activeAnimation == param1 && (param2 == false || animation.looping))
         {
            activeAnimation = null;
            animation.setCurrentAnimation(defaultAnimation,true);
         }
      }
      
      public function setAttackAnimation(param1:int) : void
      {
         if(disabled || param1 >= AnimationIdent.attacks.length)
         {
            return;
         }
         var _loc2_:* = param1 == 1;
         setActiveAnimation(AnimationIdent.attacks[param1],_loc2_);
      }
      
      public function disableAndStopWhenCompleted() : void
      {
         disabled = true;
         defaultAnimation = activeAnimation;
      }
      
      public function setActiveAnimation(param1:AnimationIdent, param2:Boolean = false) : void
      {
         assert(param1);
         if(disabled || !param1)
         {
            return;
         }
         animation.setCurrentAnimation(param1,param2);
         activeAnimation = param1;
      }
      
      public function setCustomAnimation(param1:AnimationIdent, param2:String) : void
      {
         assert(param2);
         if(disabled || !param2)
         {
            return;
         }
         animation.setCustomAnimation(param1,param2);
         activeAnimation = param1;
      }
      
      protected function onAnimationComplete() : void
      {
         if(disabled)
         {
            animation.stop();
            onDeath.dispatch();
            onDeath.clear();
         }
         else if(!animation.looping)
         {
            if(activeAnimation)
            {
               activeAnimation = null;
               animation.setCurrentAnimation(defaultAnimation,true);
            }
            else if(defaultAnimation != animation.currentAnimation)
            {
               animation.setCurrentAnimation(defaultAnimation,true);
            }
         }
      }
   }
}
