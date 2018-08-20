package engine.debug
{
   import engine.core.assets.AssetLoader;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.tutorial.ITutorialConditionListener;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialLibCondition;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.Stage;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchProcessor;
   
   public class ClickLoger implements ITutorialConditionListener, IAnimatable
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      private static var instance:ClickLoger;
       
      
      private var touchProcessor:TouchProcessor;
      
      private var replaying:Boolean;
      
      private var replayQueue:Vector.<RecordEvent>;
      
      private var eventToWait:RecordEvent;
      
      private var queue:Vector.<DelayedClick>;
      
      private var lastEventTime:int = -1;
      
      private var recording:Boolean;
      
      private var records:Vector.<RecordEvent>;
      
      private var recordData:String = "";
      
      private var touchPointID:int;
      
      public function ClickLoger()
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         queue = new Vector.<DelayedClick>();
         records = new Vector.<RecordEvent>();
         super();
         instance = this;
         touchProcessor = Starling.current.touchProcessor;
         Starling.current.stage.addEventListener("touch",handler_touch);
         Starling.juggler.add(this);
         var _loc2_:TutorialLibCondition = new TutorialLibCondition("dialogOpen",null);
         _loc2_.listener = this;
         Tutorial.events.addCondition(_loc2_);
         AssetStorage.instance.globalLoader.eventComplete.add(trigger_completeLoading);
         startRecording();
         _loc3_ = recordData.split("\r\n");
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_)
            {
               _loc1_ = _loc4_.split(" ");
               addRecord(_loc1_[1],!!_loc1_[2]?_loc1_[2].split(","):[],_loc1_[0]);
            }
         }
         stopRecording();
      }
      
      public static function trigger_dialogOpen(param1:String) : void
      {
         if(!instance)
         {
         }
      }
      
      public static function trigger_guiState() : void
      {
         if(instance)
         {
            instance.trigger("guiState",[]);
         }
      }
      
      public static function trigger_tutorialCondition() : void
      {
         if(instance)
         {
            instance.trigger("tutorialCondition",[]);
         }
      }
      
      public static function trigger_completeLoading(param1:AssetLoader) : void
      {
         if(instance)
         {
            instance.trigger("completeLoading",[]);
         }
      }
      
      public static function startRecording() : void
      {
         instance.recording = true;
      }
      
      public static function stopRecording() : void
      {
         instance.recording = false;
      }
      
      public static function startReplay() : void
      {
         instance._startReplay();
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = queue.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = queue[_loc4_];
            _loc2_.delay = _loc2_.delay - param1;
            if(_loc2_.delay < 0)
            {
               touchProcessor.enqueue(_loc4_,"began",_loc2_.x,_loc2_.y);
               touchProcessor.enqueue(_loc4_,"ended",_loc2_.x,_loc2_.y);
               _loc2_.delay = 0.15 * _loc4_ + 0.15;
            }
            _loc4_++;
         }
      }
      
      public function triggerCondition(param1:TutorialCondition) : void
      {
         instance.queue.push(new DelayedClick(823,96,0.1,"ended"));
      }
      
      private function _startReplay() : void
      {
         replaying = true;
         replayQueue = records.concat();
         reverse(replayQueue);
         nextEvent();
      }
      
      protected function nextEvent() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:RecordEvent = replayQueue.pop();
         if(!_loc1_)
         {
            return;
         }
         if(_loc1_.event == "click")
         {
            _loc2_ = _loc1_.params[0];
            _loc3_ = _loc1_.params[1];
            trace("replay click",_loc2_,_loc3_);
            queue.push(new DelayedClick(_loc2_,_loc3_,0.15,"ended"));
            nextEvent();
         }
         else
         {
            trace("replay wait for",_loc1_);
            eventToWait = _loc1_;
         }
      }
      
      protected function trigger(param1:String, param2:Array) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function addRecord(param1:String, param2:Array, param3:Number = NaN) : void
      {
         var _loc5_:int = 0;
         if(param3 != param3)
         {
            param3 = getTimer();
            if(lastEventTime == -1)
            {
               _loc5_ = 0;
               lastEventTime = param3;
            }
            else
            {
               _loc5_ = param3 - lastEventTime;
               lastEventTime = _loc5_ + lastEventTime;
            }
         }
         else
         {
            _loc5_ = 20;
         }
         var _loc4_:RecordEvent = new RecordEvent(_loc5_,param1,param2);
         var _loc6_:int = records.length;
         if(_loc4_.event == "click" && _loc6_ > 0 && _loc5_ <= 15)
         {
            while(_loc6_ >= 1 && (records[_loc6_ - 1].event == "dialogOpen" || records[_loc6_ - 1].event == "guiState" || records[_loc6_ - 1].event == "tutorialCondition"))
            {
               _loc6_--;
               if(records[_loc6_].time <= 15)
               {
                  continue;
               }
               break;
            }
            records.splice(_loc6_,0,_loc4_);
         }
         else
         {
            records[_loc6_] = _loc4_;
         }
      }
      
      protected function handler_touch(param1:TouchEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:Stage = Starling.current.stage;
         if(!recording)
         {
            this.touchPointID = -1;
            return;
         }
         if(this.touchPointID >= 0)
         {
            _loc4_ = param1.getTouch(_loc2_,null,this.touchPointID);
            if(!_loc4_)
            {
               return;
            }
            _loc4_.getLocation(_loc2_,HELPER_POINT);
            _loc3_ = _loc2_.contains(_loc2_.hitTest(HELPER_POINT,true));
            if(_loc4_.phase == "ended")
            {
               if(recording)
               {
                  addRecord("click",[HELPER_POINT.x,HELPER_POINT.y]);
               }
            }
            if(_loc4_.phase == "moved")
            {
               if(_loc3_)
               {
               }
            }
            else if(_loc4_.phase == "ended")
            {
               if(!_loc3_)
               {
               }
               touchPointID = -1;
            }
            return;
         }
         _loc4_ = param1.getTouch(_loc2_,"began");
         if(_loc4_)
         {
            this.touchPointID = _loc4_.id;
            return;
         }
         _loc4_ = param1.getTouch(_loc2_,"hover");
         if(_loc4_)
         {
            return;
         }
      }
      
      private function reverse(param1:Vector.<RecordEvent>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}

class DelayedClick
{
    
   
   public var x:Number;
   
   public var y:Number;
   
   public var delay:Number;
   
   function DelayedClick(param1:Number, param2:Number, param3:Number, param4:String)
   {
      super();
      this.x = param1;
      this.y = param2;
      this.delay = param3;
   }
}

class RecordEvent
{
    
   
   public var time:int;
   
   public var event:String;
   
   public var params:Array;
   
   function RecordEvent(param1:int, param2:String, param3:Array)
   {
      super();
      this.time = param1;
      this.event = param2;
      this.params = param3;
   }
   
   public static function parse(param1:String) : RecordEvent
   {
      var _loc2_:RecordEvent = new RecordEvent(0,null,null);
      _loc2_.params = param1.split(" ");
      _loc2_.time = _loc2_.params[0];
      _loc2_.event = _loc2_.params[1];
      _loc2_.params = _loc2_.params[2].split(",");
      return _loc2_;
   }
   
   public function toString() : String
   {
      return time + " " + event + " " + params;
   }
}
