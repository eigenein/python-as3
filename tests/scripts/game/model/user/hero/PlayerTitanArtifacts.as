package game.model.user.hero
{
   import battle.BattleStats;
   import battle.stats.ElementStats;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanArtifacts
   {
       
      
      private const artifacts:Vector.<PlayerTitanArtifact> = new Vector.<PlayerTitanArtifact>();
      
      public const stats:BattleStats = new BattleStats();
      
      public const elementStats:ElementStats = new ElementStats();
      
      public var spirit:PlayerTitanArtifact;
      
      private var _signal_spiritArtifactLevelUp:Signal;
      
      private var _signal_spiritArtifactEvolve:Signal;
      
      public function PlayerTitanArtifacts()
      {
         _signal_spiritArtifactLevelUp = new Signal(PlayerTitanArtifact);
         _signal_spiritArtifactEvolve = new Signal(PlayerTitanArtifact);
         super();
      }
      
      public function get list() : Vector.<PlayerTitanArtifact>
      {
         return artifacts;
      }
      
      public function get signal_spiritArtifactLevelUp() : Signal
      {
         return _signal_spiritArtifactLevelUp;
      }
      
      public function get signal_spiritArtifactEvolve() : Signal
      {
         return _signal_spiritArtifactEvolve;
      }
      
      public function initialize(param1:Vector.<TitanArtifactDescription>, param2:Array, param3:PlayerTitanArtifact) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         spirit = param3;
         spirit.signal_evolve.add(handler_spiritEvolve);
         spirit.signal_levelUp.add(handler_spiritLevelUp);
         elementStats.element = spirit.desc.element;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = new PlayerTitanArtifact();
            _loc5_.slotId = _loc4_;
            _loc5_.desc = param1[_loc4_];
            if(param2)
            {
               _loc5_.initialize(param2[_loc4_]);
            }
            else
            {
               _loc5_.initialize(null);
            }
            artifacts.push(_loc5_);
            _loc4_++;
         }
         updateStats();
      }
      
      public function evolve(param1:PlayerTitanArtifact) : void
      {
         param1.evolve();
         updateStats();
      }
      
      public function levelUp(param1:PlayerTitanArtifact) : void
      {
         param1.levelUp();
         updateStats();
      }
      
      public function getAdditionalPower() : Number
      {
         var _loc3_:* = 0;
         var _loc2_:Object = DataStorage.rule.titanPowerPerStat;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc1_ in _loc2_)
         {
            if(elementStats.hasOwnProperty(_loc1_))
            {
               _loc3_ = Number(_loc3_ + elementStats[_loc1_] * _loc2_[_loc1_]);
            }
         }
         return _loc3_;
      }
      
      private function updateStats() : void
      {
         var _loc1_:int = 0;
         stats.nullify();
         elementStats.nullify();
         _loc1_ = 0;
         while(_loc1_ < artifacts.length)
         {
            addArtifactStats(artifacts[_loc1_],stats,elementStats);
            _loc1_++;
         }
         addArtifactStats(spirit,stats,elementStats);
      }
      
      private function addArtifactStats(param1:PlayerTitanArtifact, param2:BattleStats, param3:ElementStats) : void
      {
         param1.desc.addUnitStatsByStarAndLevel(param1.stars,param1.level,param2);
         param1.desc.addElementStatsByStarAndLevel(param1.stars,param1.level,param3);
      }
      
      private function handler_spiritEvolve(param1:PlayerTitanArtifact) : void
      {
         updateStats();
         signal_spiritArtifactEvolve.dispatch(param1);
      }
      
      private function handler_spiritLevelUp(param1:PlayerTitanArtifact) : void
      {
         updateStats();
         signal_spiritArtifactLevelUp.dispatch(param1);
      }
   }
}
