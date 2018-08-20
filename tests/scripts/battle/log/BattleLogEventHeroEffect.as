package battle.log
{
   import battle.Hero;
   import battle.skills.Effect;
   import flash.Boot;
   
   public class BattleLogEventHeroEffect extends BattleLogEventHero2
   {
      
      public static var index:int;
       
      
      public var sourceSkillId:int;
      
      public var effect:String;
      
      public function BattleLogEventHeroEffect(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         effect = param1.readEncodedString();
         sourceSkillId = int(readSkill(param1));
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:Effect) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         BattleLogEvent.writeHero(param1,param3.skillCast.hero);
         param1.writeEncodedString(param3.ident);
         BattleLogEvent.writeSkill(param1,param3.skillCast.skill);
      }
      
      override public function toStringShort() : String
      {
         return "effect " + heroId + " " + effect + " from " + hero2Id + ":" + sourceSkillId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "На героя " + param1.hero(heroId) + " наложен эффект " + effect + " от " + param1.skill(sourceSkillId,hero2Id) + " героя " + param1.hero(hero2Id);
      }
   }
}
