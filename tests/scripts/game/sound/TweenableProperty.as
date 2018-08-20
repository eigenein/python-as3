package game.sound
{
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class TweenableProperty implements IAnimatable
   {
       
      
      protected var _value:Number;
      
      protected var _updateMethod:Function;
      
      protected var _easing:Number = 0;
      
      private var oldValue:Number;
      
      private var deltaValue:Number;
      
      private var tweenDuration:Number;
      
      private var tweenDurationLeft:Number;
      
      public function TweenableProperty(param1:Number, param2:Function)
      {
         super();
         this._value = param1;
         param2(_value);
         this._updateMethod = param2;
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function set easing(param1:Number) : void
      {
         if(param1 < -1 || param1 > 1)
         {
            throw new ArgumentError("Expected value from [-1, 1], but " + easing + " recieved");
         }
         this._easing = param1;
      }
      
      public function get easing() : Number
      {
         return _easing;
      }
      
      public function setValue(param1:Number) : void
      {
         if(this._value != param1)
         {
            var _loc2_:* = param1;
            this.oldValue = _loc2_;
            this._value = _loc2_;
            tweenDurationLeft = 0;
            deltaValue = 0;
            _updateMethod(param1);
            Starling.juggler.remove(this);
         }
      }
      
      public function tweenTo(param1:Number, param2:Number, param3:Number = NaN) : void
      {
         if(this._value == param1)
         {
            return;
         }
         if(param3 == param3)
         {
            this.easing = param3;
         }
         if(param2 > 0)
         {
            Starling.juggler.add(this);
            var _loc4_:* = param2;
            this.tweenDurationLeft = _loc4_;
            this.tweenDuration = _loc4_;
            oldValue = this._value;
            this.deltaValue = param1 - oldValue;
         }
         else
         {
            this._value = param1;
            _updateMethod(param1);
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(tweenDurationLeft > 0)
         {
            tweenDurationLeft = tweenDurationLeft - param1;
            if(tweenDurationLeft < 0)
            {
               tweenDurationLeft = 0;
               Starling.juggler.remove(this);
            }
            _loc2_ = 1 - tweenDurationLeft / tweenDuration;
            _value = oldValue + deltaValue * _loc2_ + deltaValue * _loc2_ * (1 - _loc2_) * _easing;
            _updateMethod(_value);
         }
      }
   }
}
