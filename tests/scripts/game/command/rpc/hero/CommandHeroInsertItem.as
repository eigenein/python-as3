package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.gear.GearItemDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroInsertItem extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var slot:int;
      
      public function CommandHeroInsertItem(param1:PlayerHeroEntry, param2:int)
      {
         super();
         isImmediate = false;
         this.slot = param2;
         this.hero = param1;
         rpcRequest = new RpcRequest("heroInsertItem");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("slot",param2);
         var _loc3_:Vector.<GearItemDescription> = param1.color.itemList;
         _cost = new CostData();
         _cost.inventoryCollection.addItem(_loc3_[param2],1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.heroes.heroInsertItem(hero,slot);
      }
   }
}
