package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.pve.BattleWave;
   import game.data.storage.pve.mission.MissionDescription;
   
   public class MissionBattleThread extends BattleThread
   {
       
      
      protected var desc:MissionDescription;
      
      public function MissionBattleThread(param1:*, param2:MissionDescription = null)
      {
         super(DataStorage.battleConfig.pve);
         this.desc = param2;
         parseTeams(param1);
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc5_:* = null;
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         if(desc && desc.waves.length > param3)
         {
            _loc5_ = desc.waves[param3];
            if(_loc5_ && _loc5_.soundtrackAsset)
            {
               _loc4_.setSoundtrack(_loc5_.soundtrackAsset);
            }
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
   }
}
