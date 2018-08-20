package game.model.user.hero
{
   import game.data.storage.skills.SkillDescription;
   
   public class PlayerHeroSkill
   {
       
      
      private var _skill:SkillDescription;
      
      private var _level:int;
      
      public function PlayerHeroSkill(param1:SkillDescription, param2:int)
      {
         super();
         _level = param2;
         _skill = param1;
      }
      
      public function get skill() : SkillDescription
      {
         return _skill;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get visibleLevel() : int
      {
         return Math.max(1,_level - _skill.visibleLevelOffset);
      }
      
      function levelUp() : void
      {
         _level = Number(_level) + 1;
      }
      
      function levelBoost(param1:int) : void
      {
         _level = param1;
      }
      
      function init() : void
      {
         if(_level == 0)
         {
            _level = _skill.visibleLevelOffset + 1;
         }
      }
   }
}
