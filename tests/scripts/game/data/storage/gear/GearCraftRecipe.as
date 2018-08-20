package game.data.storage.gear
{
   import game.data.cost.CostData;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class GearCraftRecipe extends CostData
   {
       
      
      private var _fullList:Vector.<InventoryItemDescription>;
      
      public function GearCraftRecipe(param1:Object = null)
      {
         super(param1);
      }
      
      public function get fullList() : Vector.<InventoryItemDescription>
      {
         return _fullList;
      }
      
      function unfold(param1:GearItemDescription) : void
      {
         _fullList = getRecipe(param1);
      }
      
      private function getRecipe(param1:GearItemDescription) : Vector.<InventoryItemDescription>
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Vector.<InventoryItemDescription> = new Vector.<InventoryItemDescription>();
         if(param1.craftRecipe)
         {
            _loc2_ = param1.craftRecipe.outputDisplay;
            _loc3_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_.push(_loc2_[_loc5_].item);
               if(_loc2_[_loc5_].item is GearItemDescription)
               {
                  _loc4_.concat(getRecipe(_loc2_[_loc5_].item as GearItemDescription));
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
   }
}
