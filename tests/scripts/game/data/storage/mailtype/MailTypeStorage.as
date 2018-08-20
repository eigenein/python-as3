package game.data.storage.mailtype
{
   import game.data.storage.DescriptionStorage;
   
   public class MailTypeStorage extends DescriptionStorage
   {
       
      
      public function MailTypeStorage()
      {
         super();
      }
      
      public function canMassFarm(param1:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.type == param1)
            {
               return _loc2_.massFarmEnabled;
            }
         }
         return false;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:MailTypeDescription = new MailTypeDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
