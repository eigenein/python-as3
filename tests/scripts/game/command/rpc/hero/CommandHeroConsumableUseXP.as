package game.command.rpc.hero
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroConsumableUseXP extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var consumable:ConsumableDescription;
      
      private var amount:int;
      
      public function CommandHeroConsumableUseXP(param1:PlayerHeroEntry, param2:ConsumableDescription, param3:int)
      {
         super();
         this.amount = param3;
         isImmediate = false;
         this.consumable = param2;
         this.hero = param1;
         rpcRequest = new RpcRequest("consumableUseHeroXp");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("libId",param2.id);
         rpcRequest.writeParam("amount",param3);
      }
      
      public static function sort_byPotionReward(param1:CommandHeroConsumableUseXP, param2:CommandHeroConsumableUseXP) : int
      {
         return param1.consumable.rewardAmount - param2.consumable.rewardAmount;
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:CommandRequirement = super.prerequisiteCheck(param1);
         var _loc3_:int = param1.heroes.getMaxHeroExp();
         if(hero.experience > _loc3_)
         {
            _loc2_.invalid = true;
         }
         return _loc2_;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      public function addAmount(param1:int) : void
      {
         this.amount = this.amount + param1;
         rpcRequest.writeParam("amount",this.amount);
         dispatchClientExecute();
      }
   }
}
