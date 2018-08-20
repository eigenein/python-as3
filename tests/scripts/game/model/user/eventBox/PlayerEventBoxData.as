package game.model.user.eventBox
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class PlayerEventBoxData
   {
       
      
      private var boxes:Dictionary;
      
      public var signal_update:Signal;
      
      public function PlayerEventBoxData()
      {
         boxes = new Dictionary();
         signal_update = new Signal(int);
         super();
      }
      
      public function init(param1:Object) : void
      {
         if(param1)
         {
            var _loc4_:int = 0;
            var _loc3_:* = param1;
            for(var _loc2_ in param1)
            {
               add(_loc2_,param1[_loc2_]);
            }
         }
      }
      
      public function getFreeBoxId() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = boxes;
         for(var _loc1_ in boxes)
         {
            if(boxes[_loc1_] > 0)
            {
               return _loc1_;
            }
         }
         return -1;
      }
      
      public function getBoxCount(param1:int) : int
      {
         return int(boxes[param1]);
      }
      
      public function add(param1:int, param2:int) : void
      {
         boxes[param1] = int(boxes[param1]) + param2;
         signal_update.dispatch(param2);
      }
      
      public function remove(param1:int, param2:*) : void
      {
         boxes[param1] = Math.max(0,int(boxes[param1]) - param2);
         signal_update.dispatch(-param2);
      }
   }
}
