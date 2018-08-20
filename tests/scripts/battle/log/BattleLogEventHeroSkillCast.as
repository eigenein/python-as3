package battle.log
{
   import battle.Hero;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class BattleLogEventHeroSkillCast extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var skillTierId:int;
      
      public function BattleLogEventHeroSkillCast(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         skillTierId = int(readSkill(param1));
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:SkillCast) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         BattleLogEvent.writeSkill(param1,param3.skill);
      }
      
      override public function toStringShort() : String
      {
         return "cast " + heroId + ":" + skillTierId;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "Герой " + param1.hero(heroId) + " применил умение " + param1.skill(skillTierId,heroId);
      }
   }
}
