package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   import game.mechanics.boss.storage.BossTypeDescription;
   
   public class ReplayBossBattleThread extends BossBattleThread
   {
       
      
      public function ReplayBossBattleThread(param1:*, param2:BossTypeDescription)
      {
         replayProgress = param1.progress;
         version = parseServerVersion(param1.result);
         super(param1,param2);
      }
      
      override protected function onBattleLogInitiated() : void
      {
         BattleLog.getLog();
         BattleLog.doLog = true;
      }
      
      override protected function onBattleLogAvailable() : void
      {
      }
      
      override protected function createBattlePresets(param1:BattleConfig) : BattlePresets
      {
         return new BattlePresets(true,false,false,param1);
      }
   }
}
