package game.battle.controller.thread
{
   import game.data.storage.pve.mission.MissionDescription;
   import game.view.gui.tutorial.Tutorial;
   
   public class TutorialMissionBattleThread extends MissionBattleThread
   {
       
      
      public function TutorialMissionBattleThread(param1:*, param2:MissionDescription = null)
      {
         super(param1,param2);
         controller.progressInfo.signal_progress.add(Tutorial.events.triggerEvent_battleTiming);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         controller.progressInfo.signal_progress.remove(Tutorial.events.triggerEvent_battleTiming);
      }
   }
}
