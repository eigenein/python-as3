package feathers.events
{
   import flash.utils.Dictionary;
   import starling.display.DisplayObject;
   import starling.display.Stage;
   import starling.events.EventDispatcher;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   [Event(name="change",type="starling.events.Event")]
   public class ExclusiveTouch extends EventDispatcher
   {
      
      protected static const stageToObject:Dictionary = new Dictionary(true);
       
      
      protected var _stageListenerCount:int = 0;
      
      protected var _stage:Stage;
      
      protected var _claims:Dictionary;
      
      public function ExclusiveTouch(param1:Stage)
      {
         _claims = new Dictionary();
         super();
         if(!param1)
         {
            throw new ArgumentError("Stage cannot be null.");
         }
         this._stage = param1;
      }
      
      public static function forStage(param1:Stage) : ExclusiveTouch
      {
         if(!param1)
         {
            throw new ArgumentError("Stage cannot be null.");
         }
         var _loc2_:ExclusiveTouch = ExclusiveTouch(stageToObject[param1]);
         if(_loc2_)
         {
            return _loc2_;
         }
         _loc2_ = new ExclusiveTouch(param1);
         stageToObject[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function disposeForStage(param1:Stage) : void
      {
      }
      
      public function claimTouch(param1:int, param2:DisplayObject) : Boolean
      {
         if(!param2)
         {
            throw new ArgumentError("Target cannot be null.");
         }
         if(param2.stage != this._stage)
         {
            throw new ArgumentError("Target cannot claim a touch on the selected stage because it appears on a different stage.");
         }
         if(param1 < 0)
         {
            throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
         }
         var _loc3_:DisplayObject = DisplayObject(this._claims[param1]);
         if(_loc3_)
         {
            return false;
         }
         this._claims[param1] = param2;
         if(this._stageListenerCount == 0)
         {
            this._stage.addEventListener("touch",stage_touchHandler);
         }
         this._stageListenerCount++;
         this.dispatchEventWith("change",false,param1);
         return true;
      }
      
      public function removeClaim(param1:int) : void
      {
         var _loc2_:DisplayObject = DisplayObject(this._claims[param1]);
         if(!_loc2_)
         {
            return;
         }
         delete this._claims[param1];
         this.dispatchEventWith("change",false,param1);
      }
      
      public function getClaim(param1:int) : DisplayObject
      {
         if(param1 < 0)
         {
            throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
         }
         return DisplayObject(this._claims[param1]);
      }
      
      protected function stage_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = this._claims;
         for(var _loc4_ in this._claims)
         {
            _loc2_ = _loc4_ as int;
            _loc3_ = param1.getTouch(this._stage,"ended",_loc2_);
            if(_loc3_)
            {
               delete this._claims[_loc4_];
               this._stageListenerCount--;
            }
         }
         if(this._stageListenerCount == 0)
         {
            this._stage.removeEventListener("touch",stage_touchHandler);
         }
      }
   }
}
