package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.battle.SoundtrackAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mechanics.boss.storage.BossTypeDescription;
   
   public class BossBattleThread extends BattleThread
   {
       
      
      protected var _bossDesription:BossTypeDescription;
      
      public function BossBattleThread(param1:*, param2:BossTypeDescription)
      {
         super(DataStorage.battleConfig.boss);
         this._bossDesription = param2;
         parseTeams(param1);
      }
      
      public function get bossDescription() : BossTypeDescription
      {
         return _bossDesription;
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         _loc4_.setSoundtrack(new SoundtrackAsset("soundtrack_boss_spider","soundtrack_boss_spider"));
         return _loc4_;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(false,true,false,param1);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(_bossDesription.battlegroundAsset);
      }
   }
}
