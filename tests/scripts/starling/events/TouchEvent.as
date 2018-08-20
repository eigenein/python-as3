package starling.events
{
   import starling.display.DisplayObject;
   
   public class TouchEvent extends Event
   {
      
      public static const TOUCH:String = "touch";
      
      private static var sTouches:Vector.<Touch> = new Vector.<Touch>(0);
       
      
      private var mShiftKey:Boolean;
      
      private var mCtrlKey:Boolean;
      
      private var mTimestamp:Number;
      
      private var mVisitedObjects:Vector.<EventDispatcher>;
      
      public function TouchEvent(param1:String, param2:Vector.<Touch>, param3:Boolean = false, param4:Boolean = false, param5:Boolean = true)
      {
         var _loc6_:int = 0;
         super(param1,param5,param2);
         mShiftKey = param3;
         mCtrlKey = param4;
         mTimestamp = -1;
         mVisitedObjects = new Vector.<EventDispatcher>(0);
         var _loc7_:int = param2.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            if(param2[_loc6_].timestamp > mTimestamp)
            {
               mTimestamp = param2[_loc6_].timestamp;
            }
            _loc6_++;
         }
      }
      
      public function getTouches(param1:DisplayObject, param2:String = null, param3:Vector.<Touch> = null) : Vector.<Touch>
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(param3 == null)
         {
            param3 = new Vector.<Touch>(0);
         }
         var _loc8_:Vector.<Touch> = data as Vector.<Touch>;
         var _loc9_:int = _loc8_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc7_ = _loc8_[_loc6_];
            _loc4_ = _loc7_.isTouching(param1);
            _loc5_ = param2 == null || param2 == _loc7_.phase;
            if(_loc4_ && _loc5_)
            {
               param3[param3.length] = _loc7_;
            }
            _loc6_++;
         }
         return param3;
      }
      
      public function getTouch(param1:DisplayObject, param2:String = null, param3:int = -1) : Touch
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         getTouches(param1,param2,sTouches);
         var _loc6_:int = sTouches.length;
         if(_loc6_ > 0)
         {
            _loc4_ = null;
            if(param3 < 0)
            {
               _loc4_ = sTouches[0];
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc6_)
               {
                  if(sTouches[_loc5_].id == param3)
                  {
                     _loc4_ = sTouches[_loc5_];
                     break;
                  }
                  _loc5_++;
               }
            }
            sTouches.length = 0;
            return _loc4_;
         }
         return null;
      }
      
      public function interactsWith(param1:DisplayObject) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         getTouches(param1,null,sTouches);
         _loc3_ = sTouches.length - 1;
         while(_loc3_ >= 0)
         {
            if(sTouches[_loc3_].phase != "ended")
            {
               _loc2_ = true;
               break;
            }
            _loc3_--;
         }
         sTouches.length = 0;
         return _loc2_;
      }
      
      function dispatch(param1:Vector.<EventDispatcher>) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Boolean = false;
         if(param1 && param1.length)
         {
            _loc2_ = !!bubbles?param1.length:1;
            _loc6_ = target;
            setTarget(param1[0] as EventDispatcher);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = param1[_loc4_] as EventDispatcher;
               if(mVisitedObjects.indexOf(_loc3_) == -1)
               {
                  _loc5_ = _loc3_.invokeEvent(this);
                  mVisitedObjects[mVisitedObjects.length] = _loc3_;
                  if(_loc5_)
                  {
                     break;
                  }
               }
               _loc4_++;
            }
            setTarget(_loc6_);
         }
      }
      
      public function get timestamp() : Number
      {
         return mTimestamp;
      }
      
      public function get touches() : Vector.<Touch>
      {
         return (data as Vector.<Touch>).concat();
      }
      
      public function get shiftKey() : Boolean
      {
         return mShiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return mCtrlKey;
      }
   }
}
