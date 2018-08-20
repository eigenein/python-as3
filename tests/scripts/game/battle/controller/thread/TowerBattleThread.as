package game.battle.controller.thread
{
   import battle.BattleConfig;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   
   public class TowerBattleThread extends BattleThread
   {
       
      
      public function TowerBattleThread(param1:*)
      {
         super(DataStorage.battleConfig.tower);
         parseTeams(param1);
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(false,true,false,param1);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.towerRule.battlegroundAsset);
      }
   }
}
