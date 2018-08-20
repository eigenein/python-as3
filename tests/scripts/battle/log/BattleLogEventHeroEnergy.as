package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroEnergy extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var oldValue:Number;
      
      public var delta:Number;
      
      public function BattleLogEventHeroEnergy(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         oldValue = Number(param1.readFloat());
         delta = Number(param1.readFloat());
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:Number, param4:Number) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         param1.writeFloat(param3);
         param1.writeFloat(param4);
      }
      
      override public function toStringShort() : String
      {
         return "E  " + heroId + " " + oldValue + "+=" + delta;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Энергия героя " + param1.hero(heroId) + " изменилось на `" + delta + "` (было " + oldValue + ")";
      }
   }
}
