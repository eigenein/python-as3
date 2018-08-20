package game.data.storage.gear
{
   import game.data.storage.DescriptionStorage;
   
   public class GearDescriptionStorage extends DescriptionStorage
   {
       
      
      public function GearDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:GearItemDescription = new GearItemDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function initCraftRecipe(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            (getById(_loc2_.id) as GearItemDescription).parseCraftRecipe(_loc2_);
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(_loc2_ in param1)
         {
            (getById(_loc2_.id) as GearItemDescription).unfoldCraftRecipe();
         }
      }
      
      public function getGearById(param1:int) : GearItemDescription
      {
         return _items[param1] as GearItemDescription;
      }
      
      public function getList() : Vector.<GearItemDescription>
      {
         var _loc2_:Vector.<GearItemDescription> = new Vector.<GearItemDescription>();
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
   }
}
