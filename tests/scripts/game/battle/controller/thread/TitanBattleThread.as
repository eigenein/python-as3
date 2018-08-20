package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.battle.SoundtrackAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.view.hero.crowd.DungeonBattleShard;
   import game.battle.view.hero.crowd.HeroCrowd;
   import game.battle.view.hero.crowd.HeroCrowdSpawnConfig;
   import game.battle.view.hero.crowd.HeroCrowdSpawnPosition;
   import game.data.storage.DataStorage;
   
   public class TitanBattleThread extends BattleThread
   {
       
      
      private var _isReplay:Boolean = false;
      
      public function TitanBattleThread(param1:*, param2:Object = null)
      {
         if(param2)
         {
            _isReplay = true;
         }
         super(DataStorage.battleConfig.titan);
         if(param2)
         {
            replayProgress = param2.progress;
         }
         if(param2)
         {
            version = parseServerVersion(param2.result);
         }
         parseTeams(param1);
      }
      
      public static function createSpawner(param1:BattleAsset) : void
      {
         var _loc3_:HeroCrowdSpawnConfig = new HeroCrowdSpawnConfig();
         var _loc2_:HeroCrowdSpawnPosition = new HeroCrowdSpawnPosition();
         _loc2_.x = 954;
         _loc2_.y = -78;
         _loc2_.aMin = 3.14159265358979 * 0.8;
         _loc2_.aMax = 3.14159265358979 * 1.5;
         _loc2_.groupAngleDispersion = 3.14159265358979 * 0.25;
         _loc2_.rMin = 120;
         _loc2_.rMax = 180;
         _loc3_.spawnPositions = new <HeroCrowdSpawnPosition>[_loc2_];
         param1.addSubsystem(new HeroCrowd(_loc3_));
         param1.addSubsystem(new DungeonBattleShard(-1,_loc2_.x,_loc2_.y,_loc2_.rMin,"dungeon_crystal",0));
      }
      
      override protected function onBattleLogAvailable() : void
      {
         if(_isReplay)
         {
            trace(BattleLog.getLog());
         }
         else
         {
            super.onBattleLogAvailable();
         }
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(_isReplay,!_isReplay,false,param1);
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         _loc4_.setSoundtrack(new SoundtrackAsset("soundtrack_titans","soundtrack_titans"));
         createSpawner(_loc4_);
         return _loc4_;
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.dungeonRule.titanBattlegroundAsset);
      }
   }
}
