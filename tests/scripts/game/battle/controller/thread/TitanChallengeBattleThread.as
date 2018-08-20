package game.battle.controller.thread
{
   import battle.BattleConfig;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.model.user.UserInfo;
   import game.screen.BattleScreen;
   
   public class TitanChallengeBattleThread extends BattleThread
   {
       
      
      private var _completedWithRetreat:Boolean;
      
      private var attackerUser:UserInfo;
      
      private var defenderUser:UserInfo;
      
      public function TitanChallengeBattleThread(param1:Object, param2:UserInfo, param3:UserInfo)
      {
         super(getBattleConfig());
         if(param1.progress)
         {
            replayProgress = param1.progress;
         }
         if(param1.result)
         {
            version = parseServerVersion(param1.result);
         }
         parseTeams(param1);
         attackerUser = param2;
         defenderUser = param3;
      }
      
      protected function getBattleConfig() : BattleConfig
      {
         return DataStorage.battleConfig.titanPvp;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(true,false,true,param1,true);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.arenaRule.grandBattlegroundAsset);
      }
      
      override protected function enterLocation(param1:BattleAsset) : void
      {
         super.enterLocation(param1);
         var _loc2_:BattleScreen = Game.instance.screen.getBattleScreen();
         if(_loc2_)
         {
            _loc2_.gui.setUsers(attackerUser,defenderUser);
         }
      }
   }
}
