package game.model.user.hero
{
   import battle.BattleStats;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanGiftDescription;
   import game.view.gui.tutorial.Tutorial;
   import org.osflash.signals.Signal;
   
   public class PlayerHeroEntry extends HeroEntry
   {
       
      
      private var _signal_levelUp:Signal;
      
      private var _signal_updateExp:Signal;
      
      private var _signal_updateBattleStats:Signal;
      
      private var _signal_insertItem:Signal;
      
      private var _signal_promote:Signal;
      
      private var _signal_evolve:Signal;
      
      private var _signal_enchantRune:Signal;
      
      private var _signal_titanGiftLevelChange:Signal;
      
      private var _signal_artifactEvolve:Signal;
      
      private var _signal_artifactLevelUp:Signal;
      
      private var _experience:int;
      
      private var _currentSkin:int;
      
      private var _titanGiftLevel:int;
      
      private var _titanCoinsSpent:int;
      
      private var _battleStatData:BattleStats;
      
      private var _skillData:PlayerHeroSkillData;
      
      private var _skinData:PlayerHeroSkinData;
      
      public const runes:PlayerHeroRunes = new PlayerHeroRunes();
      
      public const artifacts:PlayerHeroArtifacts = new PlayerHeroArtifacts();
      
      public function PlayerHeroEntry(param1:HeroDescription, param2:PlayerHeroEntrySourceData)
      {
         _signal_levelUp = new Signal(PlayerHeroEntry);
         _signal_updateExp = new Signal(PlayerHeroEntry);
         _signal_updateBattleStats = new Signal(PlayerHeroEntry,BattleStats);
         _signal_promote = new Signal(PlayerHeroEntry);
         _signal_evolve = new Signal(PlayerHeroEntry);
         _signal_enchantRune = new Signal(PlayerHeroEntry,int,int);
         _signal_insertItem = new Signal(PlayerHeroEntry,int);
         _signal_artifactEvolve = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         _signal_artifactLevelUp = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         _signal_titanGiftLevelChange = new Signal(PlayerHeroEntry);
         super(param1,param2);
         _precalculatedPower = 0;
         var _loc3_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(param1.id);
         _skillData = new PlayerHeroSkillData(_loc3_,param2.skills);
         _skinData = new PlayerHeroSkinData(param2.skins);
         _currentSkin = param2.currentSkin;
         _titanGiftLevel = param2.titanGiftLevel;
         _titanCoinsSpent = param2.titanCoinsSpent;
         runes.initialize(param1.getRunes(),param2.runes);
         artifacts.initialize(param1.getArtifacts(),param2.artifacts);
         updateBattleStats();
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      public function get signal_updateExp() : Signal
      {
         return _signal_updateExp;
      }
      
      public function get signal_updateBattleStats() : Signal
      {
         return _signal_updateBattleStats;
      }
      
      public function get signal_insertItem() : Signal
      {
         return _signal_insertItem;
      }
      
      public function get signal_promote() : Signal
      {
         return _signal_promote;
      }
      
      public function get signal_evolve() : Signal
      {
         return _signal_evolve;
      }
      
      public function get signal_enchantRune() : Signal
      {
         return _signal_enchantRune;
      }
      
      public function get signal_titanGiftLevelChange() : Signal
      {
         return _signal_titanGiftLevelChange;
      }
      
      public function get signal_artifactEvolve() : Signal
      {
         return _signal_artifactEvolve;
      }
      
      public function get signal_artifactLevelUp() : Signal
      {
         return _signal_artifactLevelUp;
      }
      
      public function get experience() : int
      {
         return _experience;
      }
      
      public function get currentSkin() : int
      {
         return _currentSkin;
      }
      
      public function get titanGiftLevel() : int
      {
         return _titanGiftLevel;
      }
      
      public function get titanCoinsSpent() : int
      {
         return _titanCoinsSpent;
      }
      
      public function set titanCoinsSpent(param1:int) : void
      {
         _titanCoinsSpent = param1;
      }
      
      override public function get battleStats() : BattleStats
      {
         return _battleStatData;
      }
      
      public function get skillData() : PlayerHeroSkillData
      {
         return _skillData;
      }
      
      public function get skinData() : PlayerHeroSkinData
      {
         return _skinData;
      }
      
      override public function getPower() : int
      {
         var _loc1_:BattleStats = getBasicBattleStats();
         var _loc2_:Number = BattleDataFactory.getHeroStatsPower(_loc1_);
         var _loc3_:SkillDescription = DataStorage.skill.getAutoAttackByHero(_hero.id);
         if(_loc3_)
         {
            _loc2_ = _loc2_ + 1 * _loc3_.power;
         }
         _loc2_ = _loc2_ + artifacts.getAdditionalPower();
         return _loc2_ + HeroUtils.getSkillsPower(skillData);
      }
      
      public function canUpgradeSkill(param1:SkillDescription) : Boolean
      {
         var _loc2_:int = skillData.getLevelByTier(param1.tier).level;
         return param1.tier <= color.skillTierAvailable && _loc2_ < _level.level;
      }
      
      public function isItemSlotBusy(param1:int) : Boolean
      {
         return _equipment.isSlotBusy(param1);
      }
      
      public function getSlotEnchant(param1:int) : int
      {
         return _equipment.getSlotEnchant(param1);
      }
      
      function evolveArtifactStar(param1:PlayerHeroArtifact) : void
      {
         artifacts.evolve(param1);
         updateBattleStats();
         _signal_artifactEvolve.dispatch(this,param1);
      }
      
      function levelUpArtifact(param1:PlayerHeroArtifact) : void
      {
         artifacts.levelUp(param1);
         updateBattleStats();
         _signal_artifactLevelUp.dispatch(this,param1);
      }
      
      function evolveStar() : void
      {
         _star = _star.next;
         updateBattleStats();
         _signal_evolve.dispatch(this);
      }
      
      function evolveStarBoost(param1:HeroStarEvolutionData) : void
      {
         _star = _star.next;
         updateBattleStats();
      }
      
      function promoteColor() : void
      {
         _equipment.promoteColor();
         _skillData.createSkillsOnPromotion(_equipment.color);
         updateBattleStats();
         _signal_promote.dispatch(this);
      }
      
      function promoteColorBoost(param1:HeroColorData) : void
      {
         _equipment.promoteColorBoost(param1);
         _skillData.createSkillsOnPromotion(_equipment.color);
         updateBattleStats();
      }
      
      function enchantRune(param1:int, param2:int) : void
      {
         runes.enchantSlot(param1,param2);
         updateBattleStats();
         _signal_enchantRune.dispatch(this,param1,param2);
      }
      
      function insertItem(param1:int) : void
      {
         _equipment.insertItem(param1);
         updateBattleStats();
         _signal_insertItem.dispatch(this,param1);
      }
      
      function addExp(param1:int) : void
      {
         var _loc2_:* = false;
         _experience = _experience + param1;
         if(!_level || _level.nextLevel && _level.nextLevel.exp <= _experience)
         {
            _loc2_ = _level != null;
            _level = DataStorage.level.getHeroLevelByExp(_experience);
         }
         _signal_updateExp.dispatch(this);
         if(_loc2_)
         {
            Tutorial.events.triggerEvent_heroLevelUp(this,_level);
            _signal_levelUp.dispatch(this);
            updateBattleStats();
         }
      }
      
      function upgradeSkill(param1:int) : void
      {
         skillData.upgradeSkill(param1);
      }
      
      function upgradeSkin(param1:SkinDescription, param2:uint) : void
      {
         skinData.upgrageSkin(param1,param2);
         updateBattleStats();
      }
      
      function changeSkin(param1:uint) : void
      {
         _currentSkin = param1;
      }
      
      function titanGiftLevelUp() : void
      {
         _titanGiftLevel = Number(_titanGiftLevel) + 1;
         _signal_titanGiftLevelChange.dispatch(this);
         updateBattleStats();
      }
      
      function titanGiftDrop() : void
      {
         _titanGiftLevel = 0;
         _titanCoinsSpent = 0;
         _signal_titanGiftLevelChange.dispatch(this);
      }
      
      override protected function parseExp(param1:HeroEntrySourceData) : void
      {
         var _loc2_:PlayerHeroEntrySourceData = param1 as PlayerHeroEntrySourceData;
         addExp(!!_loc2_?_loc2_.xp:0);
      }
      
      override public function getBasicBattleStats() : BattleStats
      {
         var _loc2_:* = null;
         var _loc1_:BattleStats = super.getBasicBattleStats();
         _loc1_.add(runes.stats);
         _loc1_.add(artifacts.stats);
         _loc1_.add(skinData.stats);
         if(titanGiftLevel > 0)
         {
            _loc2_ = DataStorage.titanGift.getTitanGiftByLevel(titanGiftLevel);
            if(_loc2_)
            {
               _loc1_.add(_loc2_.getBattleStatByBaseStat(hero.mainStat.name));
            }
         }
         return _loc1_;
      }
      
      private function updateBattleStats() : void
      {
         var _loc2_:BattleStats = null;
         if(_battleStatData)
         {
            _loc2_ = _battleStatData;
         }
         var _loc1_:BattleStats = getBasicBattleStats();
         _loc1_.processBaseStats(hero.mainStat);
         _battleStatData = _loc1_;
         if(_loc2_)
         {
            _loc2_.multiply(-1);
            _loc2_.add(_battleStatData);
            _signal_updateBattleStats.dispatch(this,_loc2_);
         }
         else
         {
            _signal_updateBattleStats.dispatch(this,_battleStatData);
         }
      }
   }
}
