package game.mediator.gui.popup.chest
{
   import game.data.storage.chest.ChestDescription;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   
   public class ChestRewardPopupValueObject
   {
       
      
      private var player:Player;
      
      private var _chest:ChestDescription;
      
      private var _pack:Boolean;
      
      private var _reward:RewardValueObjectList;
      
      public function ChestRewardPopupValueObject(param1:Player, param2:ChestDescription, param3:Boolean, param4:RewardValueObjectList)
      {
         super();
         this.player = param1;
         this._reward = param4;
         this._pack = param3;
         this._chest = param2;
      }
      
      public function get chest() : ChestDescription
      {
         return _chest;
      }
      
      public function get pack() : Boolean
      {
         return _pack;
      }
      
      public function get reward() : RewardValueObjectList
      {
         return _reward;
      }
      
      public function get costItem() : InventoryItem
      {
         return player.specialOffer.costReplace.chestPack(_chest).outputDisplay[0];
      }
   }
}
