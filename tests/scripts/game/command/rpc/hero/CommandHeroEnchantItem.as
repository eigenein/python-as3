package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.gear.GearItemDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   
   public class CommandHeroEnchantItem extends CostCommand
   {
       
      
      private var enchantMaterial:CostData;
      
      private var slot:int;
      
      private var hero:PlayerHeroEntry;
      
      public function CommandHeroEnchantItem(param1:PlayerHeroEntry, param2:int, param3:CostData)
      {
         super();
         this.hero = param1;
         this.slot = param2;
         this.enchantMaterial = param3;
         rpcRequest = new RpcRequest("heroEnchantItem");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("slot",param2);
         rpcRequest.writeParam("items",param3.serialize());
         _cost = param3;
         var _loc4_:GearItemDescription = param1.color.itemList[param2];
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         super.clientExecute(param1);
         var _loc3_:int = 0;
         var _loc6_:Array = enchantMaterial.fragmentCollection.toArray();
         _loc6_ = _loc6_.concat(enchantMaterial.inventoryCollection.toArray());
         var _loc4_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc6_[_loc5_] as InventoryItem;
            _loc3_ = _loc3_ + _loc2_.item.enchantValue * _loc2_.amount;
            _loc5_++;
         }
      }
   }
}
