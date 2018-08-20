package game.battle.controller.thread
{
   import battle.BattleConfig;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.model.user.UserInfo;
   import game.screen.BattleScreen;
   
   public class ReplayBattleThread extends ArenaBattleThread
   {
       
      
      private var attackerUser:UserInfo;
      
      private var defenderUser:UserInfo;
      
      private var battlegroundAsset:BattlegroundAsset;
      
      public function ReplayBattleThread(param1:Object, param2:Boolean, param3:UserInfo, param4:UserInfo)
      {
         if(param1.type && param1.type == "grand")
         {
            battlegroundAsset = AssetStorage.battleground.getById(DataStorage.rule.arenaRule.grandBattlegroundAsset);
         }
         else
         {
            battlegroundAsset = AssetStorage.battleground.getById(DataStorage.rule.arenaRule.arenaBattlegroundAsset);
         }
         super(param1,param2);
         attackerUser = param3;
         defenderUser = param4;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(true,false,true,param1,true);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return battlegroundAsset;
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
