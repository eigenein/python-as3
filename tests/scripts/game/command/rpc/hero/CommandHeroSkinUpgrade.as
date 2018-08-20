package game.command.rpc.hero
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroSkinUpgrade extends CostCommand
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var _skin:SkinDescription;
      
      public function CommandHeroSkinUpgrade(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean)
      {
         super();
         this.isImmediate = param3;
         this._skin = param2;
         this.hero = param1;
         rpcRequest = new RpcRequest("heroSkinUpgrade");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("skinId",param2.id);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:uint = hero.skinData.getSkinLevelByID(_skin.id);
         _cost = _skin.levels[_loc2_].cost;
         return super.prerequisiteCheck(param1);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.heroes.heroUpgradeSkin(hero,_skin);
         super.clientExecute(param1);
      }
   }
}
