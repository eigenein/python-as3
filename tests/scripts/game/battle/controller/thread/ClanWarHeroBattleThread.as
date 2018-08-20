package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import battle.data.BattleData;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.BattleController;
   import game.battle.gui.BattleGuiClanWarMediator;
   import game.battle.gui.BattleGuiMediator;
   import game.battle.gui.BattleGuiViewBase;
   import game.data.storage.DataStorage;
   import game.model.user.UserInfo;
   import game.screen.BattleScreen;
   
   public class ClanWarHeroBattleThread extends BattleThread
   {
       
      
      private var _isReplay:Boolean;
      
      private var _completedWithRetreat:Boolean;
      
      private var attackerUser:UserInfo;
      
      private var defenderUser:UserInfo;
      
      public function ClanWarHeroBattleThread(param1:Object, param2:UserInfo, param3:UserInfo)
      {
         if(param1.progress)
         {
            _isReplay = true;
         }
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
      
      public function get completedWithRetreat() : Boolean
      {
         return _completedWithRetreat;
      }
      
      override public function get isReplay() : Boolean
      {
         return _isReplay;
      }
      
      protected function getBattleConfig() : BattleConfig
      {
         return DataStorage.battleConfig.clanPvp;
      }
      
      override protected function onRetreatListener() : void
      {
         if(_isReplay)
         {
            super.onRetreatListener();
         }
         else
         {
            _completedWithRetreat = true;
            unlink();
            if(!controller.auto)
            {
               controller.action_toggleAutoBattle();
            }
            fastCompleteBattle();
         }
      }
      
      override protected function createBattleGuiMediator(param1:BattleGuiViewBase, param2:BattleController) : BattleGuiMediator
      {
         if(_isReplay)
         {
            return super.createBattleGuiMediator(param1,param2);
         }
         return new BattleGuiClanWarMediator(param1,param2);
      }
      
      override protected function createBattleAsset(param1:BattleData, param2:BattlegroundAsset, param3:int) : BattleAsset
      {
         var _loc4_:BattleAsset = super.createBattleAsset(param1,param2,param3);
         return _loc4_;
      }
      
      override protected function createBattlegroundAsset() : BattlegroundAsset
      {
         return AssetStorage.battleground.getById(DataStorage.rule.clanWarRule.heroBattlegroundAsset);
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(_isReplay,!_isReplay,false,param1,_isReplay);
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
