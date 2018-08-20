package game.command.rpc.inventory
{
   import game.command.CommandManager;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.resource.InventoryItemDescription;
   
   public class InventoryCommandList
   {
       
      
      private var commandManager:CommandManager;
      
      public function InventoryCommandList(param1:CommandManager)
      {
         super();
         this.commandManager = param1;
      }
      
      public function inventoryBuy(param1:InventoryItemDescription, param2:int, param3:Boolean = false) : CommandInventoryBuy
      {
         var _loc4_:CommandInventoryBuy = new CommandInventoryBuy(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function inventorySell(param1:InventoryItemDescription, param2:int, param3:Boolean) : CommandInventorySell
      {
         var _loc4_:CommandInventorySell = new CommandInventorySell(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function inventoryUseStamina(param1:ConsumableDescription, param2:int) : CommandInventoryUseStamina
      {
         var _loc3_:CommandInventoryUseStamina = new CommandInventoryUseStamina(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function inventoryCraftRecipe(param1:GearItemDescription, param2:int) : CommandInventoryCraftRecipe
      {
         var _loc3_:CommandInventoryCraftRecipe = new CommandInventoryCraftRecipe(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function inventoryCraftFragments(param1:InventoryItemDescription, param2:int) : CommandInventoryCraftFragments
      {
         var _loc3_:CommandInventoryCraftFragments = new CommandInventoryCraftFragments(param1,param2);
         commandManager.executeRPCCommand(_loc3_);
         return _loc3_;
      }
      
      public function consumableUseLootBox(param1:ConsumableDescription, param2:int, param3:int = -1) : CommandConsumableUseLootBox
      {
         var _loc4_:CommandConsumableUseLootBox = new CommandConsumableUseLootBox(param1,param2,param3);
         commandManager.executeRPCCommand(_loc4_);
         return _loc4_;
      }
      
      public function inventoryExchangeStones() : CommandInventoryExchangeStones
      {
         var _loc1_:CommandInventoryExchangeStones = new CommandInventoryExchangeStones();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
      
      public function inventoryExchangeTitanStones() : CommandInventoryExchangeTitanStones
      {
         var _loc1_:CommandInventoryExchangeTitanStones = new CommandInventoryExchangeTitanStones();
         commandManager.executeRPCCommand(_loc1_);
         return _loc1_;
      }
   }
}
