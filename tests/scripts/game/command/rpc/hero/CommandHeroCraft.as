package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.hero.HeroDescription;
   
   public class CommandHeroCraft extends CostCommand
   {
       
      
      private var _hero:HeroDescription;
      
      public function CommandHeroCraft(param1:HeroDescription)
      {
         super();
         this._hero = param1;
         rpcRequest = new RpcRequest("heroCraft");
         rpcRequest.writeParam("heroId",param1.id);
         _cost = param1.summonCost;
         _reward = new RewardData();
         _reward.addHero(param1);
      }
      
      public function get hero() : HeroDescription
      {
         return _hero;
      }
   }
}
