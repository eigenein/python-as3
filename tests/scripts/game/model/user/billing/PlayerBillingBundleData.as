package game.model.user.billing
{
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import game.command.timer.GameTimer;
   import game.data.storage.bundle.BundleDescription;
   import game.util.TimeFormatter;
   import org.osflash.signals.Signal;
   
   public class PlayerBillingBundleData
   {
       
      
      private var dict:Dictionary;
      
      private var bundleTimer:Timer;
      
      private var queue:Vector.<PlayerBillingBundleEntry>;
      
      private var _selectedIndex:int = -1;
      
      private var _signal_update:org.osflash.signals.Signal;
      
      private var _signal_init:idv.cjcat.signals.Signal;
      
      private var _signal_updateBundleTimeLeft:idv.cjcat.signals.Signal;
      
      public const signal_bundleWasShown:org.osflash.signals.Signal = new org.osflash.signals.Signal(BundleDescription);
      
      public function PlayerBillingBundleData()
      {
         dict = new Dictionary();
         bundleTimer = new Timer(1000);
         queue = new Vector.<PlayerBillingBundleEntry>();
         _signal_update = new org.osflash.signals.Signal(Boolean);
         _signal_init = new idv.cjcat.signals.Signal();
         _signal_updateBundleTimeLeft = new idv.cjcat.signals.Signal();
         super();
         bundleTimer.addEventListener("timer",handler_bundleTimer);
      }
      
      public function get selectedIndex() : int
      {
         return _selectedIndex;
      }
      
      public function get activeList() : Vector.<PlayerBillingBundleEntry>
      {
         var _loc2_:Vector.<PlayerBillingBundleEntry> = new Vector.<PlayerBillingBundleEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = queue;
         for each(var _loc1_ in queue)
         {
            if(_loc1_.available)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function get hasOnlyOneActiveBundle() : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = queue;
         for each(var _loc1_ in queue)
         {
            if(_loc1_.available)
            {
               _loc2_++;
               if(_loc2_ > 1)
               {
                  return false;
               }
            }
         }
         return _loc2_ == 1;
      }
      
      public function get needTimer() : Boolean
      {
         var _loc1_:PlayerBillingBundleEntry = this.activeBundle;
         return _loc1_ && _loc1_.endTime != 0;
      }
      
      public function get activeBundle() : PlayerBillingBundleEntry
      {
         if(_selectedIndex != -1 && _selectedIndex < queue.length)
         {
            return queue[_selectedIndex];
         }
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for each(var _loc1_ in dict)
         {
            if(_loc1_.available)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get bundleTimeLeft() : String
      {
         var _loc2_:int = !!activeBundle?activeBundle.endTime:0;
         var _loc1_:int = _loc2_ - GameTimer.instance.currentServerTime;
         if(_loc1_ <= 0)
         {
            return TimeFormatter.toMS2(0);
         }
         return TimeFormatter.toMS2(_loc1_);
      }
      
      public function get signal_update() : org.osflash.signals.Signal
      {
         return _signal_update;
      }
      
      public function get signal_init() : idv.cjcat.signals.Signal
      {
         return _signal_init;
      }
      
      public function get signal_updateBundleTimeLeft() : idv.cjcat.signals.Signal
      {
         return _signal_updateBundleTimeLeft;
      }
      
      public function initialize(param1:Array) : void
      {
         _update(param1);
         _signal_init.dispatch();
      }
      
      public function reset(param1:Array = null) : void
      {
         queue.length = 0;
         update(param1);
      }
      
      public function update(param1:Array = null) : void
      {
         var _loc2_:PlayerBillingBundleEntry = activeBundle;
         _update(param1);
         if(!_loc2_ && activeBundle || _loc2_ && activeBundle && _loc2_.id != activeBundle.id)
         {
            _signal_update.dispatch(activeBundle != null);
         }
         else
         {
            _signal_update.dispatch(false);
         }
      }
      
      public function dropBundle() : void
      {
         if(activeBundle)
         {
            activeBundle.dispose();
         }
         _signal_update.dispatch(false);
      }
      
      public function activeBundleWashShown() : void
      {
         signal_bundleWasShown.dispatch(activeBundle.desc);
      }
      
      public function selectBundle(param1:PlayerBillingBundleEntry) : void
      {
         var _loc2_:int = queue.indexOf(param1);
         if(_loc2_ != -1)
         {
            _selectedIndex = _loc2_;
         }
      }
      
      private function _update(param1:Array) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function handler_bundleTimer(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:PlayerBillingBundleEntry = this.activeBundle;
         if(_loc3_ && _loc3_.desc.duration)
         {
            _loc4_ = _loc3_.endTime;
            if(_loc4_ != 0)
            {
               _loc2_ = _loc4_ - GameTimer.instance.currentServerTime;
               if(_loc2_ <= 0)
               {
                  _loc3_.dispose();
                  update();
               }
               _signal_updateBundleTimeLeft.dispatch();
            }
         }
      }
   }
}
