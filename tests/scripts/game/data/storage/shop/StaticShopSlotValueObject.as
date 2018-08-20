package game.data.storage.shop
{
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   
   public class StaticShopSlotValueObject extends ShopSlotValueObject
   {
       
      
      public function StaticShopSlotValueObject(param1:int, param2:Object)
      {
         if(param2.type)
         {
            param2.reward = {};
            param2.reward[param2.type] = {};
            param2.reward[param2.type][param2.id[0]] = param2.amount;
         }
         else if(!param2.reward)
         {
            param2.reward = {};
         }
         param2.id = param2.slot;
         super(param2);
      }
   }
}
