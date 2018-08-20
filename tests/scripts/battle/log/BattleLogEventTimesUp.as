package battle.log
{
   import battle.Team;
   import flash.Boot;
   
   public class BattleLogEventTimesUp extends BattleLogEvent
   {
      
      public static var index:int;
       
      
      public var defenders:Vector.<int>;
      
      public var attackers:Vector.<int>;
      
      public function BattleLogEventTimesUp(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         attackers = readTeam(param1);
         defenders = readTeam(param1);
      }
      
      public static function write(param1:BattleLogWriter, param2:Team, param3:Team) : void
      {
         BattleLogEvent.writeTeam(param1,param2);
         BattleLogEvent.writeTeam(param1,param3);
      }
      
      override public function toStringShort() : String
      {
         return "timesUp " + Std.string(attackers) + " vs " + Std.string(defenders);
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Время вышло. Состав оставшихся команд: " + Std.string(attackers) + " vs " + Std.string(defenders);
      }
   }
}
