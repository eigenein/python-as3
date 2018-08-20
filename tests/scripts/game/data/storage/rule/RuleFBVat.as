package game.data.storage.rule
{
   public class RuleFBVat
   {
       
      
      private var data:Object;
      
      public function RuleFBVat(param1:Object)
      {
         super();
         this.data = param1;
      }
      
      public function getForCountryCode(param1:String) : int
      {
         if(param1 && data[param1.toUpperCase()])
         {
            return data[param1.toUpperCase()];
         }
         return 0;
      }
   }
}
