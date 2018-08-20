package game.util.logging
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class LogAggregator
   {
      
      protected static const groupsList:Vector.<LogGroup> = new Vector.<LogGroup>();
      
      protected static const groups:Dictionary = new Dictionary();
      
      public static const onGroupAdded:Signal = new Signal(LogGroup);
       
      
      public function LogAggregator()
      {
         super();
      }
      
      public static function getLogs() : Vector.<LogGroup>
      {
         return groupsList;
      }
      
      private static function addLog(param1:String, param2:String, param3:String) : void
      {
         getGroup(param1).addLog(param2,param3);
      }
      
      protected static function getGroup(param1:String) : LogGroup
      {
         var _loc2_:LogGroup = groups[param1];
         if(_loc2_ == null)
         {
            var _loc3_:* = new LogGroup(param1);
            groups[param1] = _loc3_;
            _loc2_ = _loc3_;
            groupsList.push(_loc2_);
            onGroupAdded.dispatch(_loc2_);
         }
         return _loc2_;
      }
      
      public static function onLogHandler(param1:String) : void
      {
         var _loc2_:Array = param1.split(" | ");
         var _loc3_:int = _loc2_[1].indexOf("::");
         var _loc5_:String = _loc2_[1].slice(0,_loc3_);
         var _loc4_:String = _loc2_[1].slice(_loc3_ + 2);
         _loc3_ = _loc2_[2].indexOf("] ");
         param1 = _loc2_[2].slice(_loc3_ + 2);
         addLog(_loc5_,_loc4_,param1);
      }
   }
}
