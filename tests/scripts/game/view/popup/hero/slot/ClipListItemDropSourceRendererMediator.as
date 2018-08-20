package game.view.popup.hero.slot
{
   import game.data.storage.DataStorage;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.mission.PlayerEliteMissionEntry;
   import game.model.user.mission.PlayerMissionEntry;
   import game.model.user.refillable.PlayerRefillableVIPSource;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItemDropSourceRendererMediator
   {
       
      
      private var player:Player;
      
      private var missionEntry:PlayerMissionEntry;
      
      private var fakeMissionEntry:PlayerMissionEntry;
      
      public var missionItemDropVO:MissionItemDropValueObject;
      
      public var signalDataUpdate:Signal;
      
      private var _signalEliteTriesUpdate:Signal;
      
      public function ClipListItemDropSourceRendererMediator()
      {
         signalDataUpdate = new Signal();
         _signalEliteTriesUpdate = new Signal();
         super();
         player = GameModel.instance.player;
         player.missions.signal_newMissionEntry.add(handler_newMissionAdd);
      }
      
      public function get signalEliteTriesUpdate() : Signal
      {
         return _signalEliteTriesUpdate;
      }
      
      public function get missionHasEliteTries() : Boolean
      {
         return missionItemDropVO.mission.isHeroic && DataStorage.rule.heroicMissionUseTriesLimit;
      }
      
      public function get eliteTriesAvailable() : int
      {
         var _loc1_:PlayerEliteMissionEntry = missionEntry as PlayerEliteMissionEntry;
         if(!_loc1_)
         {
            _loc1_ = fakeMissionEntry as PlayerEliteMissionEntry;
         }
         if(_loc1_ && _loc1_.eliteTries)
         {
            return _loc1_.eliteTries.value;
         }
         return 0;
      }
      
      public function get eliteTriesMax() : int
      {
         var _loc1_:PlayerEliteMissionEntry = missionEntry as PlayerEliteMissionEntry;
         if(!_loc1_)
         {
            _loc1_ = fakeMissionEntry as PlayerEliteMissionEntry;
         }
         if(_loc1_ && _loc1_.eliteTries)
         {
            return _loc1_.eliteTries.maxValue;
         }
         return 0;
      }
      
      public function get lockedByTeamLevel() : Boolean
      {
         return missionItemDropVO.teamLevel > player.levelData.level.level && !(missionEntry != null && missionEntry.stars > 0);
      }
      
      public function setData(param1:*) : void
      {
         var _loc2_:* = null;
         if(param1 is MissionItemDropValueObject)
         {
            missionItemDropVO = param1;
            missionEntry = player.missions.getByDesc(missionItemDropVO.mission);
            _loc2_ = missionEntry as PlayerEliteMissionEntry;
            if(_loc2_ && _loc2_.eliteTries)
            {
               _loc2_.eliteTries.signal_update.add(handler_eliteTriesUpdate);
            }
            if(!missionEntry)
            {
               fakeMissionEntry = new PlayerEliteMissionEntry(missionItemDropVO.mission,null,new PlayerRefillableVIPSource(player));
            }
            else
            {
               fakeMissionEntry = null;
            }
         }
         signalDataUpdate.dispatch();
      }
      
      public function dispose() : void
      {
         var _loc1_:PlayerEliteMissionEntry = missionEntry as PlayerEliteMissionEntry;
         if(_loc1_ && _loc1_.eliteTries)
         {
            _loc1_.eliteTries.signal_update.remove(handler_eliteTriesUpdate);
         }
         player.missions.signal_newMissionEntry.add(handler_newMissionAdd);
      }
      
      private function handler_eliteTriesUpdate() : void
      {
         signalEliteTriesUpdate.dispatch();
      }
      
      private function handler_newMissionAdd(param1:PlayerMissionEntry) : void
      {
         if(!missionEntry && missionItemDropVO.mission.id == param1.desc.id)
         {
            setData(missionItemDropVO);
         }
      }
   }
}
