package starling.events
{
   import flash.utils.getQualifiedClassName;
   import starling.utils.formatString;
   
   public class Event
   {
      
      public static const ADDED:String = "added";
      
      public static const ADDED_TO_STAGE:String = "addedToStage";
      
      public static const ENTER_FRAME:String = "enterFrame";
      
      public static const REMOVED:String = "removed";
      
      public static const REMOVED_FROM_STAGE:String = "removedFromStage";
      
      public static const TRIGGERED:String = "triggered";
      
      public static const FLATTEN:String = "flatten";
      
      public static const RESIZE:String = "resize";
      
      public static const COMPLETE:String = "complete";
      
      public static const CONTEXT3D_CREATE:String = "context3DCreate";
      
      public static const ROOT_CREATED:String = "rootCreated";
      
      public static const REMOVE_FROM_JUGGLER:String = "removeFromJuggler";
      
      public static const TEXTURES_RESTORED:String = "texturesRestored";
      
      public static const IO_ERROR:String = "ioError";
      
      public static const SECURITY_ERROR:String = "securityError";
      
      public static const PARSE_ERROR:String = "parseError";
      
      public static const FATAL_ERROR:String = "fatalError";
      
      public static const CHANGE:String = "change";
      
      public static const CANCEL:String = "cancel";
      
      public static const SCROLL:String = "scroll";
      
      public static const OPEN:String = "open";
      
      public static const CLOSE:String = "close";
      
      public static const SELECT:String = "select";
      
      private static var sEventPool:Vector.<Event> = new Vector.<Event>(0);
       
      
      private var mTarget:EventDispatcher;
      
      private var mCurrentTarget:EventDispatcher;
      
      private var mType:String;
      
      private var mBubbles:Boolean;
      
      private var mStopsPropagation:Boolean;
      
      private var mStopsImmediatePropagation:Boolean;
      
      private var mData:Object;
      
      public function Event(param1:String, param2:Boolean = false, param3:Object = null)
      {
         super();
         mType = param1;
         mBubbles = param2;
         mData = param3;
      }
      
      static function fromPool(param1:String, param2:Boolean = false, param3:Object = null) : Event
      {
         if(sEventPool.length)
         {
            return sEventPool.pop().reset(param1,param2,param3);
         }
         return new Event(param1,param2,param3);
      }
      
      static function toPool(param1:Event) : void
      {
         var _loc2_:* = null;
         param1.mCurrentTarget = _loc2_;
         _loc2_ = _loc2_;
         param1.mTarget = _loc2_;
         param1.mData = _loc2_;
         sEventPool[sEventPool.length] = param1;
      }
      
      public function stopPropagation() : void
      {
         mStopsPropagation = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         mStopsImmediatePropagation = true;
         mStopsPropagation = true;
      }
      
      public function toString() : String
      {
         return formatString("[{0} type=\"{1}\" bubbles={2}]",getQualifiedClassName(this).split("::").pop(),mType,mBubbles);
      }
      
      public function get bubbles() : Boolean
      {
         return mBubbles;
      }
      
      public function get target() : EventDispatcher
      {
         return mTarget;
      }
      
      public function get currentTarget() : EventDispatcher
      {
         return mCurrentTarget;
      }
      
      public function get type() : String
      {
         return mType;
      }
      
      public function get data() : Object
      {
         return mData;
      }
      
      function setTarget(param1:EventDispatcher) : void
      {
         mTarget = param1;
      }
      
      function setCurrentTarget(param1:EventDispatcher) : void
      {
         mCurrentTarget = param1;
      }
      
      function setData(param1:Object) : void
      {
         mData = param1;
      }
      
      function get stopsPropagation() : Boolean
      {
         return mStopsPropagation;
      }
      
      function get stopsImmediatePropagation() : Boolean
      {
         return mStopsImmediatePropagation;
      }
      
      function reset(param1:String, param2:Boolean = false, param3:Object = null) : Event
      {
         mType = param1;
         mBubbles = param2;
         mData = param3;
         mCurrentTarget = null;
         mTarget = null;
         mStopsImmediatePropagation = false;
         mStopsPropagation = false;
         return this;
      }
   }
}
