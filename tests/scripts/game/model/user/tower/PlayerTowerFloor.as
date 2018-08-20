package game.model.user.tower
{
   import game.data.storage.tower.TowerFloorDescription;
   import game.data.storage.tower.TowerFloorType;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTowerFloor
   {
       
      
      protected var desc:TowerFloorDescription;
      
      public var canAddValkyrie:Boolean;
      
      protected var _signal_updateCanProceed:Signal;
      
      public function PlayerTowerFloor()
      {
         _signal_updateCanProceed = new Signal();
         super();
      }
      
      public function get canProceed() : Boolean
      {
         return true;
      }
      
      public function get canInteract() : Boolean
      {
         return true;
      }
      
      public function get type() : TowerFloorType
      {
         return null;
      }
      
      public function get signal_updateCanProceed() : Signal
      {
         return _signal_updateCanProceed;
      }
      
      public function get floor() : int
      {
         return !!desc?desc.floor:-1;
      }
      
      public function parseRawData(param1:*) : void
      {
      }
      
      public function updateDescription(param1:TowerFloorDescription) : void
      {
         desc = param1;
      }
   }
}
