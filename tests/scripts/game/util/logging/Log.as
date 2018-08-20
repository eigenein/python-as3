package game.util.logging
{
   import idv.cjcat.signals.Signal;
   
   public class Log
   {
       
      
      public const onRecordAdded:Signal = new Signal(LogRecord);
      
      public var name:String;
      
      public var logs:Vector.<LogRecord>;
      
      public function Log(param1:String)
      {
         super();
         this.name = param1;
         logs = new Vector.<LogRecord>();
      }
      
      public function getRecords() : Vector.<LogRecord>
      {
         return logs;
      }
      
      public function addLog(param1:String, param2:String) : LogRecord
      {
         var _loc3_:LogRecord = new LogRecord(param1,param2);
         logs.push(_loc3_);
         onRecordAdded.dispatch(_loc3_);
         return _loc3_;
      }
   }
}
