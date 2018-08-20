package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.view.hero.crowd.DungeonBattleShard;
   import game.battle.view.hero.crowd.HeroCrowdSpawnConfig;
   import game.data.storage.DataStorage;
   
   public class DungeonHeroBattleThread extends BattleThread
   {
       
      
      private var _isReplay:Boolean = false;
      
      public function DungeonHeroBattleThread(param1:Object)
      {
         if(param1.progress)
         {
            _isReplay = true;
         }
         super(DataStorage.battleConfig.tower);
         if(param1.progress)
         {
            replayProgress = param1.progress;
         }
         if(param1.result)
         {
            version = parseServerVersion(param1.result);
         }
         parseTeams(param1);
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc7_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         var _loc8_:HeroCrowdSpawnConfig = new HeroCrowdSpawnConfig();
         var _loc5_:Number = 884;
         var _loc6_:* = -30;
         var _loc4_:* = 40;
         _loc7_.addSubsystem(new DungeonBattleShard(-1,_loc5_,_loc6_,_loc4_,"dungeon_hero_crystal",200));
         return _loc7_;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(_isReplay,!_isReplay,false,param1);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.dungeonRule.heroBattlegroundAsset);
      }
   }
}
