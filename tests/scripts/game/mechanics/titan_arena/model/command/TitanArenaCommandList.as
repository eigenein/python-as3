package game.mechanics.titan_arena.model.command
{
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.command.CommandManager;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   
   public class TitanArenaCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function TitanArenaCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function testGetNextTier() : CommandTitanArenaTestGetNextTier
      {
         var _loc1_:CommandTitanArenaTestGetNextTier = new CommandTitanArenaTestGetNextTier();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaGetStatus() : CommandTitanArenaGetStatus
      {
         var _loc1_:CommandTitanArenaGetStatus = new CommandTitanArenaGetStatus();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaSetDefenders(param1:Vector.<UnitDescription>) : CommandTitanArenaSetDefenders
      {
         var _loc2_:CommandTitanArenaSetDefenders = new CommandTitanArenaSetDefenders(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanArenaStartBattle(param1:PlayerTitanArenaEnemy, param2:Vector.<UnitDescription>) : CommandTitanArenaStartBattle
      {
         var _loc3_:CommandTitanArenaStartBattle = new CommandTitanArenaStartBattle(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function titanArenaEndBattle(param1:TitanArenaBattleThread) : CommandTitanArenaEndBattle
      {
         var _loc2_:CommandTitanArenaEndBattle = new CommandTitanArenaEndBattle(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanArenaCompleteTier() : CommandTitanArenaCompleteTier
      {
         var _loc1_:CommandTitanArenaCompleteTier = new CommandTitanArenaCompleteTier();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaHallOfFameGet(param1:int = 0) : CommandTitanArenaHallOfFameGet
      {
         var _loc2_:CommandTitanArenaHallOfFameGet = new CommandTitanArenaHallOfFameGet(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanArenaHallOfFameGetTrophies() : CommandTitanArenaHallOfFameGetTrophies
      {
         var _loc1_:CommandTitanArenaHallOfFameGetTrophies = new CommandTitanArenaHallOfFameGetTrophies();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaTrophyRewardFarm(param1:PlayerTitanArenaTrophyData) : CommandTitanArenaTrophyRewardFarm
      {
         var _loc2_:CommandTitanArenaTrophyRewardFarm = new CommandTitanArenaTrophyRewardFarm(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanArenaGetDailyReward() : CommandTitanArenaGetDailyReward
      {
         var _loc1_:CommandTitanArenaGetDailyReward = new CommandTitanArenaGetDailyReward();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaFarmDailyReward() : CommandTitanArenaFarmDailyReward
      {
         var _loc1_:CommandTitanArenaFarmDailyReward = new CommandTitanArenaFarmDailyReward();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function titanArenaStartRaid(param1:Vector.<UnitDescription>) : CommandTitanArenaStartRaid
      {
         var _loc2_:CommandTitanArenaStartRaid = new CommandTitanArenaStartRaid(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function titanArenaEndRaid(param1:Object) : CommandTitanArenaEndRaid
      {
         var _loc2_:CommandTitanArenaEndRaid = new CommandTitanArenaEndRaid(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
   }
}
