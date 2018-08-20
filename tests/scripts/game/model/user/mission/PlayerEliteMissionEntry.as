package game.model.user.mission
{
   import game.data.storage.DataStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.refillable.RefillableDescription;
   import game.model.user.refillable.PlayerEliteMissionRefillableEntry;
   import game.model.user.refillable.PlayerRefillableVIPSource;
   
   public class PlayerEliteMissionEntry extends PlayerMissionEntry
   {
       
      
      private var _eliteTries:PlayerEliteMissionRefillableEntry;
      
      public function PlayerEliteMissionEntry(param1:MissionDescription, param2:Object, param3:PlayerRefillableVIPSource)
      {
         super(param1,param2);
         if(DataStorage.rule.heroicMissionUseTriesLimit)
         {
            _eliteTries = new PlayerEliteMissionRefillableEntry(param2,DataStorage.refillable.getByIdent("eliteMission") as RefillableDescription,param3);
         }
      }
      
      public function get eliteTries() : PlayerEliteMissionRefillableEntry
      {
         return _eliteTries;
      }
      
      function get canRefill() : Boolean
      {
         return _eliteTries.refillCount < _eliteTries.maxRefillCount;
      }
      
      function refill() : void
      {
         _eliteTries.refill();
      }
      
      function spendEliteTries(param1:int = 1) : void
      {
         if(_eliteTries)
         {
            _eliteTries.spendEliteMission(param1);
         }
      }
   }
}
