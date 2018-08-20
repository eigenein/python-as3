package game.mediator.gui.popup.hero
{
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   
   public class InventoryItemRecipeMediator
   {
       
      
      private var player:Player;
      
      private var _item:InventoryItemDescription;
      
      private var _mergeCost:InventoryItemValueObject;
      
      private var _craftRecipe:Vector.<InventoryItemValueObject>;
      
      public function InventoryItemRecipeMediator(param1:Player, param2:InventoryItemDescription)
      {
         var _loc6_:* = null;
         var _loc3_:* = null;
         super();
         this._item = param2;
         this.player = param1;
         var _loc4_:CostData = null;
         if(param2.fragmentMergeCost)
         {
            _loc4_ = param2.fragmentMergeCost;
         }
         else
         {
            _loc6_ = param2 as GearItemDescription;
            if(_loc6_ && _loc6_.craftRecipe)
            {
               _loc4_ = _loc6_.craftRecipe;
            }
         }
         _craftRecipe = new Vector.<InventoryItemValueObject>();
         if(_loc4_)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _loc4_.outputDisplay;
            for each(var _loc5_ in _loc4_.outputDisplay)
            {
               _loc3_ = new InventoryItemValueObject(param1,_loc5_);
               if(_loc5_.item == DataStorage.pseudo.COIN)
               {
                  _mergeCost = _loc3_;
               }
               else
               {
                  _craftRecipe.push(_loc3_);
               }
            }
         }
      }
      
      public static function canBeCrafted(param1:InventoryItem) : Boolean
      {
         if(param1 is InventoryFragmentItem)
         {
            return false;
         }
         if(param1.item.fragmentMergeCost)
         {
            return true;
         }
         if(param1.item is GearItemDescription)
         {
            return (param1.item as GearItemDescription).craftRecipe != null;
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _craftRecipe.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _craftRecipe[_loc2_].dispose();
            _loc2_++;
         }
      }
      
      public function get item() : InventoryItemDescription
      {
         return _item;
      }
      
      public function get mergeCost() : InventoryItemValueObject
      {
         return _mergeCost;
      }
      
      public function get craftRecipe() : Vector.<InventoryItemValueObject>
      {
         return _craftRecipe;
      }
   }
}
