package game.util.logging
{
   public class LogRecord
   {
       
      
      public var time:Date;
      
      public var message:String;
      
      public var type:String;
      
      public function LogRecord(param1:String, param2:String)
      {
         super();
         this.time = new Date();
         this.type = param1;
         this.message = param2;
      }
      
      public static function compareFunction(param1:LogRecord, param2:LogRecord) : int
      {
         return param1.time.time - param2.time.time;
      }
      
      public function toString() : String
      {
         return type + ": " + message;
      }
   }
}
