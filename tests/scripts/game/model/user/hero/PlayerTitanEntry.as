package game.model.user.hero
{
   import battle.BattleStats;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroStarEvolutionData;
   import game.data.storage.level.TitanLevel;
   import game.data.storage.skills.SkillDescription;
   import game.data.storage.titan.TitanDescription;
   import game.view.gui.tutorial.Tutorial;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanEntry extends TitanEntry
   {
       
      
      private var _signal_levelUp:Signal;
      
      private var _signal_updateExp:Signal;
      
      private var _signal_updateBattleStats:Signal;
      
      private var _signal_promote:Signal;
      
      private var _signal_evolve:Signal;
      
      private var _signal_artifactEvolve:Signal;
      
      private var _signal_artifactLevelUp:Signal;
      
      private var _experience:int;
      
      private var _battleStatData:BattleStats;
      
      private var _skillData:PlayerHeroSkillData;
      
      public const artifacts:PlayerTitanArtifacts = new PlayerTitanArtifacts();
      
      public function PlayerTitanEntry(param1:TitanDescription, param2:PlayerTitanEntrySourceData, param3:PlayerTitanArtifact)
      {
         _signal_levelUp = new Signal(PlayerTitanEntry);
         _signal_updateExp = new Signal(PlayerTitanEntry);
         _signal_updateBattleStats = new Signal(PlayerTitanEntry,BattleStats);
         _signal_promote = new Signal(PlayerTitanEntry);
         _signal_evolve = new Signal(PlayerTitanEntry);
         _signal_artifactEvolve = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         _signal_artifactLevelUp = new Signal(PlayerTitanEntry,PlayerTitanArtifact);
         super(param1,param2);
         _precalculatedPower = 0;
         var _loc4_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(param1.id);
         _skillData = new PlayerHeroSkillData(_loc4_,param2.skills);
         artifacts.initialize(param1.getArtifacts(),param2.artifacts,param3);
         artifacts.signal_spiritArtifactEvolve.add(handler_spiritEvolve);
         artifacts.signal_spiritArtifactLevelUp.add(handler_spiritLevelUp);
         updateBattleStats();
      }
      
      public static function sort_byPower(param1:PlayerTitanEntry, param2:PlayerTitanEntry) : int
      {
         return param2.getSortPower() - param1.getSortPower();
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
      
      public function get signal_promote() : Signal
      {
         return _signal_promote;
      }
      
      public function get signal_evolve() : Signal
      {
         return _signal_evolve;
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
      
      override public function get battleStats() : BattleStats
      {
         return _battleStatData;
      }
      
      public function get skillData() : PlayerHeroSkillData
      {
         return _skillData;
      }
      
      override public function getPowerNext(param1:Boolean = false, param2:Boolean = false) : int
      {
         var _loc3_:Number = BattleDataFactory.getTitanStatsPower(getStatsNext(param1,param2),artifacts.elementStats);
         return _loc3_ + HeroUtils.getSkillsPower(skillData);
      }
      
      override public function getPower() : int
      {
         return getPowerNext(false,false);
      }
      
      override public function getStatsNext(param1:Boolean = false, param2:Boolean = false) : BattleStats
      {
         var _loc3_:BattleStats = super.getStatsNext(param1,param2);
         _loc3_.add(artifacts.stats);
         return _loc3_;
      }
      
      function evolveArtifactStar(param1:PlayerTitanArtifact) : void
      {
         artifacts.evolve(param1);
         updateBattleStats();
         _signal_artifactEvolve.dispatch(this,param1);
      }
      
      function levelUpArtifact(param1:PlayerTitanArtifact) : void
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
      
      function addExp(param1:int) : void
      {
         var _loc2_:* = false;
         _experience = _experience + param1;
         if(!_level || _level.nextLevel && _level.nextLevel.exp <= _experience)
         {
            _loc2_ = _level != null;
            _level = DataStorage.level.getTitanLevelByExp(_experience);
         }
         _signal_updateExp.dispatch(this);
         if(_loc2_)
         {
            Tutorial.events.triggerEvent_titanLevelUp(this,_level as TitanLevel);
            _signal_levelUp.dispatch(this);
            updateBattleStats();
         }
      }
      
      override protected function parseExp(param1:TitanEntrySourceData) : void
      {
         var _loc2_:PlayerTitanEntrySourceData = param1 as PlayerTitanEntrySourceData;
         addExp(!!_loc2_?_loc2_.xp:0);
      }
      
      private function updateBattleStats() : void
      {
         var _loc2_:BattleStats = null;
         if(_battleStatData)
         {
            _loc2_ = _battleStatData;
         }
         var _loc1_:BattleStats = getBasicBattleStats();
         _loc1_.processBaseStats(titan.mainStat);
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
      
      private function handler_spiritEvolve(param1:PlayerTitanArtifact) : void
      {
         updateBattleStats();
         _signal_artifactEvolve.dispatch(null,param1);
      }
      
      private function handler_spiritLevelUp(param1:PlayerTitanArtifact) : void
      {
         updateBattleStats();
         _signal_artifactLevelUp.dispatch(null,param1);
      }
   }
}
