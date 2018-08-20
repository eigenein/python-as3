package game.view.popup.test.grade
{
   import battle.BattleStats;
   import battle.HeroStats;
   import battle.data.BattleHeroDescription;
   import battle.stats.ElementStats;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.skin.SkinDescriptionLevel;
   import game.data.storage.titan.TitanDescription;
   import game.view.popup.test.BattleTestBossStatsManager;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BattleTestGradeModel
   {
      
      public static var MAX_LEVEL:int = 0;
       
      
      private const maxPossibleLevel:int = MAX_LEVEL > 0?MAX_LEVEL:int(DataStorage.level.getHeroLevelByExp(2147483647).level);
      
      private const maxArtifactStar:int = 6;
      
      private const maxArtifactLevel:int = DataStorage.hero.getHeroById(1).getArtifacts()[0].artifactTypeData.maxLevel;
      
      private const maxTitanArtifactLevel:int = DataStorage.hero.getTitanById(4000).getArtifacts()[0].artifactTypeData.maxLevel;
      
      private var oldLevelValue:int;
      
      public const onPresetsChanged:Signal = new Signal();
      
      public const level:BattleTestGradeProperty = new BattleTestGradeProperty("level",1,maxPossibleLevel,1,levelToString,maxPossibleLevel);
      
      public const color:BattleTestGradeProperty = new BattleTestGradeProperty("color",1,getMaxHeroColor(),1,colorToString,10);
      
      public const stars:BattleTestGradeProperty = new BattleTestGradeProperty("stars",3,6,1,starsToString,6);
      
      public const skill:BattleTestGradeProperty = new BattleTestGradeProperty("skill",1,4,1,skillToString,4);
      
      public const skillLevel:BattleTestGradeProperty = new BattleTestGradeProperty("skillLevel",1,maxPossibleLevel,1,skillLevelToString,maxPossibleLevel);
      
      public const rune:BattleTestGradeProperty = new BattleTestGradeProperty("rune",0,40,1,runeToString,0);
      
      public const skin1:BattleTestGradeProperty = new BattleTestGradeProperty("skin1",0,40,1,skinBaseLevelToString,0);
      
      public const skin2:BattleTestGradeProperty = new BattleTestGradeProperty("skin2",0,60,1,skinLevelToString,0);
      
      public const skin3:BattleTestGradeProperty = new BattleTestGradeProperty("skin3",0,60,1,skinLevelToString,0);
      
      public const artifactWeaponStar:BattleTestGradeProperty = new BattleTestGradeProperty("artifactWeaponStar",0,6,1,starsToString,0);
      
      public const artifactWeaponLevel:BattleTestGradeProperty = new BattleTestGradeProperty("artifactWeaponLevel",0,maxTitanArtifactLevel,1,artifactLevelToString("H-Weapon","T-Attack"),0);
      
      public const artifactBookStar:BattleTestGradeProperty = new BattleTestGradeProperty("artifactBookStar",0,6,1,starsToString,0);
      
      public const artifactBookLevel:BattleTestGradeProperty = new BattleTestGradeProperty("artifactBookLevel",0,maxTitanArtifactLevel,1,artifactLevelToString("H-Book","T-Armor"),0);
      
      public const artifactRingStar:BattleTestGradeProperty = new BattleTestGradeProperty("artifactRingStar",0,6,1,starsToString,0);
      
      public const artifactRingLevel:BattleTestGradeProperty = new BattleTestGradeProperty("artifactRingLevel",0,maxTitanArtifactLevel,1,artifactLevelToString("H-Ring","T-Stat"),0);
      
      public const titanSpiritStar:BattleTestGradeProperty = new BattleTestGradeProperty("titanSpiritStar",0,6,1,starsToString,0);
      
      public const titanSpiritLevel:BattleTestGradeProperty = new BattleTestGradeProperty("titanSpiritLevel",0,maxTitanArtifactLevel,1,artifactLevelToString("T-Spirit"),0);
      
      public const gift:BattleTestGradeProperty = new BattleTestGradeProperty("gift",0,30,1,giftToString,0);
      
      public var properties:Vector.<BattleTestGradeProperty>;
      
      public const signal_invalidUnit:Signal = new Signal(String);
      
      public function BattleTestGradeModel()
      {
         super();
         properties = new <BattleTestGradeProperty>[level,color,stars,skillLevel,rune,skin1,skin2,skin3,artifactWeaponStar,artifactWeaponLevel,artifactBookStar,artifactBookLevel,artifactRingStar,artifactRingLevel,gift,titanSpiritStar,titanSpiritLevel];
         level.signal_update.add(handler_levelUpdated);
      }
      
      protected static function battleStatDataToHeroStats(param1:BattleStats, param2:UnitDescription) : HeroStats
      {
         var _loc3_:HeroStats = new HeroStats();
         _loc3_.nullify();
         _loc3_.copyFrom(param1);
         _loc3_.mainStat = param2.mainStat;
         return _loc3_;
      }
      
      public function toStringShort() : String
      {
         return level.value + "l " + stars.value + "s " + colorToString(color.value) + " " + rune.value + "r skins:" + skin1.value + "," + skin2.value + "," + skin3.value + " gift: " + gift.value + " arts:" + artifactWeaponStar.value + "." + artifactWeaponLevel.value + "," + artifactBookStar.value + "." + artifactBookLevel.value + "," + artifactRingStar.value + "." + artifactRingLevel.value + "," + titanSpiritStar.value + "." + titanSpiritLevel.value + ", spirit:" + artifactRingStar.value + "." + artifactRingLevel.value;
      }
      
      public function levelToString(param1:int) : String
      {
         return param1 + " level";
      }
      
      public function colorToString(param1:int) : String
      {
         return DataStorage.enum.getById_HeroColor(param1).ident;
      }
      
      public function starsToString(param1:int) : String
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc2_ = "";
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = _loc2_ + "*";
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function skillToString(param1:int) : String
      {
         if(param1 > 1)
         {
            return "не работает";
         }
         return "точно не работает";
      }
      
      public function skillLevelToString(param1:int) : String
      {
         return "уровень скилов: " + param1;
      }
      
      public function runeToString(param1:int) : String
      {
         return "руны: " + param1;
      }
      
      public function skinBaseLevelToString(param1:int) : String
      {
         if(param1 == 0)
         {
            return "базовый скин";
         }
         return "скин " + param1 + " уровня";
      }
      
      public function skinLevelToString(param1:int) : String
      {
         if(param1 == 0)
         {
            return "";
         }
         return "скин " + param1 + " уровня";
      }
      
      public function artifactLevelToString(param1:String, param2:String = null) : Function
      {
         artifactTypeName = param1;
         titanArtifactTypeName = param2;
         return function(param1:int):String
         {
            if(titanArtifactTypeName)
            {
               if(param1 == 0)
               {
                  return artifactTypeName + " \\ " + titanArtifactTypeName;
               }
               if(param1 > maxArtifactLevel)
               {
                  return ColorUtils.hexToRGBFormat(12320512) + param1 + " " + titanArtifactTypeName;
               }
               return param1 + " " + artifactTypeName + " \\ " + titanArtifactTypeName;
            }
            if(param1 == 0)
            {
               return artifactTypeName;
            }
            return param1 + " " + artifactTypeName;
         };
      }
      
      public function giftToString(param1:int) : String
      {
         return "дар стихий: " + param1;
      }
      
      public function toVector() : Vector.<int>
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc4_:int = 0;
         var _loc3_:* = properties;
         for each(var _loc1_ in properties)
         {
            _loc2_.push(_loc1_.value);
         }
         return _loc2_;
      }
      
      public function fromVector(param1:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = properties;
         for each(var _loc2_ in properties)
         {
            if(_loc3_ < param1.length)
            {
               _loc2_.value = param1[_loc3_];
            }
            else
            {
               _loc2_.value = _loc2_.minValue;
            }
            _loc3_++;
         }
      }
      
      public function deserialize(param1:*) : void
      {
         if(param1 is Vector.<int>)
         {
            fromVector(param1 as Vector.<int>);
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = properties;
         for each(var _loc2_ in properties)
         {
            if(param1[_loc2_.name] >= 0)
            {
               _loc2_.value = param1[_loc2_.name];
            }
         }
      }
      
      public function serialize() : Object
      {
         var _loc2_:Object = {};
         var _loc4_:int = 0;
         var _loc3_:* = properties;
         for each(var _loc1_ in properties)
         {
            _loc2_[_loc1_.name] = _loc1_.value;
         }
         return _loc2_;
      }
      
      public function copyFrom(param1:BattleTestGradeModel) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = properties.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            properties[_loc3_].value = param1.properties[_loc3_].value;
            _loc3_++;
         }
      }
      
      public function isEqual(param1:BattleTestGradeModel) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = properties.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(properties[_loc3_].value != param1.properties[_loc3_].value)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function createBattleUnit(param1:int) : BattleHeroDescription
      {
         var _loc2_:String = DataStorage.hero.getUnitById(param1).unitType;
         if(_loc2_ == "titan")
         {
            return createBattleTitan(param1);
         }
         if(_loc2_ == "boss")
         {
            return createBattleBoss(param1);
         }
         return createBattleHero(param1);
      }
      
      public function getUnitStats(param1:int, param2:Boolean) : HeroStats
      {
         var _loc10_:* = undefined;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc5_:HeroStats = BattleDataFactory.getTestUnitStats(param1,level.value,color.value,stars.value,rune.value,gift.value);
         var _loc3_:Vector.<SkinDescription> = DataStorage.skin.getSkinsByHeroId(param1);
         if(_loc3_.length > 0)
         {
            addSkinStats(_loc5_,_loc3_[0],skin1.value);
         }
         if(_loc3_.length > 1)
         {
            addSkinStats(_loc5_,_loc3_[1],skin2.value);
         }
         if(_loc3_.length > 2)
         {
            addSkinStats(_loc5_,_loc3_[2],skin3.value);
         }
         var _loc8_:HeroDescription = DataStorage.hero.getHeroById(param1);
         if(_loc8_ != null)
         {
            _loc10_ = _loc8_.getArtifacts();
            _loc9_ = _loc10_.length;
            _loc7_ = 0;
            while(_loc7_ < _loc9_)
            {
               _loc4_ = _loc10_[_loc7_];
               if(_loc4_.artifactType == "book")
               {
                  _loc4_.addStatsByStarAndLevel(artifactBookStar.value,artifactBookLevel.value,_loc5_);
               }
               if(_loc4_.artifactType == "ring")
               {
                  _loc4_.addStatsByStarAndLevel(artifactRingStar.value,artifactRingLevel.value,_loc5_);
               }
               _loc7_++;
            }
         }
         var _loc6_:TitanDescription = DataStorage.titan.getTitanById(param1);
         if(_loc6_)
         {
            addTitanArtifactStats(param1,_loc5_,null);
         }
         if(param2)
         {
            _loc5_.processHeroStats();
         }
         if(DataStorage.hero.getUnitById(param1).unitType == "boss")
         {
            BattleTestBossStatsManager.apply(param1,level.value,_loc5_);
         }
         return _loc5_;
      }
      
      public function getUnitPower(param1:int) : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getElementStats(param1:int) : ElementStats
      {
         var _loc2_:ElementStats = new ElementStats();
         addTitanArtifactStats(param1,null,_loc2_);
         return _loc2_;
      }
      
      protected function addTitanArtifactStats(param1:int, param2:BattleStats, param3:ElementStats) : void
      {
         BattleDataFactory.addTitanArtifactStats(param1,new <int>[artifactWeaponLevel.value,artifactBookLevel.value,artifactRingLevel.value,titanSpiritLevel.value],new <int>[artifactWeaponStar.value,artifactBookStar.value,artifactRingStar.value,titanSpiritStar.value],param2,param3);
      }
      
      protected function createBattleTitan(param1:int) : BattleHeroDescription
      {
         var _loc3_:TitanDescription = DataStorage.hero.getTitanById(param1);
         var _loc2_:BattleHeroDescription = BattleDataFactory.creatUnitDescriptionBase(_loc3_);
         _loc2_.stats = BattleDataFactory.getTestUnitStats(param1,level.value,color.value,stars.value,rune.value,gift.value);
         _loc2_.skills = BattleDataFactory.getSkillLevelsByColor(_loc2_,skillLevel.value,null);
         _loc2_.level = level.value;
         _loc2_.element = new ElementStats();
         addTitanArtifactStats(param1,_loc2_.stats,_loc2_.element);
         _loc2_.createStatSkills();
         return _loc2_;
      }
      
      protected function createBattleBoss(param1:int) : BattleHeroDescription
      {
         var _loc2_:BattleHeroDescription = createBattleHero(param1);
         var _loc3_:String = BattleTestBossStatsManager.apply(_loc2_.heroId,_loc2_.level,_loc2_.stats);
         if(_loc3_ != null)
         {
            signal_invalidUnit.dispatch(_loc3_);
         }
         return _loc2_;
      }
      
      protected function createBattleHero(param1:int) : BattleHeroDescription
      {
         var _loc10_:* = undefined;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc9_:HeroDescription = DataStorage.hero.getHeroById(param1);
         var _loc7_:BattleHeroDescription = BattleDataFactory.creatUnitDescriptionBase(_loc9_);
         var _loc4_:HeroStats = BattleDataFactory.getTestUnitStats(param1,level.value,color.value,stars.value,rune.value,gift.value);
         var _loc2_:Vector.<SkinDescription> = DataStorage.skin.getSkinsByHeroId(param1);
         if(_loc2_.length > 0)
         {
            addSkinStats(_loc4_,_loc2_[0],skin1.value);
         }
         if(_loc2_.length > 1)
         {
            addSkinStats(_loc4_,_loc2_[1],skin2.value);
         }
         if(_loc2_.length > 2)
         {
            addSkinStats(_loc4_,_loc2_[2],skin3.value);
         }
         var _loc5_:HeroColorData = _loc9_.getColorData(DataStorage.enum.getById_HeroColor(color.value));
         _loc7_.stats = _loc4_;
         _loc7_.skills = BattleDataFactory.getSkillLevelsByColor(_loc7_,skillLevel.value,_loc5_);
         _loc7_.level = level.value;
         if(_loc9_ != null)
         {
            BattleDataFactory.addHeroArtifacts(_loc9_,_loc7_,[{
               "level":artifactWeaponLevel.value,
               "star":artifactWeaponStar.value
            },{
               "level":artifactBookLevel.value,
               "star":artifactBookStar.value
            },{
               "level":artifactRingLevel.value,
               "star":artifactRingStar.value
            }]);
            _loc10_ = _loc9_.getArtifacts();
            _loc8_ = _loc10_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               _loc3_ = _loc10_[_loc6_];
               if(_loc3_.artifactType == "book")
               {
                  _loc3_.addStatsByStarAndLevel(artifactBookStar.value,artifactBookLevel.value,_loc4_);
               }
               if(_loc3_.artifactType == "ring")
               {
                  _loc3_.addStatsByStarAndLevel(artifactRingStar.value,artifactRingLevel.value,_loc4_);
               }
               _loc6_++;
            }
         }
         return _loc7_;
      }
      
      protected function addSkinStats(param1:BattleStats, param2:SkinDescription, param3:int) : void
      {
         var _loc4_:* = null;
         if(param3 > 0)
         {
            if(param3 > param2.levels.length)
            {
               param3 = param2.levels.length;
            }
            _loc4_ = param2.levels[param3 - 1];
            if(_loc4_ && _loc4_.statBonus)
            {
               param1[_loc4_.statBonus.ident] = param1[_loc4_.statBonus.ident] + _loc4_.statBonus.statValue;
            }
         }
      }
      
      private function getMaxHeroColor() : int
      {
         var _loc1_:int = 1;
         while(DataStorage.enum.getById_HeroColor(_loc1_ + 1))
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function handler_levelUpdated(param1:int) : void
      {
         if(oldLevelValue == skillLevel.value)
         {
            skillLevel.value = param1;
         }
         oldLevelValue = param1;
      }
   }
}
