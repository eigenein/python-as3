package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventTeamInput extends BattleLogEvent
   {
      
      public static var index:int;
       
      
      public var attackers:Boolean;
      
      public var actionId:int;
      
      public function BattleLogEventTeamInput(param1:BattleLogReader = undefined)
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
         actionId = int(param1.readByte());
      }
      
      public static function write(param1:BattleLogWriter, param2:Boolean, param3:int) : void
      {
         param1.writeByte(!!param2?1:0);
         param1.writeByte(param3);
      }
      
      override public function toStringShort() : String
      {
         return "teamInput " + actionId + " " + (!!attackers?"ATK":"DEF");
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Использовано командное действие " + actionId + " " + (!!attackers?"атакующих":"защитников");
      }
   }
}
