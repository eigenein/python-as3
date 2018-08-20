package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroEvolve extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      public function CommandHeroEvolve(param1:PlayerHeroEntry)
      {
         super();
         this.hero = param1;
         rpcRequest = new RpcRequest("heroEvolve");
         rpcRequest.writeParam("heroId",param1.hero.id);
         if(param1.star.next)
         {
            _cost = param1.star.next.star.evolveGoldCost.clone() as CostData;
            _cost.fragmentCollection.addItem(param1.hero,param1.star.next.star.evolveFragmentCost);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.heroes.heroEvolveStar(hero);
      }
   }
}
