package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroHp extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var oldValue:Number;
      
      public var delta:Number;
      
      public function BattleLogEventHeroHp(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         oldValue = int(param1.readInt32());
         delta = int(param1.readInt32());
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:int, param4:int) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         param1.writeInt32(param3);
         param1.writeInt32(param4);
      }
      
      override public function toStringShort() : String
      {
         return "Hp " + heroId + " " + oldValue + "+=" + delta;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Здоровье героя " + param1.hero(heroId) + " изменилось на `" + delta + "` (было " + oldValue + ")";
      }
   }
}
