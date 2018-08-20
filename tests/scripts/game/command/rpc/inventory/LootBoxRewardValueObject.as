package game.command.rpc.inventory
{
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.component.RewardValueObject;
   
   public class LootBoxRewardValueObject extends RewardValueObject
   {
       
      
      private var _item:ConsumableDescription;
      
      private var _index:int;
      
      public function LootBoxRewardValueObject(param1:RewardData, param2:ConsumableDescription, param3:int)
      {
         super(param1);
         this._index = param3;
         this._item = param2;
      }
      
      public function get item() : ConsumableDescription
      {
         return _item;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}
