package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.gui.block.BattleGuiYourTeamTextBlock;
   import game.data.storage.DataStorage;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.model.GameModel;
   import game.model.user.UserInfo;
   import game.screen.BattleScreen;
   
   public class TitanArenaBattleThread extends BattleThread
   {
       
      
      private var _completedWithRetreat:Boolean;
      
      private var attackerUser:UserInfo;
      
      private var defenderUser:UserInfo;
      
      private var _isReplay:Boolean;
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      public function TitanArenaBattleThread(param1:Object, param2:UserInfo, param3:UserInfo)
      {
         if(param1.progress)
         {
            _isReplay = true;
         }
         super(getBattleConfig());
         if(param2 is PlayerTitanArenaEnemy)
         {
            this._enemy = param2 as PlayerTitanArenaEnemy;
         }
         else
         {
            this._enemy = param3 as PlayerTitanArenaEnemy;
         }
         if(param1.progress)
         {
            replayProgress = param1.progress;
         }
         if(param1.result)
         {
            if(!param1.result.serverVersion && !param1.result.clientVersion)
            {
               param1.result.serverVersion = 136;
            }
            version = parseServerVersion(param1.result);
         }
         parseTeams(param1);
         attackerUser = param2;
         defenderUser = param3;
      }
      
      override public function get isReplay() : Boolean
      {
         return _isReplay;
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      protected function getBattleConfig() : BattleConfig
      {
         return DataStorage.battleConfig.titanClanPvp;
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(_isReplay,!_isReplay,false,param1,_isReplay);
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(25);
      }
      
      override protected function enterLocation(param1:BattleAsset) : void
      {
         var _loc4_:* = false;
         var _loc2_:* = false;
         super.enterLocation(param1);
         var _loc3_:BattleScreen = Game.instance.screen.getBattleScreen();
         if(_loc3_)
         {
            _loc3_.gui.setUsers(attackerUser,defenderUser);
            _loc4_ = attackerUser.id == GameModel.instance.player.id;
            _loc2_ = defenderUser.id == GameModel.instance.player.id;
            _loc3_.gui.addBlock(new BattleGuiYourTeamTextBlock(_loc4_,_loc2_));
         }
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
   }
}
