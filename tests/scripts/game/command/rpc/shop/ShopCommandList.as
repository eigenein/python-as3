package game.command.rpc.shop
{
   import game.command.CommandManager;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.model.user.shop.SpecialShopHeroValueObject;
   import game.model.user.shop.SpecialShopMerchant;
   
   public class ShopCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function ShopCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function shopGet(param1:ShopDescription) : CommandShopGet
      {
         var _loc2_:CommandShopGet = new CommandShopGet(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function shopBuy(param1:ShopDescription, param2:ShopSlotValueObject, param3:uint = 1) : CommandShopBuy
      {
         var _loc4_:CommandShopBuy = new CommandShopBuy(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function shopRefresh(param1:ShopDescription) : CommandShopRefresh
      {
         var _loc2_:CommandShopRefresh = new CommandShopRefresh(param1);
         commandManager.executeRPCCommand(_loc2_);
         return _loc2_;
      }
      
      public function specialShopBuy(param1:SpecialShopMerchant, param2:SpecialShopHeroValueObject) : CommandSpecialShopBuy
      {
         var _loc3_:CommandSpecialShopBuy = new CommandSpecialShopBuy(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
   }
}
