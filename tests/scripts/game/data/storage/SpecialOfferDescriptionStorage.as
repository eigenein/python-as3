package game.data.storage
{
   import com.progrestar.common.lang.Translate;
   
   public class SpecialOfferDescriptionStorage extends DescriptionStorage
   {
       
      
      public function SpecialOfferDescriptionStorage()
      {
         super();
      }
      
      public function getOfferNameById(param1:int) : String
      {
         return Translate.translate(_items[param1]);
      }
      
      override protected function parseItem(param1:Object) : void
      {
         if(param1.localeIdent)
         {
            _items[param1.id] = param1.localeIdent;
         }
      }
   }
}
