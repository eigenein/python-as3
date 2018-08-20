package battle.log
{
   import battle.Hero;
   import flash.Boot;
   
   public class BattleLogEventHeroAbsorb extends BattleLogEventHero2
   {
      
      public static var index:int;
       
      
      public var value:int;
      
      public var sourceSkillId:int;
      
      public var skillId:int;
      
      public function BattleLogEventHeroAbsorb(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         skillId = int(param1.readByte());
         sourceSkillId = int(param1.readByte());
         value = int(param1.readInt32());
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:int, param4:Hero, param5:int, param6:int) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         BattleLogEvent.writeHero(param1,param4);
         param1.writeByte(param3);
         param1.writeByte(param5);
         param1.writeInt32(param6);
      }
      
      override public function toStringShort() : String
      {
         return "absorb " + value + " of " + heroId + ":" + hero2Id + " by " + heroId + ":" + skillId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return skillId + " умение героя " + param1.hero(heroId) + " поглотило " + value + " урона от " + param1.skill(sourceSkillId,hero2Id) + " героя " + param1.hero(hero2Id);
      }
   }
}
