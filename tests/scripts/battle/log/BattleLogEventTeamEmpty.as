package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventTeamEmpty extends BattleLogEvent
   {
      
      public static var index:int;
       
      
      public var attackersEmpty:Boolean;
      
      public function BattleLogEventTeamEmpty(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         if(int(param1.readByte()) > 0)
         {
            attackersEmpty = true;
         }
         else
         {
            attackersEmpty = false;
         }
      }
      
      public static function write(param1:BattleLogWriter, param2:Boolean) : void
      {
         param1.writeByte(!!param2?1:0);
      }
      
      override public function toStringShort() : String
      {
         return "teamEmpty " + (!!attackersEmpty?"ATK":"DEF");
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Команда " + (!!attackersEmpty?"атакующих":"защитников") + " пуста";
      }
   }
}
