package game.model.user.hero
{
   import battle.BattleStats;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   
   public class PlayerHeroArtifacts
   {
       
      
      private const artifacts:Vector.<PlayerHeroArtifact> = new Vector.<PlayerHeroArtifact>();
      
      public const stats:BattleStats = new BattleStats();
      
      public const weaponStats:BattleStats = new BattleStats();
      
      public function PlayerHeroArtifacts()
      {
         super();
      }
      
      public function get list() : Vector.<PlayerHeroArtifact>
      {
         return artifacts;
      }
      
      public function initialize(param1:Vector.<ArtifactDescription>, param2:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = new PlayerHeroArtifact();
            _loc4_.slotId = _loc3_;
            _loc4_.desc = param1[_loc3_];
            if(param2)
            {
               _loc4_.initialize(param2[_loc3_]);
            }
            else
            {
               _loc4_.initialize(null);
            }
            artifacts.push(_loc4_);
            _loc3_++;
         }
         updateStats();
      }
      
      public function evolve(param1:PlayerHeroArtifact) : void
      {
         param1.evolve();
         updateStats();
      }
      
      public function levelUp(param1:PlayerHeroArtifact) : void
      {
         param1.levelUp();
         updateStats();
      }
      
      public function getAdditionalPower() : Number
      {
         return BattleDataFactory.getHeroStatsPower(weaponStats) * DataStorage.rule.artifactWeaponPowerMultiplier;
      }
      
      private function updateStats() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         stats.nullify();
         weaponStats.nullify();
         _loc2_ = 0;
         while(_loc2_ < artifacts.length)
         {
            _loc1_ = artifacts[_loc2_];
            if(_loc1_.desc.artifactType == "weapon")
            {
               _loc1_.desc.addStatsByStarAndLevel(_loc1_.stars,_loc1_.level,weaponStats);
            }
            else
            {
               _loc1_.desc.addStatsByStarAndLevel(_loc1_.stars,_loc1_.level,stats);
            }
            _loc2_++;
         }
      }
   }
}
