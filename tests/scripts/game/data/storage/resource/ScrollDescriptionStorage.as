package game.data.storage.resource
{
   import game.data.storage.DescriptionStorage;
   import game.data.storage.gear.GearDescriptionStorage;
   import game.data.storage.gear.GearItemDescription;
   import game.model.user.inventory.InventoryItem;
   
   public class ScrollDescriptionStorage extends DescriptionStorage
   {
       
      
      public function ScrollDescriptionStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ScrollItemDescription = new ScrollItemDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
      
      public function updateGear(param1:GearDescriptionStorage) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<GearItemDescription> = param1.getList();
         var _loc3_:int = _loc6_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc6_[_loc4_].craftRecipe && !_loc6_[_loc4_].craftRecipe.isEmpty)
            {
               _loc2_ = _loc6_[_loc4_].craftRecipe.outputDisplay;
               _loc7_ = _loc2_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  if(_loc2_[_loc5_].item is ScrollItemDescription)
                  {
                     (_loc2_[_loc5_].item as ScrollItemDescription).setGear(_loc6_[_loc4_]);
                     break;
                  }
                  _loc5_++;
               }
            }
            _loc4_++;
         }
      }
   }
}
