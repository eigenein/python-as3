package game.data.storage.refillable
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionStorage;
   
   public class RefillableDescriptionStorage extends DescriptionStorage
   {
       
      
      private var _ALCHEMY:RefillableDescription;
      
      private const _itemsByIdent:Dictionary = new Dictionary();
      
      public function RefillableDescriptionStorage()
      {
         super();
      }
      
      public function get ALCHEMY() : RefillableDescription
      {
         return _ALCHEMY;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:RefillableDescription = new RefillableDescription(param1);
         _itemsByIdent[_loc2_.ident] = _loc2_;
         _items[_loc2_.id] = _loc2_;
         if(this.hasOwnProperty(param1.constName))
         {
            this["_" + param1.constName] = _loc2_;
         }
      }
      
      public function getByIdent(param1:String) : RefillableDescription
      {
         return _itemsByIdent[param1];
      }
      
      public function getVipUpgradeable() : Vector.<RefillableDescription>
      {
         var _loc3_:Boolean = false;
         var _loc2_:Vector.<RefillableDescription> = new Vector.<RefillableDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc1_ in _items)
         {
            _loc3_ = false;
            if(_loc1_.maxValue != null && _loc1_.maxValue.length > 1)
            {
               _loc3_ = true;
            }
            else if(_loc1_.maxRefillCount != null && _loc1_.maxRefillCount.length > 1)
            {
               _loc3_ = true;
            }
            if(_loc3_)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
   }
}
