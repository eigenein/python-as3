package game.view.popup.hero.rune
{
   import starling.events.Event;
   
   public class HeroElementPopupCircleSpinController
   {
       
      
      private var clip:HeroElementPopupCircleAnimationClip;
      
      private var rotation:Number = 0;
      
      private var rotationPerSecond:Number = -0.3141592653589793;
      
      private var delay:Number = 0.6166666666666667;
      
      private var spinDuration:Number = 1.5;
      
      private var deccelerationDuration:Number = 1.35;
      
      private var singleSpinMagnitude:Number = -2.0943951023931953;
      
      private var spinPhases:Vector.<Number>;
      
      public function HeroElementPopupCircleSpinController()
      {
         spinPhases = new Vector.<Number>();
         super();
      }
      
      public function dispose() : void
      {
         if(clip)
         {
            clip.graphics.removeEventListener("enterFrame",handler_enterFrame);
         }
      }
      
      public function start(param1:HeroElementPopupCircleAnimationClip) : void
      {
         if(param1 && param1.topMc && param1.bottomMc)
         {
            this.clip = param1;
            param1.graphics.addEventListener("enterFrame",handler_enterFrame);
         }
      }
      
      public function addSpin() : void
      {
         spinPhases.push(delay + spinDuration);
      }
      
      protected function getSingleSpinPhase(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         if(param1 > deccelerationDuration)
         {
            _loc2_ = 1 - (param1 - deccelerationDuration) / (spinDuration - deccelerationDuration);
            _loc2_ = _loc2_ * _loc2_ * _loc2_;
            return (1 - deccelerationDuration / spinDuration) * _loc2_;
         }
         _loc2_ = param1 / deccelerationDuration;
         _loc2_ = 1 - _loc2_ * _loc2_ * _loc2_;
         return 1 - deccelerationDuration / spinDuration + deccelerationDuration / spinDuration * _loc2_;
      }
      
      protected function addSingleSpinRotation(param1:Number, param2:Number) : void
      {
         rotation = rotation + singleSpinMagnitude * (getSingleSpinPhase(param1 - param2) - getSingleSpinPhase(param1));
      }
      
      protected function handler_enterFrame(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc7_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = param1.data;
         rotation = rotation + rotationPerSecond * _loc4_;
         var _loc2_:int = 0;
         var _loc6_:int = spinPhases.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = spinPhases[_loc5_];
            _loc3_ = _loc7_ - _loc4_;
            if(_loc3_ <= spinDuration)
            {
               if(_loc7_ > spinDuration)
               {
                  addSingleSpinRotation(spinDuration,spinDuration - _loc3_);
               }
               else if(_loc7_ > _loc4_)
               {
                  addSingleSpinRotation(_loc7_,_loc4_);
               }
               else
               {
                  addSingleSpinRotation(_loc7_,_loc7_);
               }
            }
            if(_loc7_ > 0)
            {
               spinPhases[_loc5_ - _loc2_] = _loc3_;
            }
            else
            {
               _loc2_++;
            }
            _loc5_++;
         }
         spinPhases.length = spinPhases.length - _loc2_;
         if(rotation > 3.14159265358979 * 100)
         {
            rotation = rotation - 3.14159265358979 * 100;
         }
         var _loc8_:* = rotation;
         clip.bottomMc.graphics.rotation = _loc8_;
         clip.topMc.graphics.rotation = _loc8_;
      }
   }
}
