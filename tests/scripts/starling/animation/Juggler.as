package starling.animation
{
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   public class Juggler implements IAnimatable
   {
       
      
      private var mObjects:Vector.<IAnimatable>;
      
      private var mElapsedTime:Number;
      
      public function Juggler()
      {
         super();
         mElapsedTime = 0;
         mObjects = new Vector.<IAnimatable>(0);
      }
      
      public function add(param1:IAnimatable) : void
      {
         var _loc2_:* = null;
         if(param1 && mObjects.indexOf(param1) == -1)
         {
            mObjects[mObjects.length] = param1;
            _loc2_ = param1 as EventDispatcher;
            if(_loc2_)
            {
               _loc2_.addEventListener("removeFromJuggler",onRemove);
            }
         }
      }
      
      public function contains(param1:IAnimatable) : Boolean
      {
         return mObjects.indexOf(param1) != -1;
      }
      
      public function remove(param1:IAnimatable) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:EventDispatcher = param1 as EventDispatcher;
         if(_loc3_)
         {
            _loc3_.removeEventListener("removeFromJuggler",onRemove);
         }
         var _loc2_:int = mObjects.indexOf(param1);
         if(_loc2_ != -1)
         {
            mObjects[_loc2_] = null;
         }
      }
      
      public function removeTweens(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1 == null)
         {
            return;
         }
         _loc3_ = mObjects.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = mObjects[_loc3_] as Tween;
            if(_loc2_ && _loc2_.target == param1)
            {
               _loc2_.removeEventListener("removeFromJuggler",onRemove);
               mObjects[_loc3_] = null;
            }
            _loc3_--;
         }
      }
      
      public function containsTweens(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1 == null)
         {
            return false;
         }
         _loc3_ = mObjects.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = mObjects[_loc3_] as Tween;
            if(_loc2_ && _loc2_.target == param1)
            {
               return true;
            }
            _loc3_--;
         }
         return false;
      }
      
      public function purge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = mObjects.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = mObjects[_loc1_] as EventDispatcher;
            if(_loc2_)
            {
               _loc2_.removeEventListener("removeFromJuggler",onRemove);
            }
            mObjects[_loc1_] = null;
            _loc1_--;
         }
      }
      
      public function delayCall(param1:Function, param2:Number, ... rest) : IAnimatable
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:DelayedCall = DelayedCall.fromPool(param1,param2,rest);
         _loc4_.addEventListener("removeFromJuggler",onPooledDelayedCallComplete);
         add(_loc4_);
         return _loc4_;
      }
      
      public function repeatCall(param1:Function, param2:Number, param3:int = 0, ... rest) : IAnimatable
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc5_:DelayedCall = DelayedCall.fromPool(param1,param2,rest);
         _loc5_.repeatCount = param3;
         _loc5_.addEventListener("removeFromJuggler",onPooledDelayedCallComplete);
         add(_loc5_);
         return _loc5_;
      }
      
      private function onPooledDelayedCallComplete(param1:Event) : void
      {
         DelayedCall.toPool(param1.target as DelayedCall);
      }
      
      public function tween(param1:Object, param2:Number, param3:Object) : IAnimatable
      {
         var _loc6_:* = null;
         var _loc4_:Tween = Tween.fromPool(param1,param2);
         var _loc8_:int = 0;
         var _loc7_:* = param3;
         for(var _loc5_ in param3)
         {
            _loc6_ = param3[_loc5_];
            if(_loc4_.hasOwnProperty(_loc5_))
            {
               _loc4_[_loc5_] = _loc6_;
               continue;
            }
            if(param1.hasOwnProperty(_loc5_))
            {
               _loc4_.animate(_loc5_,_loc6_ as Number);
               continue;
            }
            throw new ArgumentError("Invalid property: " + _loc5_);
         }
         _loc4_.addEventListener("removeFromJuggler",onPooledTweenComplete);
         add(_loc4_);
         return _loc4_;
      }
      
      private function onPooledTweenComplete(param1:Event) : void
      {
         Tween.toPool(param1.target as Tween);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = mObjects.length;
         var _loc3_:int = 0;
         mElapsedTime = mElapsedTime + param1;
         if(_loc4_ == 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc5_ = mObjects[_loc2_];
            if(_loc5_)
            {
               if(_loc3_ != _loc2_)
               {
                  mObjects[_loc3_] = _loc5_;
                  mObjects[_loc2_] = null;
               }
               _loc5_.advanceTime(param1);
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc3_ != _loc2_)
         {
            _loc4_ = mObjects.length;
            while(_loc2_ < _loc4_)
            {
               _loc3_++;
               _loc2_++;
               mObjects[int(_loc3_)] = mObjects[int(_loc2_)];
            }
            mObjects.length = _loc3_;
         }
      }
      
      private function onRemove(param1:Event) : void
      {
         remove(param1.target as IAnimatable);
         var _loc2_:Tween = param1.target as Tween;
         if(_loc2_ && _loc2_.isComplete)
         {
            add(_loc2_.nextTween);
         }
      }
      
      public function get elapsedTime() : Number
      {
         return mElapsedTime;
      }
      
      protected function get objects() : Vector.<IAnimatable>
      {
         return mObjects;
      }
   }
}
