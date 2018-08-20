package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.battle.SoundtrackAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.model.user.UserInfo;
   
   public class ClanWarTitanBattleThread extends ClanWarHeroBattleThread
   {
       
      
      public function ClanWarTitanBattleThread(param1:Object, param2:UserInfo, param3:UserInfo)
      {
         super(param1,param2,param3);
      }
      
      override protected function getBattleConfig() : BattleConfig
      {
         return DataStorage.battleConfig.titanClanPvp;
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         _loc4_.setSoundtrack(new SoundtrackAsset("soundtrack_titans","soundtrack_titans"));
         return _loc4_;
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.clanWarRule.titanBattlegroundAsset);
      }
   }
}
