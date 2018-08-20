package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroTitanGiftDrop extends CostCommand
   {
       
      
      private var _hero:PlayerHeroEntry;
      
      public function CommandHeroTitanGiftDrop(param1:PlayerHeroEntry)
      {
         super();
         this._hero = param1;
         rpcRequest = new RpcRequest("heroTitanGiftDrop");
         rpcRequest.writeParam("heroId",param1.id);
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _reward = new RewardData(result.body);
         param1.heroes.heroTitanGiftDrop(hero);
         super.clientExecute(param1);
      }
   }
}
