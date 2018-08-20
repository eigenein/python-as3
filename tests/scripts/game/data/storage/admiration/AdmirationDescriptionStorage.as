package game.data.storage.admiration
{
   import game.data.storage.DescriptionStorage;
   
   public class AdmirationDescriptionStorage extends DescriptionStorage
   {
       
      
      public function AdmirationDescriptionStorage()
      {
         super();
      }
      
      public function getAvailable(param1:int) : Vector.<AdmirationDescription>
      {
         var _loc2_:Vector.<AdmirationDescription> = new Vector.<AdmirationDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.vipLevel <= param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getUnlockableAt(param1:int) : Vector.<AdmirationDescription>
      {
         var _loc2_:Vector.<AdmirationDescription> = new Vector.<AdmirationDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.vipLevel == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getAdmirationById(param1:uint) : AdmirationDescription
      {
         return _items[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:AdmirationDescription = new AdmirationDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
