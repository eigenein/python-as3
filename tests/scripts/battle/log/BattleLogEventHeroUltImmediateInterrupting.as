package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroUltImmediateInterrupting extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public function BattleLogEventHeroUltImmediateInterrupting(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero) : void
      {
         BattleLogEvent.writeHero(param1,param2);
      }
      
      override public function toStringShort() : String
      {
         return "ultStart " + heroId + " immediate";
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Начата ульта героя " + param1.hero(heroId) + " (ручной режим)";
      }
   }
}
