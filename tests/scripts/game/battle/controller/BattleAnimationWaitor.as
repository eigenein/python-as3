package game.battle.controller
{
   import com.progrestar.common.util.assert;
   import starling.core.Starling;
   
   public class BattleAnimationWaitor
   {
       
      
      private var animationsCompletedCallback:Function;
      
      private var awaitedAnimationsCounter:int;
      
      public function BattleAnimationWaitor()
      {
         super();
         awaitedAnimationsCounter = 0;
      }
      
      public function heroDeathAnimationStarted() : void
      {
         awaitedAnimationsCounter = Number(awaitedAnimationsCounter) + 1;
      }
      
      public function heroDeathAnimationEnded() : void
      {
         onAwaitedAnimationComplete();
      }
      
      public function waitForAllAnimationsToComplete(param1:Function, param2:Number = 0) : void
      {
         assert(param1 && param1.length == 0);
         if(param2 == 0 && awaitedAnimationsCounter == 0)
         {
            param1();
         }
         else
         {
            this.animationsCompletedCallback = param1;
            if(param2 > 0)
            {
               awaitedAnimationsCounter = Number(awaitedAnimationsCounter) + 1;
               Starling.juggler.delayCall(onAwaitedAnimationComplete,param2);
            }
         }
      }
      
      private function onAwaitedAnimationComplete() : void
      {
         awaitedAnimationsCounter = awaitedAnimationsCounter - 1;
         if(awaitedAnimationsCounter - 1 == 0 && animationsCompletedCallback)
         {
            animationsCompletedCallback();
            animationsCompletedCallback = null;
         }
      }
   }
}
