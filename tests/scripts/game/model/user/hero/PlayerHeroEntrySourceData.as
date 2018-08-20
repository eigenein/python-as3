package game.model.user.hero
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   
   public class PlayerHeroEntrySourceData extends HeroEntrySourceData
   {
       
      
      public var runes:Array;
      
      public var artifacts:Array;
      
      public var skills:Object;
      
      public var skins:Object;
      
      public var currentSkin:uint;
      
      public var titanGiftLevel:uint;
      
      public var titanCoinsSpent:uint;
      
      private var _xp:int;
      
      public function PlayerHeroEntrySourceData(param1:Object = null)
      {
         super(param1);
         if(param1)
         {
            skills = param1.skills;
            runes = param1.runes;
            artifacts = param1.artifacts;
            skins = param1.skins;
            currentSkin = param1.currentSkin;
            titanGiftLevel = param1.titanGiftLevel;
            titanCoinsSpent = DataStorage.rule.titanGiftResource.resolvePlayerHeroCurrencySpent(param1.titanCoinsSpent);
         }
      }
      
      public static function createEmpty(param1:HeroDescription) : PlayerHeroEntrySourceData
      {
         var _loc3_:int = 0;
         var _loc4_:PlayerHeroEntrySourceData = new PlayerHeroEntrySourceData();
         _loc4_.skills = [];
         var _loc2_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(param1.id);
         var _loc5_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if(param1.startingColor.skillTierAvailable >= _loc2_[_loc3_].tier)
            {
               _loc4_.skills[_loc2_[_loc3_].id] = DataStorage.enum.getbyId_SkillTier(_loc2_[_loc3_].tier).skillMinLevel + 1;
            }
            _loc3_++;
         }
         _loc4_.star = param1.startingStar.star.id;
         _loc4_.color = param1.startingColor.color.id;
         _loc4_.id = param1.id;
         return _loc4_;
      }
      
      override public function set level(param1:int) : void
      {
         _level = param1;
         _xp = DataStorage.level.getHeroLevel(_level).exp;
      }
      
      public function get xp() : int
      {
         return _xp;
      }
      
      public function set xp(param1:int) : void
      {
         _xp = param1;
         _level = DataStorage.level.getHeroLevelByExp(_xp).level;
      }
      
      public function setSkillLevels(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(id);
         var _loc4_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1[_loc2_[_loc3_].id])
            {
               this.skills[_loc2_[_loc3_].id] = param1[_loc2_[_loc3_].id];
            }
            _loc3_++;
         }
      }
      
      override protected function parseLevel(param1:Object) : void
      {
         if(param1.xp)
         {
            xp = param1.xp;
            return;
         }
         if(param1.lvl)
         {
            level = param1.lvl;
         }
         else if(param1.level)
         {
            level = param1.level;
         }
      }
   }
}
