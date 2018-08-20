package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.BattleLog;
   
   public class ReplayMissionBattleThread extends MissionBattleThread
   {
       
      
      public function ReplayMissionBattleThread(param1:Object)
      {
         version = parseServerVersion(param1.result);
         super(param1);
         replayProgress = param1.progress;
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
