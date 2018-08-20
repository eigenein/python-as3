package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroMove extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var speed:Number;
      
      public var position:Number;
      
      public function BattleLogEventHeroMove(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         speed = int(param1.readInt32()) / 1000;
         position = int(param1.readInt32()) / 1000;
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:Number, param4:Number) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         param1.writeInt32(int(Math.round(param3 * 1000)));
         param1.writeInt32(int(Math.round(param4 * 1000)));
      }
      
      override public function toStringShort() : String
      {
         return "speed " + heroId + " " + speed + " at " + position;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Герой " + param1.hero(heroId) + (speed == 0?" остановился":" получил скорость " + speed) + " в позиции " + position;
      }
   }
}
