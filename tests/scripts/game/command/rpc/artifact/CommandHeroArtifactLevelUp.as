package game.command.rpc.artifact
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.storage.artifact.ArtifactLevel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroArtifactLevelUp extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var artifact:PlayerHeroArtifact;
      
      public function CommandHeroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact)
      {
         super();
         isImmediate = false;
         this.hero = param1;
         this.artifact = param2;
         rpcRequest = new RpcRequest("heroArtifactLevelUp");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("slotId",param2.slotId);
         _cost = new CostData();
         var _loc3_:ArtifactLevel = param2.nextLevelData;
         if(_loc3_)
         {
            _cost.add(_loc3_.cost);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.heroes.heroArtifactLevelUp(hero,artifact);
      }
   }
}
