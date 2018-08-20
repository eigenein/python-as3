package game.util.logging
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class LogGroup
   {
       
      
      public const onLogAdded:Signal = new Signal(Log);
      
      public var name:String;
      
      protected var logsList:Vector.<Log>;
      
      protected var logs:Dictionary;
      
      public function LogGroup(param1:String)
      {
         super();
         this.name = param1;
         logsList = new Vector.<Log>();
         logs = new Dictionary();
      }
      
      public function getLogs() : Vector.<Log>
      {
         return logsList;
      }
      
      public function addLog(param1:String, param2:String) : void
      {
         var _loc3_:Log = logs[param1];
         if(_loc3_ == null)
         {
            var _loc5_:* = new Log(param1);
            logs[param1] = _loc5_;
            _loc3_ = _loc5_;
            logsList.push(_loc3_);
            onLogAdded.dispatch(_loc3_);
         }
         var _loc4_:LogRecord = _loc3_.addLog(param1,param2);
      }
   }
}
