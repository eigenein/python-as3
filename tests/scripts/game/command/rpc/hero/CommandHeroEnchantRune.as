package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroEnchantRune extends CostCommand
   {
       
      
      private var enchantMaterial:CostData;
      
      private var tier:int;
      
      private var _hero:PlayerHeroEntry;
      
      public function CommandHeroEnchantRune(param1:PlayerHeroEntry, param2:int, param3:CostData)
      {
         super();
         this._hero = param1;
         this.tier = param2;
         this.enchantMaterial = param3;
         rpcRequest = new RpcRequest("heroEnchantRune");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("tier",param2);
         var _loc4_:int = param3.gold;
         param3.gold = 0;
         rpcRequest.writeParam("items",param3.serialize());
         param3.gold = _loc4_;
         _cost = param3;
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
         super.clientExecute(param1);
         var _loc2_:int = result.body;
         param1.heroes.heroEnchantRune(_hero,tier,_loc2_);
         if(param1.clan.clan)
         {
            param1.clan.clan.activityUpdateManager.runeWasUpgraded();
         }
      }
   }
}
