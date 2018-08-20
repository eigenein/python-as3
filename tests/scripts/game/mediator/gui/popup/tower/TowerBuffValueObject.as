package game.mediator.gui.popup.tower
{
   import game.data.storage.enum.lib.InventoryItemType;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.tower.PlayerTowerBuffEntry;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class TowerBuffValueObject
   {
       
      
      private var _entry:PlayerTowerBuffEntry;
      
      public const signal_selected:Signal = new Signal(TowerBuffValueObject);
      
      public function TowerBuffValueObject(param1:PlayerTowerBuffEntry)
      {
         super();
         this._entry = param1;
      }
      
      public function get icon() : Texture
      {
         return _entry.buff.icon;
      }
      
      public function get desc() : String
      {
         return _entry.buff.descText;
      }
      
      public function get name() : String
      {
         return _entry.buff.name;
      }
      
      public function get message() : String
      {
         return _entry.buff.message;
      }
      
      public function get cost() : InventoryItem
      {
         return entry.buff.cost.outputDisplay[0];
      }
      
      public function get signal_updated() : Signal
      {
         return _entry.signal_updated;
      }
      
      public function get id() : int
      {
         return _entry.id;
      }
      
      public function get bought() : Boolean
      {
         return _entry.bought;
      }
      
      public function get skullCost() : int
      {
         return _entry.buff.cost.inventoryCollection.getCollectionByType(InventoryItemType.COIN).getItemById(7).amount;
      }
      
      public function get skullCostNotNull() : Boolean
      {
         return skullCost > 0;
      }
      
      public function get entry() : PlayerTowerBuffEntry
      {
         return _entry;
      }
      
      public function select() : void
      {
         signal_selected.dispatch(this);
      }
   }
}
