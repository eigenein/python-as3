package game.model.user.tower
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerFloorType;
   
   public class PlayerTowerChestFloor extends PlayerTowerFloor
   {
       
      
      private var _chests:Vector.<PlayerTowerChestEntry>;
      
      private var _rewards:Vector.<RewardData>;
      
      public function PlayerTowerChestFloor()
      {
         super();
      }
      
      override public function get canProceed() : Boolean
      {
         return chestsOpened > 0 && desc.floor < DataStorage.tower.maxFloorNumber;
      }
      
      override public function get type() : TowerFloorType
      {
         return TowerFloorType.CHEST;
      }
      
      public function get chests() : Vector.<PlayerTowerChestEntry>
      {
         return _chests;
      }
      
      public function get rewards() : Vector.<RewardData>
      {
         return _rewards;
      }
      
      public function get chestsOpened() : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
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
      
      public function updateChestReward(param1:int, param2:RewardData, param3:Boolean, param4:Number = 1) : void
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
