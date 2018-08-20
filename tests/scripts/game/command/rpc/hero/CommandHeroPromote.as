package game.command.rpc.hero
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroPromote extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      public function CommandHeroPromote(param1:PlayerHeroEntry)
      {
         super();
         this.hero = param1;
         rpcRequest = new RpcRequest("heroPromote");
         rpcRequest.writeParam("heroId",param1.hero.id);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.heroes.heroPromoteColor(hero);
         super.clientExecute(param1);
      }
   }
}
