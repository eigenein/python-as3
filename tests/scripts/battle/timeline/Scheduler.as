package battle.timeline
{
   import flash.Boot;
   
   public class Scheduler extends TimelineObject
   {
      
      public static var pool:Vector.<CallbackNode> = new Vector.<CallbackNode>();
       
      
      public var timeline:Timeline;
      
      public var schedulerDisposed:Boolean;
      
      public var callbacks:Vector.<CallbackNode>;
      
      public function Scheduler(param1:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         schedulerDisposed = false;
         super();
         initialize(param1);
      }
      
      override public function toString() : String
      {
         return "Scheduler n=" + (callbacks == null?0:int(callbacks.length));
      }
      
      public function timelineAccess() : Timeline
      {
         return timeline;
      }
      
      override public function onTime(param1:Timeline) : void
      {
         var _loc3_:* = null as CallbackNode;
         var _loc6_:int = 0;
         var _loc7_:* = null as Vector.<CallbackNode>;
         var _loc9_:int = 0;
         var _loc2_:Number = param1.time;
         var _loc4_:int = 0;
         var _loc5_:int = callbacks.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc3_ = callbacks[_loc6_];
            if(_loc3_ != null && _loc3_.time <= _loc2_)
            {
               _loc7_ = Scheduler.pool;
               _loc7_.push(_loc3_);
               callbacks[_loc6_] = null;
               _loc3_.callback(this);
            }
         }
         _loc4_ = 0;
         var _loc8_:Number = Timeline.INFINITY_TIME;
         _loc5_ = 0;
         _loc6_ = callbacks.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc9_ = _loc5_;
            _loc3_ = callbacks[_loc9_];
            if(_loc3_ != null)
            {
               callbacks[_loc4_] = _loc3_;
               _loc4_++;
               if(_loc3_.time < _loc8_)
               {
                  _loc8_ = _loc3_.time;
               }
            }
         }
         callbacks.length = _loc4_;
         param1.update(this,_loc8_);
      }
      
      public function initialize(param1:Timeline) : void
      {
         time = Timeline.INFINITY_TIME;
         if(param1 != null)
         {
            timeline = param1;
            param1.add(this);
         }
         callbacks = new Vector.<CallbackNode>();
      }
      
      public function disposeCallback(param1:int) : void
      {
         var _loc2_:CallbackNode = callbacks[param1];
         if(_loc2_ != null)
         {
            Scheduler.pool.push(_loc2_);
            _loc2_.callback = null;
            callbacks[param1] = null;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:* = null as CallbackNode;
         var _loc1_:int = callbacks.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_ = callbacks[_loc1_];
            if(_loc2_ != null)
            {
               Scheduler.pool.push(_loc2_);
               _loc2_.callback = null;
               callbacks[_loc1_] = null;
            }
         }
         time = Timeline.INFINITY_TIME;
         timeline.remove(this);
         schedulerDisposed = true;
      }
      
      public function deferredSequence(param1:Number, param2:Number, param3:*, param4:* = undefined) : void
      {
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = param2;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            add(param3,Number(timeline.time + param1 * (_loc7_ + 1)));
         }
         if(param4 != null)
         {
            add(param4,Number(timeline.time + param1 * int(param2)));
         }
      }
      
      public function deferredAction(param1:Number, param2:*) : void
      {
         add(param2,Number(timeline.time + param1));
      }
      
      public function clearSchedule() : void
      {
         var _loc2_:* = null as CallbackNode;
         var _loc1_:int = callbacks.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_ = callbacks[_loc1_];
            if(_loc2_ != null)
            {
               Scheduler.pool.push(_loc2_);
               _loc2_.callback = null;
               callbacks[_loc1_] = null;
            }
         }
         timeline.update(this,Timeline.INFINITY_TIME);
      }
      
      public function add(param1:Function, param2:Number) : CallbackNode
      {
         var _loc3_:* = null as CallbackNode;
         if(param2 < timeline.time)
         {
            return null;
         }
         param2 = Math.round(param2 * 1000000000000) / 1000000000000;
         if(int(Scheduler.pool.length) == 0)
         {
            _loc3_ = new CallbackNode();
         }
         else
         {
            _loc3_ = Scheduler.pool.pop();
         }
         callbacks.push(_loc3_);
         _loc3_.callback = param1;
         _loc3_.time = param2;
         if(param2 < time)
         {
            if(schedulerDisposed)
            {
               schedulerDisposed = false;
               time = param2;
               timeline.add(this);
            }
            else
            {
               timeline.update(this,param2);
            }
         }
         return _loc3_;
      }
   }
}
