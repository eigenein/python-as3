package game.command.rpc.clan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.model.user.Player;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandClanItemsForActivity extends CostCommand
   {
       
      
      private var enchantMaterial:CostData;
      
      private var tier:int;
      
      private var _hero:PlayerHeroEntry;
      
      public function CommandClanItemsForActivity(param1:CostData)
      {
         super();
         this.enchantMaterial = param1;
         rpcRequest = new RpcRequest("clanItemsForActivity");
         var _loc2_:int = param1.gold;
         param1.gold = 0;
         rpcRequest.writeParam("items",param1.serialize());
         param1.gold = _loc2_;
         _cost = param1;
      }
      
      public function get runeTier() : int
      {
         return tier;
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         super.clientExecute(param1);
         if(param1.clan.clan)
         {
            _loc2_ = result.body;
            _loc3_ = param1.clan.clan;
            _loc3_.spendItemsForActivity(_loc2_);
         }
      }
   }
}
