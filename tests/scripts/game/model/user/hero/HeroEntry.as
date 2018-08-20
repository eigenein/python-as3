package game.model.user.hero
{
   import battle.BattleStats;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.level.HeroLevel;
   import game.data.storage.skills.SkillDescription;
   import starling.textures.Texture;
   
   public class HeroEntry extends UnitEntry
   {
       
      
      protected var _hero:HeroDescription;
      
      protected var _level:HeroLevel;
      
      protected var _star:HeroStarEvolutionData;
      
      protected var _equipment:PlayerHeroEnchantment;
      
      protected var _precalculatedPower:int;
      
      public function HeroEntry(param1:HeroDescription, param2:HeroEntrySourceData)
      {
         super();
         if(param1)
         {
            _hero = param1;
         }
         else
         {
            _hero = DataStorage.hero.getHeroById(param2.id);
         }
         if(param2)
         {
            parseExp(param2);
            _star = _hero.getStarData(DataStorage.enum.getById_EvolutionStar(param2.star));
            _equipment = new PlayerHeroEnchantment(param2.slots,_hero.getColorData(DataStorage.enum.getById_HeroColor(param2.color)));
         }
         else
         {
            _star = _hero.startingStar;
            _equipment = new PlayerHeroEnchantment(null,hero.startingColor);
         }
         _precalculatedPower = param2.power;
      }
      
      override public function get id() : uint
      {
         return _hero.id;
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
      
      public function get level() : HeroLevel
      {
         return _level;
      }
      
      public function get star() : HeroStarEvolutionData
      {
         return _star;
      }
      
      public function get color() : HeroColorData
      {
         return _equipment.color;
      }
      
      public function get name() : String
      {
         return _hero.name;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getItemTexture(_hero);
      }
      
      override public function get battleStats() : BattleStats
      {
         return getBasicBattleStats();
      }
      
      override public function getPower() : int
      {
         if(_precalculatedPower)
         {
            return _precalculatedPower;
         }
         var _loc1_:BattleStats = getBasicBattleStats();
         var _loc2_:Number = BattleDataFactory.getHeroStatsPower(_loc1_);
         var _loc3_:SkillDescription = DataStorage.skill.getAutoAttackByHero(_hero.id);
         if(_loc3_)
         {
            _loc2_ = _loc2_ + 1 * _loc3_.power;
         }
         return _loc2_;
      }
      
      public function getSortPower() : int
      {
         return getPower();
      }
      
      public function getBasicBattleStats() : BattleStats
      {
         var _loc1_:BattleStats = _equipment.getBattleStats();
         if(_loc1_)
         {
            _loc1_.add(_hero.baseStats);
         }
         else
         {
            _loc1_ = _hero.baseStats.clone();
         }
         if(star)
         {
            _loc1_.addMultiply(star.statGrowthData,_level.level);
         }
         return _loc1_;
      }
      
      protected function parseExp(param1:HeroEntrySourceData) : void
      {
         _level = DataStorage.level.getHeroLevel(param1.level);
      }
   }
}
