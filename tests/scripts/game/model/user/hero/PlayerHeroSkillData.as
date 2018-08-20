package game.model.user.hero
{
   import flash.utils.Dictionary;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.skills.SkillDescription;
   
   public class PlayerHeroSkillData
   {
       
      
      private var levelsByTier:Dictionary;
      
      private var levelsBySkill:Dictionary;
      
      private var _skillList:Vector.<PlayerHeroSkill>;
      
      public function PlayerHeroSkillData(param1:Vector.<SkillDescription>, param2:Object = null)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         super();
         _skillList = new Vector.<PlayerHeroSkill>();
         levelsBySkill = new Dictionary();
         levelsByTier = new Dictionary();
         if(param1)
         {
            _loc4_ = param1.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = new PlayerHeroSkill(param1[_loc5_],param2[param1[_loc5_].id]);
               levelsBySkill[param1[_loc5_]] = _loc3_;
               levelsByTier[param1[_loc5_].tier] = _loc3_;
               _skillList.push(_loc3_);
               _loc5_++;
            }
         }
         _skillList.sort(sort_skillByTier);
      }
      
      private static function sort_skillByTier(param1:PlayerHeroSkill, param2:PlayerHeroSkill) : int
      {
         return param1.skill.tier - param2.skill.tier;
      }
      
      public function getSkillList() : Vector.<PlayerHeroSkill>
      {
         return _skillList;
      }
      
      public function getLevelBySkill(param1:SkillDescription) : PlayerHeroSkill
      {
         return levelsBySkill[param1];
      }
      
      public function getLevelByTier(param1:int) : PlayerHeroSkill
      {
         return levelsByTier[param1];
      }
      
      public function clone() : PlayerHeroSkillData
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Object = {};
         var _loc1_:Vector.<SkillDescription> = new Vector.<SkillDescription>(0);
         var _loc2_:int = _skillList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _skillList[_loc4_];
            _loc1_.push(_loc3_.skill);
            _loc5_[_loc3_.skill.id] = _loc3_.level;
            _loc4_++;
         }
         return new PlayerHeroSkillData(_loc1_,_loc5_);
      }
      
      function createSkillsOnPromotion(param1:HeroColorData) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = param1.skillTierAvailable;
         while(_loc2_ >= 0)
         {
            _loc3_ = levelsByTier[_loc2_];
            if(_loc3_)
            {
               if(_loc3_.level == 0)
               {
                  _loc3_.init();
               }
               else
               {
                  return;
               }
            }
            _loc2_--;
         }
      }
      
      function upgradeSkill(param1:int) : void
      {
         (levelsByTier[param1] as PlayerHeroSkill).levelUp();
      }
      
      function upgradeSkillBoost(param1:int, param2:int) : void
      {
         (levelsByTier[param1] as PlayerHeroSkill).levelBoost(param2);
      }
   }
}
