package battle.events
{
   import battle.timeline.Timeline;
   import battle.timeline.TimelineObject;
   import flash.Boot;
   
   public class BattleSignal extends TimelineObject
   {
       
      
      public var listeners:Vector.<Function>;
      
      public function BattleSignal()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      public function remove(param1:Function) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Vector.<Function>;
         var _loc4_:* = 0;
         if(listeners != null)
         {
            _loc2_ = listeners.indexOf(param1);
            if(_loc2_ != -1)
            {
               _loc3_ = listeners;
               _loc4_ = int(_loc3_.length) - 1;
               if(_loc4_ >= 0)
               {
                  _loc3_[_loc2_] = _loc3_[_loc4_];
                  _loc3_.length = _loc4_;
               }
            }
         }
      }
      
      override public function onTime(param1:Timeline) : void
      {
         var _loc4_:* = null as Function;
         time = Timeline.INFINITY_TIME;
         var _loc2_:Vector.<Function> = listeners;
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc4_();
         }
      }
      
      public function add(param1:Function) : void
      {
         if(listeners == null)
         {
            listeners = new Vector.<Function>();
         }
         listeners.push(param1);
      }
   }
}
