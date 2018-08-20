package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventString extends BattleLogEvent
   {
      
      public static var index:int;
       
      
      public var string:String;
      
      public function BattleLogEventString(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         string = param1.readEncodedString();
      }
      
      public static function write(param1:BattleLogWriter, param2:String) : void
      {
         param1.writeEncodedString(param2);
      }
      
      override public function toStringShort() : String
      {
         return string;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return string;
      }
   }
}
