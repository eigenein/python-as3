package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventCustomHeroInput extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var actionId:int;
      
      public function BattleLogEventCustomHeroInput(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         actionId = int(param1.readByte());
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:int) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         param1.writeByte(param3);
      }
      
      override public function toStringShort() : String
      {
         return "trigger " + heroId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Вручную использовано " + actionId + " действие героя " + param1.hero(heroId);
      }
   }
}
