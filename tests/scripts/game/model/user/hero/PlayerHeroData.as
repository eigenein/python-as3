package game.model.user.hero
{
   import battle.BattleStats;
   import com.progrestar.common.Logger;
   import flash.utils.Dictionary;
   import game.data.reward.RewardHero;
   import game.data.reward.RewardHeroExp;
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleHeroReward;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.level.HeroLevel;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.watch.PlayerHeroWatcher;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroData
   {
       
      
      private var player:Player;
      
      private const logger:Logger = Logger.getLogger(PlayerHeroData);
      
      private const heroesById:Dictionary = new Dictionary();
      
      private var _teamData:PlayerTeamData;
      
      public const watcher:PlayerHeroWatcher = new PlayerHeroWatcher();
      
      public const teamGathering:PlayerHeroTeamResolver = new PlayerHeroTeamResolver(this);
      
      private var _signal_heroLeveledUp:Signal;
      
      private var _signal_newHeroObtained:Signal;
      
      private var _signal_heroEvolveStar:Signal;
      
      private var _signal_heroPromoteColor:Signal;
      
      private var _signal_heroUpgradeSkill:Signal;
      
      private var _signal_heroUpgradeSkin:Signal;
      
      private var _signal_heroChangeSkin:Signal;
      
      private var _signal_heroChangeTitanGiftLevel:Signal;
      
      private var _signal_heroArtifactEvolveStar:Signal;
      
      private var _signal_heroArtifactLevelUp:Signal;
      
      public function PlayerHeroData()
      {
         _signal_heroLeveledUp = new Signal(PlayerHeroEntry);
         _signal_newHeroObtained = new Signal(PlayerHeroEntry);
         _signal_heroEvolveStar = new Signal(PlayerHeroEntry,BattleStats,int);
         _signal_heroPromoteColor = new Signal(PlayerHeroEntry,int);
         _signal_heroUpgradeSkill = new Signal(PlayerHeroEntry,SkillDescription);
         _signal_heroUpgradeSkin = new Signal(PlayerHeroEntry,SkinDescription,Boolean);
         _signal_heroChangeSkin = new Signal(PlayerHeroEntry,SkinDescription);
         _signal_heroChangeTitanGiftLevel = new Signal(PlayerHeroEntry);
         _signal_heroArtifactEvolveStar = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         _signal_heroArtifactLevelUp = new Signal(PlayerHeroEntry,PlayerHeroArtifact);
         super();
         _teamData = new PlayerTeamData();
      }
      
      public function get teamData() : PlayerTeamData
      {
         return _teamData;
      }
      
      public function get signal_heroLeveledUp() : Signal
      {
         return _signal_heroLeveledUp;
      }
      
      public function get signal_newHeroObtained() : Signal
      {
         return _signal_newHeroObtained;
      }
      
      public function get signal_heroEvolveStar() : Signal
      {
         return _signal_heroEvolveStar;
      }
      
      public function get signal_heroPromoteColor() : Signal
      {
         return _signal_heroPromoteColor;
      }
      
      public function get signal_heroUpgradeSkill() : Signal
      {
         return _signal_heroUpgradeSkill;
      }
      
      public function get signal_heroUpgradeSkin() : Signal
      {
         return _signal_heroUpgradeSkin;
      }
      
      public function get signal_heroChangeSkin() : Signal
      {
         return _signal_heroChangeSkin;
      }
      
      public function get signal_heroChangeTitanGiftLevel() : Signal
      {
         return _signal_heroChangeTitanGiftLevel;
      }
      
      public function get signal_heroArtifactEvolveStar() : Signal
      {
         return _signal_heroArtifactEvolveStar;
      }
      
      public function get signal_heroArtifactLevelUp() : Signal
      {
         return _signal_heroArtifactLevelUp;
      }
      
      public function init(param1:Object, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc3_ in param1)
         {
            _loc4_ = DataStorage.hero.getHeroById(_loc3_.id);
            _loc5_ = new PlayerHeroEntry(_loc4_,new PlayerHeroEntrySourceData(_loc3_));
            _addHero(_loc5_);
         }
         _teamData.init(param2);
      }
      
      public function initWatcher(param1:Player) : void
      {
         this.player = param1;
         watcher.initialize(param1);
      }
      
      public function addRewardExp(param1:Vector.<RewardHeroExp>) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = getMaxHeroExp();
         var _loc4_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = param1[_loc6_].exp;
            _loc3_ = getById(param1[_loc6_].id);
            if(_loc3_.experience + _loc5_ > _loc2_)
            {
               _loc5_ = _loc2_ - _loc3_.experience;
            }
            _loc3_.addExp(_loc5_);
            _loc6_++;
         }
      }
      
      public function addRewardHeroes(param1:Vector.<RewardHero>) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_].desc;
            _loc6_ = PlayerHeroEntrySourceData.createEmpty(_loc5_);
            _loc2_ = new PlayerHeroEntry(param1[_loc4_].desc,_loc6_);
            _addHero(_loc2_);
            watcher.invalidate(_loc5_);
            _signal_newHeroObtained.dispatch(_loc2_);
            _loc4_++;
         }
      }
      
      public function addBundleHeroes(param1:Vector.<BundleHeroReward>) : Vector.<InventoryFragmentItem>
      {
         var _loc5_:int = 0;
         var _loc12_:* = null;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc13_:* = null;
         var _loc11_:int = 0;
         _loc3_ = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc15_:int = 0;
         var _loc14_:Vector.<InventoryFragmentItem> = new Vector.<InventoryFragmentItem>();
         var _loc10_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc12_ = param1[_loc5_];
            _loc6_ = _loc12_.hero;
            if(_loc12_.type == "skin")
            {
               _loc2_ = getById(_loc12_.hero.id);
               heroUpgradeSkin(_loc2_,_loc12_.skin);
               heroChangeSkin(_loc2_,_loc12_.skin);
            }
            else if(_loc12_.type == "summon")
            {
               if(!getById(_loc6_.id))
               {
                  _loc7_ = PlayerHeroEntrySourceData.createEmpty(_loc6_);
                  if(_loc12_.reward_color)
                  {
                     _loc7_.color = _loc12_.reward_color;
                  }
                  if(_loc12_.reward_skills)
                  {
                     _loc7_.setSkillLevels(_loc12_.reward_skills);
                  }
                  if(_loc12_.reward_level)
                  {
                     _loc7_.level = _loc12_.reward_level;
                  }
                  if(_loc12_.reward_star)
                  {
                     _loc3_ = _loc6_.getStarData(DataStorage.enum.getById_EvolutionStar(_loc12_.reward_star));
                     _loc7_.star = _loc3_.star.id;
                  }
                  _loc2_ = new PlayerHeroEntry(param1[_loc5_].heroEntry.hero,_loc7_);
                  _addHero(_loc2_);
                  watcher.invalidate(_loc6_);
                  _signal_newHeroObtained.dispatch(_loc2_);
               }
               else
               {
                  _loc2_ = getById(_loc6_.id);
                  if(_loc12_.reward_level > _loc2_.level.level)
                  {
                     _loc13_ = DataStorage.level.getHeroLevel(_loc12_.reward_level);
                     _loc11_ = _loc13_.exp - _loc2_.experience;
                     _loc2_.addExp(_loc11_);
                  }
                  if(_loc12_.reward_star > _loc2_.star.star.id)
                  {
                     _loc3_ = _loc6_.getStarData(DataStorage.enum.getById_EvolutionStar(_loc12_.reward_star));
                     _loc2_.evolveStarBoost(_loc3_);
                  }
                  if(_loc12_.reward_color > _loc2_.color.color.id)
                  {
                     _loc4_ = _loc6_.getColorData(DataStorage.enum.getById_HeroColor(_loc12_.reward_color));
                     _loc2_.promoteColorBoost(_loc4_);
                  }
                  _loc8_ = _loc12_.reward_skills;
                  var _loc17_:int = 0;
                  var _loc16_:* = _loc8_;
                  for(var _loc9_ in _loc8_)
                  {
                     _loc15_ = DataStorage.skill.getSkillById(_loc9_).tier;
                     if(_loc2_.skillData.getLevelByTier(_loc15_).level < _loc8_[_loc9_])
                     {
                        _loc2_.skillData.upgradeSkillBoost(_loc15_,_loc8_[_loc9_]);
                     }
                  }
                  if(_loc12_.heroFragments)
                  {
                     _loc14_.push(_loc12_.heroFragments);
                  }
               }
            }
            if(_loc12_.type == "evolve")
            {
               if(!getById(_loc6_.id))
               {
                  _loc14_.push(_loc12_.heroFragments);
               }
               else
               {
                  _loc2_ = getById(_loc6_.id);
                  if(_loc2_.star.next && _loc2_.star.next.star.id == _loc12_.reward_star)
                  {
                     heroEvolveStar(_loc2_);
                  }
                  else
                  {
                     _loc14_.push(_loc12_.heroFragments);
                  }
               }
            }
            _loc5_++;
         }
         return _loc14_;
      }
      
      public function getMaxHeroExp() : int
      {
         var _loc1_:int = 0;
         var _loc2_:HeroLevel = DataStorage.level.getHeroLevel(player.levelData.level.maxHeroLevel);
         if(_loc2_.nextLevel)
         {
            if(_loc2_.nextLevel.nextLevel)
            {
            }
            _loc1_ = _loc2_.nextLevel.exp - 1;
            return _loc1_;
         }
         return _loc2_.exp;
      }
      
      public function getById(param1:int) : PlayerHeroEntry
      {
         return heroesById[param1];
      }
      
      public function getAmount() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = heroesById;
         for each(var _loc2_ in heroesById)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getList() : Vector.<PlayerHeroEntry>
      {
         var _loc1_:Vector.<PlayerHeroEntry> = new Vector.<PlayerHeroEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = heroesById;
         for each(var _loc2_ in heroesById)
         {
            if(_loc2_.hero.isPlayable)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getFilteredList(param1:Function) : Vector.<PlayerHeroEntry>
      {
         var _loc2_:Vector.<PlayerHeroEntry> = new Vector.<PlayerHeroEntry>();
         var _loc5_:int = 0;
         var _loc4_:* = heroesById;
         for each(var _loc3_ in heroesById)
         {
            if(param1(_loc3_))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function heroEvolveStar(param1:PlayerHeroEntry) : void
      {
         var _loc4_:int = param1.getPower();
         var _loc2_:BattleStats = param1.getBasicBattleStats();
         var _loc3_:BattleStats = param1.getBasicBattleStats();
         param1.evolveStar();
         watcher.invalidate(param1.hero);
         logger.debug(param1.id,"promote color",JSON.stringify(param1.getBasicBattleStats()));
         _diff(_loc3_,param1.getBasicBattleStats());
         _signal_heroEvolveStar.dispatch(param1,_loc2_,_loc4_);
      }
      
      public function heroPromoteColor(param1:PlayerHeroEntry) : void
      {
         var _loc4_:int = param1.getPower();
         var _loc2_:BattleStats = param1.getBasicBattleStats();
         var _loc3_:BattleStats = param1.getBasicBattleStats();
         param1.promoteColor();
         watcher.invalidate(param1.hero);
         logger.debug(param1.id,"promote color",JSON.stringify(param1.getBasicBattleStats()));
         _diff(_loc3_,param1.battleStats);
         Tutorial.events.triggerEvent_heroPromoteColor(param1.hero);
         _signal_heroPromoteColor.dispatch(param1,_loc4_);
      }
      
      public function heroEnchantRune(param1:PlayerHeroEntry, param2:int, param3:int) : void
      {
         var _loc4_:BattleStats = param1.getBasicBattleStats().clone();
         param1.enchantRune(param2,param3);
         logger.debug(param1.id,"enchant rune",param2,"value",param3,JSON.stringify(param1.battleStats));
         _diff(_loc4_,param1.battleStats);
      }
      
      public function heroInsertItem(param1:PlayerHeroEntry, param2:int) : void
      {
         var _loc3_:BattleStats = param1.battleStats.clone();
         param1.insertItem(param2);
         watcher.invalidate(param1.hero);
         logger.debug(param1.id,"insert item in slot",param2,JSON.stringify(param1.battleStats));
         _diff(_loc3_,param1.battleStats);
      }
      
      public function heroUpgradeSkill(param1:PlayerHeroEntry, param2:SkillDescription) : void
      {
         param1.upgradeSkill(param2.tier);
         watcher.invalidate(param1.hero);
         _signal_heroUpgradeSkill.dispatch(param1,param2);
      }
      
      public function heroUpgradeSkin(param1:PlayerHeroEntry, param2:SkinDescription, param3:uint = 1, param4:Boolean = false) : void
      {
         param1.upgradeSkin(param2,param3);
         signal_heroUpgradeSkin.dispatch(param1,param2,param4);
      }
      
      public function heroChangeSkin(param1:PlayerHeroEntry, param2:SkinDescription) : void
      {
         param1.changeSkin(param2.id);
         signal_heroChangeSkin.dispatch(param1,param2);
      }
      
      public function heroTitanGiftLevelUp(param1:PlayerHeroEntry) : void
      {
         param1.titanGiftLevelUp();
         signal_heroChangeTitanGiftLevel.dispatch(param1);
      }
      
      public function heroTitanGiftDrop(param1:PlayerHeroEntry) : void
      {
         param1.titanGiftDrop();
         signal_heroChangeTitanGiftLevel.dispatch(param1);
      }
      
      public function heroArtifactEvolveStar(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         param1.evolveArtifactStar(param2);
         _signal_heroArtifactEvolveStar.dispatch(param1,param2);
      }
      
      public function heroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         param1.levelUpArtifact(param2);
         _signal_heroArtifactLevelUp.dispatch(param1,param2);
      }
      
      private function _addHero(param1:PlayerHeroEntry) : void
      {
         heroesById[param1.id] = param1;
         param1.signal_levelUp.add(handler_someHeroLeveledUp);
      }
      
      private function _diff(param1:BattleStats, param2:BattleStats) : void
      {
         param1.multiply(-1);
         param1.add(param2);
         logger.debug("diff",JSON.stringify(param1));
      }
      
      private function handler_someHeroLeveledUp(param1:PlayerHeroEntry) : void
      {
         _signal_heroLeveledUp.dispatch(param1);
      }
   }
}
