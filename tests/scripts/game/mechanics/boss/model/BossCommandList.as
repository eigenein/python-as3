package game.mechanics.boss.model
{
   import game.battle.controller.MultiBattleResult;
   import game.command.CommandManager;
   import game.mechanics.boss.storage.BossChestDescription;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class BossCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function BossCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function bossGetAll() : CommandBossGetAll
      {
         var _loc1_:CommandBossGetAll = new CommandBossGetAll();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function bossAttack(param1:PlayerBossEntry, param2:Vector.<PlayerHeroEntry>) : CommandBossAttack
      {
         var _loc3_:CommandBossAttack = new CommandBossAttack(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function bossRaid(param1:PlayerBossEntry) : CommandBossRaid
      {
         var _loc2_:CommandBossRaid = new CommandBossRaid(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function bossEndBattle(param1:MultiBattleResult, param2:PlayerBossEntry) : CommandBossEndBattle
      {
         var _loc3_:CommandBossEndBattle = new CommandBossEndBattle(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function bossOpenChest(param1:PlayerBossEntry, param2:BossChestDescription, param3:int) : CommandBossOpenChest
      {
         var _loc4_:CommandBossOpenChest = new CommandBossOpenChest(param1,param2,param3);
         actionManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function refillableBossBuyTries() : CommandBossBuyTries
      {
         var _loc1_:CommandBossBuyTries = new CommandBossBuyTries();
         actionManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
