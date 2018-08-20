package game.command.rpc.stash
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.model.GameModel;
   
   public class StashEventAggregator
   {
      
      private static var queue:Vector.<StashEventDescription>;
      
      private static var flushTimer:Timer;
      
      private static var flushInterval:int = 5000;
       
      
      public function StashEventAggregator()
      {
         super();
      }
      
      public static function add(param1:StashEventDescription) : void
      {
         if(!queue)
         {
            queue = new Vector.<StashEventDescription>();
         }
         if(!flushTimer)
         {
            flushTimer = new Timer(flushInterval);
            flushTimer.addEventListener("timer",handler_timer);
            flushTimer.start();
         }
         queue.push(param1);
      }
      
      public static function flush() : Vector.<StashEventDescription>
      {
         var _loc1_:Vector.<StashEventDescription> = queue.slice();
         queue = new Vector.<StashEventDescription>();
         return _loc1_;
      }
      
      protected static function handler_timer(param1:TimerEvent) : void
      {
         GameModel.instance.actionManager.stashEvent_flush();
      }
   }
}
