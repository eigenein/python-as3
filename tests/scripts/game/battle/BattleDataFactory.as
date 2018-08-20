package game.battle
{
   import battle.BattleStats;
   import battle.HeroStats;
   import battle.data.ArtifactSkillDescriptionFactory;
   import battle.data.BattleData;
   import battle.data.BattleHeroDataObject;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import battle.data.BattleTeamDescription;
   import battle.stats.ElementStats;
   import battle.utils.Version;
   import com.progrestar.common.util.PropertyMapManager;
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.ArtifactEvolutionStar;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.enum.lib.TitanEvolutionStar;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.level.TitanLevel;
   import game.data.storage.rune.RuneTypeDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.hero.HeroEntry;
   
   public class BattleDataFactory
   {
      
      public static var TITAN_ARTIFACT_ENABLED:Boolean = true;
      
      public static const statsMap:Dictionary = initStatsMap();
       
      
      public const battleData:BattleData = new BattleData();
      
      private var _invalidMessage:String = null;
      
      public function BattleDataFactory()
      {
         super();
         clear();
      }
      
      private static function initStatsMap() : Dictionary
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function creatUnitDescriptionBase(param1:UnitDescription) : BattleHeroDescription
      {
         var _loc2_:BattleHeroDescription = new BattleHeroDescription();
         _loc2_.heroId = param1.id;
         _loc2_.battleOrder = param1.battleOrder;
         _loc2_.name = param1.name;
         if(Version.current >= 136 && param1.scale > 0)
         {
            _loc2_.scale = param1.scale;
         }
         return _loc2_;
      }
      
      public static function createHeroByEntry(param1:HeroEntry) : BattleHeroDescription
      {
         var _loc2_:BattleHeroDescription = creatUnitDescriptionBase(param1.hero);
         _loc2_.stats = battleStatDataToHeroStats(param1.getBasicBattleStats(),param1.hero);
         _loc2_.skills = BattleDataFactory.getSkillLevelsByColor(_loc2_,param1.level.level,param1.color);
         _loc2_.level = param1.level.level;
         return _loc2_;
      }
      
      public static function getTestUnitStats(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : HeroStats
      {
         var _loc7_:UnitDescription = DataStorage.hero.getUnitById(param1);
         var _loc8_:HeroStats = new HeroStats();
         _loc8_.nullify();
         var _loc9_:* = 0;
         _loc8_.accuracy = _loc9_;
         _loc9_ = _loc9_;
         _loc8_.antidodge = _loc9_;
         _loc8_.anticrit = _loc9_;
         _loc8_.copyFromHeroStats(_loc7_.baseStats);
         _loc8_.mainStat = _loc7_.mainStat;
         if(_loc7_.unitType == "titan")
         {
            addTitanStats(_loc8_,_loc7_ as TitanDescription,param2,param4);
         }
         else
         {
            addHeroStats(_loc8_,_loc7_ as HeroDescription,param2,param3,param4,param5,param6);
         }
         return _loc8_;
      }
      
      public static function getHeroStatsPower(param1:BattleStats) : Number
      {
         var _loc4_:* = 0;
         var _loc3_:Object = DataStorage.rule.powerPerStat;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for(var _loc2_ in _loc3_)
         {
            if(param1.hasOwnProperty(_loc2_))
            {
               _loc4_ = Number(_loc4_ + param1[_loc2_] * _loc3_[_loc2_]);
            }
         }
         return _loc4_;
      }
      
      public static function getTitanStatsPower(param1:BattleStats, param2:ElementStats) : Number
      {
         var _loc5_:* = 0;
         var _loc4_:Object = DataStorage.rule.titanPowerPerStat;
         if(param1)
         {
            var _loc7_:int = 0;
            var _loc6_:* = _loc4_;
            for(var _loc3_ in _loc4_)
            {
               if(param1.hasOwnProperty(_loc3_))
               {
                  _loc5_ = Number(_loc5_ + param1[_loc3_] * _loc4_[_loc3_]);
               }
            }
         }
         if(param2)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc4_;
            for(_loc3_ in _loc4_)
            {
               if(param2.hasOwnProperty(_loc3_))
               {
                  _loc5_ = Number(_loc5_ + param2[_loc3_] * _loc4_[_loc3_]);
               }
            }
         }
         return _loc5_;
      }
      
      public static function addTitanArtifactStats(param1:int, param2:Vector.<int>, param3:Vector.<int>, param4:BattleStats, param5:ElementStats) : void
      {
         var _loc7_:int = 0;
         var _loc6_:TitanDescription = DataStorage.hero.getTitanById(param1);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc9_:Vector.<TitanArtifactDescription> = _loc6_.getArtifacts();
         _loc9_ = _loc9_.concat();
         _loc9_.push(DataStorage.titanArtifact.getSpiritByElement(_loc6_.details.element));
         var _loc8_:int = Math.min(_loc9_.length,param2.length,param3.length);
         if(param5)
         {
            param5.element = _loc6_.details.element;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            if(param5)
            {
               _loc9_[_loc7_].addElementStatsByStarAndLevel(param3[_loc7_],param2[_loc7_],param5);
            }
            if(param4)
            {
               _loc9_[_loc7_].addUnitStatsByStarAndLevel(param3[_loc7_],param2[_loc7_],param4);
            }
            _loc7_++;
         }
      }
      
      private static function addTitanStats(param1:HeroStats, param2:TitanDescription, param3:int, param4:int) : void
      {
         var _loc6_:TitanLevel = DataStorage.level.getTitanLevel(param3);
         var _loc5_:TitanEvolutionStar = DataStorage.enum.getById_titanEvolutionStar(param4);
         param1.add(param2.getStatsByLevelAndStar(_loc6_,_loc5_));
      }
      
      private static function addHeroStats(param1:HeroStats, param2:HeroDescription, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         var _loc9_:HeroColorData = param2.getColorData(DataStorage.enum.getById_HeroColor(param4));
         var _loc8_:HeroStarEvolutionData = param2.getStarData(DataStorage.enum.getById_EvolutionStar(param5));
         if(_loc9_ && _loc9_.battleStatData)
         {
            param1.add(_loc9_.battleStatData);
         }
         if(_loc8_)
         {
            param1.addMultiply(_loc8_.statGrowthData,param3);
         }
         else
         {
            trace("Для героя " + param2.name + " не описана звезда " + param5);
         }
         if(param6)
         {
            var _loc12_:int = 0;
            var _loc11_:* = param2.getRunes();
            for each(var _loc10_ in param2.getRunes())
            {
               param1[_loc10_.stat] = param1[_loc10_.stat] + _loc10_.getValueByLevel(param6);
            }
         }
         if(param7 > 0)
         {
            param1.add(DataStorage.titanGift.getTitanGiftByLevel(param7).getBattleStatByBaseStat(param2.mainStat.name));
         }
      }
      
      public static function createTeam(param1:*, param2:* = null) : BattleTeamDescription
      {
         var _loc4_:BattleTeamDescription = new BattleTeamDescription();
         var _loc3_:int = param1.length;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(var _loc5_ in param1)
         {
            _loc4_.heroes[_loc4_.heroes.length] = createUnit(_loc5_,param1[_loc5_]);
         }
         if(param2 != null)
         {
            _loc4_.applyEffects(param2);
         }
         return _loc4_;
      }
      
      public static function getSkillsById(param1:BattleHeroDescription, param2:Object) : Vector.<BattleSkillDescription>
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:Vector.<BattleSkillDescription> = new Vector.<BattleSkillDescription>();
         var _loc7_:SkillDescription = DataStorage.skill.getAutoAttackByHero(param1.heroId);
         if(_loc7_)
         {
            _loc6_.push(_loc7_.createBattleSkillDescription(param1,0));
         }
         var _loc9_:int = 0;
         var _loc8_:* = param2;
         for(var _loc3_ in param2)
         {
            _loc5_ = DataStorage.skill.getSkillById(_loc3_);
            if(_loc5_)
            {
               _loc4_ = param2[_loc3_];
               _loc6_.push(_loc5_.createBattleSkillDescription(param1,_loc4_));
            }
         }
         return _loc6_;
      }
      
      public static function getSkillLevelsByColor(param1:BattleHeroDescription, param2:int, param3:HeroColorData = null, param4:Boolean = true) : Vector.<BattleSkillDescription>
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc5_:int = 0;
         var _loc6_:Object = {};
         var _loc10_:Vector.<SkillDescription> = DataStorage.skill.getByHero(param1.heroId);
         var _loc9_:int = _loc10_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc7_ = _loc10_[_loc8_];
            if(_loc7_.tier != 0)
            {
               _loc5_ = !!param4?DataStorage.enum.getbyId_SkillTier(_loc7_.tier).skillMinLevel:0;
               if((param3 == null || _loc7_.tier <= param3.skillTierAvailable) && param2 > _loc5_)
               {
                  _loc6_[_loc7_.id] = param2;
               }
            }
            _loc8_++;
         }
         return getSkillsById(param1,_loc6_);
      }
      
      protected static function createUnit(param1:int, param2:Object) : BattleHeroDescription
      {
         var _loc4_:int = param2.id;
         var _loc7_:UnitDescription = DataStorage.hero.getUnitById(_loc4_);
         var _loc6_:BattleHeroDataObject = new BattleHeroDataObject(_loc7_.mainStat);
         var _loc9_:int = 0;
         var _loc8_:* = param2;
         for(var _loc3_ in param2)
         {
            if(statsMap[_loc3_])
            {
               _loc6_[_loc3_] = param2[_loc3_];
            }
         }
         _loc6_.id = param1;
         var _loc5_:BattleHeroDescription = BattleHeroDescription.create(_loc6_);
         _loc5_.heroId = _loc4_;
         _loc5_.battleOrder = _loc7_.battleOrder;
         _loc5_.name = _loc7_.name;
         _loc5_.skills = getSkillsById(_loc5_,param2.skills);
         _loc5_.createStatSkills();
         addHeroArtifacts(_loc7_,_loc5_,param2.artifacts);
         if(param2.state)
         {
            _loc5_.setState(param2.state);
         }
         return _loc5_;
      }
      
      protected static function battleStatDataToHeroStats(param1:BattleStats, param2:UnitDescription) : HeroStats
      {
         var _loc3_:HeroStats = new HeroStats();
         _loc3_.nullify();
         _loc3_.copyFrom(param1);
         _loc3_.mainStat = param2.mainStat;
         return _loc3_;
      }
      
      public static function addHeroArtifacts(param1:UnitDescription, param2:BattleHeroDescription, param3:Array) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         if(param3 == null || param1.unitType != "hero")
         {
            return;
         }
         var _loc11_:HeroDescription = param1 as HeroDescription;
         var _loc6_:Vector.<ArtifactDescription> = _loc11_.getArtifacts();
         var _loc10_:int = Math.min(_loc6_.length,param3.length);
         _loc8_ = 0;
         while(_loc8_ < _loc10_)
         {
            _loc5_ = _loc6_[_loc8_];
            if(_loc5_.artifactType == "weapon")
            {
               _loc4_ = param3[_loc8_].level;
               _loc9_ = param3[_loc8_].star;
               if(!(_loc4_ == 0 || _loc9_ == 0))
               {
                  _loc7_ = createArtifactSkill(param2,_loc5_,_loc4_,_loc9_);
                  if(_loc7_)
                  {
                     param2.skills.push(_loc7_);
                  }
               }
            }
            _loc8_++;
         }
      }
      
      protected static function createArtifactSkill(param1:BattleHeroDescription, param2:ArtifactDescription, param3:int, param4:int) : BattleSkillDescription
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:BattleStats = param2.addStatsByStarAndLevel(param4,param3);
         var _loc8_:ArtifactEvolutionStar = param2.artifactTypeData.getEvolutionStarByStars(param4);
         var _loc11_:Object = _loc9_.serialize();
         var _loc13_:int = 0;
         var _loc12_:* = _loc11_;
         for(var _loc10_ in _loc11_)
         {
            _loc6_ = _loc11_[_loc10_];
            _loc7_ = _loc8_.applyChancePercent;
            _loc5_ = param2.effectDuration;
            return ArtifactSkillDescriptionFactory.create(param1,int(_loc7_),_loc5_,_loc10_,_loc6_);
         }
         return null;
      }
      
      public function set invalidMessage(param1:String) : void
      {
         _invalidMessage = param1;
      }
      
      public function get invalidMessage() : String
      {
         return _invalidMessage;
      }
      
      public function get invalid() : Boolean
      {
         return _invalidMessage;
      }
      
      public function clear() : void
      {
         _invalidMessage = null;
         battleData.seed = int(Math.random() * 16777215);
         battleData.attackers = new BattleTeamDescription();
         battleData.defenders = new BattleTeamDescription();
      }
      
      public function clearAttackers() : void
      {
         battleData.attackers = new BattleTeamDescription();
      }
      
      public function clearDefenders() : void
      {
         battleData.defenders = new BattleTeamDescription();
      }
      
      public function addHero(param1:Boolean, param2:BattleHeroDescription) : BattleHeroDescription
      {
         if(!param2)
         {
            _invalidMessage = "unknown";
            return null;
         }
         var _loc3_:BattleTeamDescription = !!param1?battleData.attackers:battleData.defenders;
         param2.id = _loc3_.heroes.length;
         _loc3_.heroes[_loc3_.heroes.length] = param2;
         return param2;
      }
      
      public function addHeroByColor(param1:Boolean, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : BattleHeroDescription
      {
         var _loc13_:BattleTeamDescription = !!param1?battleData.attackers:battleData.defenders;
         var _loc15_:HeroDescription = DataStorage.hero.getHeroById(param2);
         var _loc12_:BattleHeroDescription = creatUnitDescriptionBase(_loc15_);
         var _loc14_:HeroColor = DataStorage.enum.getById_HeroColor(param4);
         var _loc10_:HeroColorData = _loc15_.getColorData(_loc14_);
         if(!_loc10_ && _loc15_.isPlayable)
         {
            _invalidMessage = _loc14_.name + _loc14_.minorIdentFraction + " не описан для героя `" + _loc15_.name + "`";
            return null;
         }
         var _loc9_:BattleStats = _loc15_.baseStats.clone();
         if(_loc10_ && _loc10_.battleStatData)
         {
            _loc9_.add(_loc10_.battleStatData);
         }
         var _loc8_:HeroStarEvolutionData = _loc15_.getStarData(DataStorage.enum.getById_EvolutionStar(param5));
         if(!_loc8_)
         {
            trace("Не у всех героев есть данные для 1 или 2-х звёзд");
         }
         else
         {
            _loc9_.addMultiply(_loc8_.statGrowthData,param3);
         }
         if(param7)
         {
            var _loc17_:int = 0;
            var _loc16_:* = _loc15_.getRunes();
            for each(var _loc11_ in _loc15_.getRunes())
            {
               _loc9_[_loc11_.stat] = _loc9_[_loc11_.stat] + _loc11_.getValueByLevel(param7);
            }
         }
         _loc12_.stats = battleStatDataToHeroStats(_loc9_,_loc15_);
         _loc12_.skills = BattleDataFactory.getSkillLevelsByColor(_loc12_,param6,_loc10_);
         _loc12_.level = param3;
         _loc12_.id = _loc13_.heroes.length;
         _loc13_.heroes[_loc13_.heroes.length] = _loc12_;
         return _loc12_;
      }
   }
}
