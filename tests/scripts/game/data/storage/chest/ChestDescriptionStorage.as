package game.data.storage.chest
{
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.DescriptionStorage;
   import game.data.storage.hero.UnitDescription;
   
   public class ChestDescriptionStorage extends DescriptionStorage
   {
       
      
      private var _CHEST_TOWN:ChestDescription;
      
      private var _CHEST_DIAMOND:ChestDescription;
      
      public function ChestDescriptionStorage()
      {
         super();
      }
      
      public function get CHEST_TOWN() : ChestDescription
      {
         return _CHEST_TOWN;
      }
      
      public function get CHEST_DIAMOND() : ChestDescription
      {
         return _CHEST_DIAMOND;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ChestDescription = new ChestDescription(param1);
         _items[_loc2_.ident] = _loc2_;
         if(this.hasOwnProperty(_loc2_.constName))
         {
            this["_" + _loc2_.constName] = _loc2_;
         }
      }
      
      public function checkIfHeroIsInDropList(param1:UnitDescription) : ChestDescription
      {
         if(!param1)
         {
            return null;
         }
         if(DataStorage.rule.townChestRule.chestHeroList.indexOf(param1.id) != -1)
         {
            return CHEST_TOWN;
         }
         if(param1.id == DataStorage.rule.townChestRule.superPrizeId)
         {
            return CHEST_TOWN;
         }
         return null;
      }
      
      public function checkIfHeroIsInUnlockableDropList(param1:UnitDescription) : ChestDescription
      {
         if(!param1)
         {
            return null;
         }
         var _loc4_:int = 0;
         var _loc3_:* = DataStorage.rule.townChestRule.chestHeroUnlockableList;
         for each(var _loc2_ in DataStorage.rule.townChestRule.chestHeroUnlockableList)
         {
            if(_loc2_ == param1.id)
            {
               return CHEST_TOWN;
            }
         }
         return null;
      }
      
      public function getByIdent(param1:String) : ChestDescription
      {
         return _items[param1];
      }
      
      override public function getById(param1:uint) : DescriptionBase
      {
         throw new Error("ChestDescriptionStorage:getById");
      }
   }
}
