package game.model.user.tower
{
   import game.data.storage.tower.TowerFloorType;
   
   public class PlayerTowerBuffFloor extends PlayerTowerFloor
   {
       
      
      private var _canProceed:Boolean;
      
      private var _buffs:Vector.<PlayerTowerBuffEntry>;
      
      public function PlayerTowerBuffFloor()
      {
         super();
      }
      
      override public function get type() : TowerFloorType
      {
         return TowerFloorType.BUFF;
      }
      
      public function get buffs() : Vector.<PlayerTowerBuffEntry>
      {
         return _buffs;
      }
      
      override public function get canProceed() : Boolean
      {
         return _canProceed;
      }
      
      public function updateCanProceed() : void
      {
         _canProceed = true;
         signal_updateCanProceed.dispatch();
      }
      
      override public function parseRawData(param1:*) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
