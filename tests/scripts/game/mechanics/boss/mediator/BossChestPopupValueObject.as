package game.mechanics.boss.mediator
{
   import game.model.user.inventory.InventoryItem;
   
   public class BossChestPopupValueObject
   {
       
      
      private var _chestNum:int;
      
      private var _isFree:Boolean;
      
      private var _isOpened:Boolean;
      
      private var _reward:InventoryItem;
      
      public function BossChestPopupValueObject(param1:int, param2:Boolean, param3:Boolean, param4:InventoryItem)
      {
         super();
         _chestNum = param1;
         _isFree = param2;
         _isOpened = param3;
         _reward = param4;
      }
      
      public function get chestNum() : int
      {
         return _chestNum;
      }
      
      public function get isFree() : Boolean
      {
         return _isFree;
      }
      
      public function get isOpened() : Boolean
      {
         return _isOpened;
      }
      
      public function get reward() : InventoryItem
      {
         return _reward;
      }
   }
}
