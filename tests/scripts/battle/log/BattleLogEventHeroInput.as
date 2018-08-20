package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroInput extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public function BattleLogEventHeroInput(param1:BattleLogReader = undefined)
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
         return "manual " + heroId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Вручную использована ульта героя " + param1.hero(heroId);
      }
   }
}
