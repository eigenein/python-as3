package starling.events
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   
   public class EventDispatcher
   {
      
      private static var sBubbleChains:Array = [];
       
      
      private var mEventListeners:Dictionary;
      
      public function EventDispatcher()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         if(mEventListeners == null)
         {
            mEventListeners = new Dictionary();
         }
         var _loc3_:Vector.<Function> = mEventListeners[param1] as Vector.<Function>;
         if(_loc3_ == null)
         {
            mEventListeners[param1] = new <Function>[param2];
         }
         else if(_loc3_.indexOf(param2) == -1)
         {
            _loc3_[_loc3_.length] = param2;
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = undefined;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         if(mEventListeners)
         {
            _loc3_ = mEventListeners[param1] as Vector.<Function>;
            _loc4_ = !!_loc3_?_loc3_.length:0;
            if(_loc4_ > 0)
            {
               _loc6_ = 0;
               _loc8_ = new Vector.<Function>(_loc4_ - 1);
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  _loc5_ = _loc3_[_loc7_];
                  if(_loc5_ != param2)
                  {
                     _loc6_++;
                     _loc8_[int(_loc6_)] = _loc5_;
                  }
                  _loc7_++;
               }
               mEventListeners[param1] = _loc8_;
            }
         }
      }
      
      public function removeEventListeners(param1:String = null) : void
      {
         if(param1 && mEventListeners)
         {
            delete mEventListeners[param1];
         }
         else
         {
            mEventListeners = null;
         }
      }
      
      public function dispatchEvent(param1:Event) : void
      {
         var _loc2_:Boolean = param1.bubbles;
         if(!_loc2_ && (mEventListeners == null || !(param1.type in mEventListeners)))
         {
            return;
         }
         var _loc3_:EventDispatcher = param1.target;
         param1.setTarget(this);
         if(_loc2_ && this is DisplayObject)
         {
            bubbleEvent(param1);
         }
         else
         {
            invokeEvent(param1);
         }
         if(_loc3_)
         {
            param1.setTarget(_loc3_);
         }
      }
      
      function invokeEvent(param1:Event) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Vector.<Function> = !!mEventListeners?mEventListeners[param1.type] as Vector.<Function>:null;
         var _loc4_:int = _loc3_ == null?0:_loc3_.length;
         if(_loc4_)
         {
            param1.setCurrentTarget(this);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = _loc3_[_loc6_] as Function;
               _loc2_ = _loc5_.length;
               if(_loc2_ == 0)
               {
                  _loc5_();
               }
               else if(_loc2_ == 1)
               {
                  _loc5_(param1);
               }
               else
               {
                  _loc5_(param1,param1.data);
               }
               if(param1.stopsImmediatePropagation)
               {
                  return true;
               }
               _loc6_++;
            }
            return param1.stopsPropagation;
         }
         return false;
      }
      
      function bubbleEvent(param1:Event) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function dispatchEventWith(param1:String, param2:Boolean = false, param3:Object = null) : void
      {
         var _loc4_:* = null;
         if(param2 || hasEventListener(param1))
         {
            _loc4_ = Event.fromPool(param1,param2,param3);
            dispatchEvent(_loc4_);
            Event.toPool(_loc4_);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         var _loc2_:Vector.<Function> = !!mEventListeners?mEventListeners[param1]:null;
         return !!_loc2_?_loc2_.length != 0:false;
      }
   }
}
