package game.command.rpc.mission
{
   import com.progrestar.common.lang.Translate;
   import game.battle.controller.MultiBattleResult;
   import game.command.CommandManager;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.mission.PlayerEliteMissionEntry;
   
   public class MissionCommandList
   {
       
      
      private var actionManager:CommandManager;
      
      public function MissionCommandList(param1:CommandManager)
      {
         super();
         this.actionManager = param1;
      }
      
      public function missionStart(param1:MissionDescription, param2:Vector.<PlayerHeroEntry>) : CommandMissionStart
      {
         var _loc3_:CommandMissionStart = new CommandMissionStart(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function missionEnd(param1:MultiBattleResult) : CommandMissionEnd
      {
         var _loc2_:CommandMissionEnd = new CommandMissionEnd(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function missionRaid(param1:MissionDescription, param2:int) : CommandMissionRaid
      {
         var _loc3_:CommandMissionRaid = new CommandMissionRaid(param1,param2);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function missionBuyEliteTries(param1:PlayerEliteMissionEntry) : CommandMissionBuyTries
      {
         var _loc2_:CommandMissionBuyTries = new CommandMissionBuyTries(param1);
         actionManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function battleGetReplay(param1:String, param2:String) : CommandBattleGetReplay
      {
         var _loc3_:CommandBattleGetReplay = new CommandBattleGetReplay(param1,param2);
         _loc3_.signal_complete.add(handler_battleGetReplayComplete);
         actionManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      private function handler_battleGetReplayComplete(param1:CommandBattleGetReplay) : void
      {
         param1.signal_complete.remove(handler_battleGetReplayComplete);
         if(!param1.result.body)
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_REPLAY_ERROR"));
         }
      }
   }
}
