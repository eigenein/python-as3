package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroTitanGiftLevelUp extends CostCommand
   {
       
      
      private var _hero:PlayerHeroEntry;
      
      public function CommandHeroTitanGiftLevelUp(param1:PlayerHeroEntry, param2:CostData)
      {
         super();
         this._hero = param1;
         rpcRequest = new RpcRequest("heroTitanGiftLevelUp");
         rpcRequest.writeParam("heroId",param1.id);
         _cost = param2;
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < cost.outputDisplay.length)
         {
            if(cost.outputDisplay[_loc2_].item is ConsumableDescription && (cost.outputDisplay[_loc2_].item as ConsumableDescription).rewardType == "titanGift")
            {
               hero.titanCoinsSpent = hero.titanCoinsSpent + cost.outputDisplay[_loc2_].amount;
            }
            _loc2_++;
         }
         param1.heroes.heroTitanGiftLevelUp(hero);
         super.clientExecute(param1);
      }
   }
}
