package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroEnchantRuneStaromoney extends CostCommand
   {
       
      
      private var tier:int;
      
      private var _hero:PlayerHeroEntry;
      
      public function CommandHeroEnchantRuneStaromoney(param1:PlayerHeroEntry, param2:int)
      {
         super();
         this._hero = param1;
         this.tier = param2;
         var _loc5_:int = param1.runes.getRuneEnchantment(param2);
         var _loc4_:int = param1.runes.getRuneNextLevelEnchantment(param2);
         var _loc3_:int = (_loc4_ - _loc5_) * DataStorage.rule.runeEnchantStarmoney;
         _cost = new CostData();
         _cost.starmoney = _loc3_;
         rpcRequest = new RpcRequest("heroEnchantRuneStarmoney");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("tier",param2);
         rpcRequest.writeParam("starmoney",_loc3_);
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
