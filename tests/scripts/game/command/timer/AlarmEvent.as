package game.command.timer
{
   public class AlarmEvent
   {
       
      
      var key:String;
      
      public var time:Number;
      
      public var callback:Function;
      
      public var data;
      
      public function AlarmEvent(param1:Number, param2:String = null)
      {
         super();
         time = param1;
         key = param2;
      }
      
      public static function sortByTime(param1:AlarmEvent, param2:AlarmEvent) : int
      {
         return param1.time > param2.time?1:Number(param1.time < param2.time?-1:0);
      }
   }
}
