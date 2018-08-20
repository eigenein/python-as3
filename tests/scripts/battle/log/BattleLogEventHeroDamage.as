package battle.log
{
   import battle.Hero;
   import battle.data.DamageType;
   import flash.Boot;
   
   public class BattleLogEventHeroDamage extends BattleLogEventHero2
   {
      
      public static var index:int;
       
      
      public var sourceValue:int;
      
      public var sourceSkillTier:int;
      
      public var resultValue:int;
      
      public var damageType:DamageType;
      
      public function BattleLogEventHeroDamage(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         sourceSkillTier = int(param1.readByte());
         resultValue = int(param1.readInt32());
         sourceValue = int(param1.readInt32());
         damageType = DamageType.byId(int(param1.readByte()));
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:int, param4:Hero, param5:int, param6:int, param7:DamageType) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         BattleLogEvent.writeHero(param1,param4);
         param1.writeByte(param3);
         param1.writeInt32(param5);
         param1.writeInt32(param6);
         param1.writeByte(param7.id);
      }
      
      override public function toStringShort() : String
      {
         return "Dmg " + heroId + ":" + sourceSkillTier + " > " + hero2Id + " " + resultValue + damageType.name.charAt(0) + " of " + sourceValue;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Герой " + param1.hero(heroId) + " нанёс " + resultValue + " " + damageType.name + " урона герою " + param1.hero(hero2Id) + " " + sourceSkillTier + " умением";
      }
   }
}
