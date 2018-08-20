package game.model.user.mission
{
   import game.data.storage.pve.mission.MissionDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerMissionEntry
   {
       
      
      private var _signal_updateProgress:Signal;
      
      private var _stars:int;
      
      private var _desc:MissionDescription;
      
      public function PlayerMissionEntry(param1:MissionDescription, param2:Object)
      {
         _signal_updateProgress = new Signal(PlayerMissionEntry);
         super();
         this._desc = param1;
         if(param2)
         {
            _stars = param2.stars;
         }
      }
      
      public function get signal_updateProgress() : Signal
      {
         return _signal_updateProgress;
      }
      
      public function updateProgress(param1:Object) : void
      {
         if(param1)
         {
            _stars = Math.max(param1.stars,_stars);
         }
         _signal_updateProgress.dispatch(this);
      }
      
      public function get stars() : int
      {
         return _stars;
      }
      
      public function get desc() : MissionDescription
      {
         return _desc;
      }
      
      public function get id() : int
      {
         return desc.id;
      }
   }
}
