package game.mediator.gui.component
{
   import game.view.popup.hero.TimerQueueDispenser;
   import idv.cjcat.signals.Signal;
   
   public class RewardPopupStarAnimator extends TimerQueueDispenser
   {
       
      
      private var stars:int;
      
      private var _signal_complete:Signal;
      
      public function RewardPopupStarAnimator(param1:Number, param2:int)
      {
         _signal_complete = new Signal();
         super(StarValueObject,param1);
         this.stars = param2;
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      public function start() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<StarValueObject> = new Vector.<StarValueObject>();
         _loc2_ = 0;
         while(_loc2_ < stars)
         {
            _loc1_.push(new StarValueObject(_loc2_ + 1));
            _loc2_++;
         }
         _loc1_.push(new StarValueObject(-1));
         if(_loc1_.length)
         {
            add(_loc1_);
            signal_onElement.add(handler_onStar);
         }
         else
         {
            _signal_complete.dispatch();
         }
      }
      
      override protected function dispatchOnElement(param1:*) : void
      {
         if((param1 as StarValueObject).star == -1)
         {
            _signal_complete.dispatch();
            return;
         }
         _signal_onElement.dispatch(param1);
      }
      
      private function handler_onStar(param1:StarValueObject) : void
      {
         if(param1.star != -1)
         {
         }
      }
   }
}
