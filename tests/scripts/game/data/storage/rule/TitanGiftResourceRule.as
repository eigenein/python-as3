package game.data.storage.rule
{
   public class TitanGiftResourceRule
   {
       
      
      private var _data:Object;
      
      private var field:String;
      
      private var id:String;
      
      public function TitanGiftResourceRule(param1:Object)
      {
         super();
         this._data = param1;
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(field in param1)
         {
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1[field];
         for(id in param1[field])
         {
         }
      }
      
      public function resolvePlayerHeroCurrencySpent(param1:Object) : int
      {
         if(param1)
         {
            if(param1.hasOwnProperty(field) && param1[field].hasOwnProperty(id))
            {
               return param1[field][id];
            }
         }
         return 0;
      }
   }
}
