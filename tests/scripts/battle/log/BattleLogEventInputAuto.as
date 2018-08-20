package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventInputAuto extends BattleLogEvent
   {
      
      public static var index:int;
       
      
      public var attackers:Boolean;
      
      public function BattleLogEventInputAuto(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         if(int(param1.readByte()) > 0)
         {
            attackers = true;
         }
         else
         {
            attackers = false;
         }
      }
      
      public static function write(param1:BattleLogWriter, param2:Boolean) : void
      {
         param1.writeByte(!!param2?1:0);
      }
      
      override public function toStringShort() : String
      {
         return "auto " + (!!attackers?"ATK":"DEF");
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Переключён режим Авто " + (!!attackers?"атакующих":"защитников");
      }
   }
}
