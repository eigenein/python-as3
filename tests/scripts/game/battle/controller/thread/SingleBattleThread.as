package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.pve.mission.MissionDescription;
   
   public class SingleBattleThread extends BattleThread
   {
       
      
      protected var desc:MissionDescription;
      
      public function SingleBattleThread(param1:BattleData, param2:BattlegroundAsset = null, param3:BattleConfig = null)
      {
         if(param3 == null)
         {
            param3 = DataStorage.battleConfig.pvp;
         }
         if(param2 == null)
         {
            param2 = AssetStorage.battleground.defaultAsset;
         }
         super(param3);
         var _loc4_:BattleAsset = createBattleAsset(param1,param2,0);
         battles.push(_loc4_);
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         if(_presets.config == DataStorage.battleConfig.titan)
         {
            TitanBattleThread.createSpawner(_loc4_);
         }
         return _loc4_;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(false,true,false,param1);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return !!desc?desc.asset:AssetStorage.battleground.defaultAsset;
      }
      
      protected function onBattleCompleteListener(param1:Battle) : void
      {
         Game.instance.screen.hideBattle();
         onComplete.dispatch(this);
      }
   }
}
