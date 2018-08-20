package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroDead extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public function BattleLogEventHeroDead(param1:BattleLogReader = undefined)
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
         return "dead " + heroId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Герой " + param1.hero(heroId) + " мёртв";
      }
   }
}
