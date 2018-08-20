package game.mediator.gui.popup.hero.slot
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   import starling.textures.Texture;
   
   public class HeroInventorySlotValueObject
   {
       
      
      private var _slotState:int;
      
      private var _signal_updateSlotState:Signal;
      
      private var _item:GearItemDescription;
      
      private var _hero:PlayerHeroEntry;
      
      private var _slot:int;
      
      public function HeroInventorySlotValueObject(param1:GearItemDescription, param2:PlayerHeroEntry, param3:int, param4:int)
      {
         super();
         this._slot = param3;
         this._hero = param2;
         this._item = param1;
         _slotState = param4;
         _signal_updateSlotState = new Signal();
      }
      
      public function get slotState() : int
      {
         return _slotState;
      }
      
      public function set slotState(param1:int) : void
      {
         if(_slotState == param1)
         {
            return;
         }
         _slotState = param1;
         _signal_updateSlotState.dispatch();
      }
      
      public function get signal_updateSlotState() : Signal
      {
         return _signal_updateSlotState;
      }
      
      public function get item() : GearItemDescription
      {
         return _item;
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
      
      public function get slot() : int
      {
         return _slot;
      }
      
      public function get qualityFrame() : Texture
      {
         return _item.color.frameAsset;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getItemTexture(_item);
      }
      
      public function get name() : String
      {
         return _item.name;
      }
      
      public function get enchantValue() : int
      {
         return hero.getSlotEnchant(_slot);
      }
      
      public function get requiredLevel() : int
      {
         return _item.heroLevel;
      }
   }
}
