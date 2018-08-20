package game.command.rpc.hero
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.skin.SkinDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroSkinChange extends RPCCommandBase
   {
       
      
      private var hero:PlayerHeroEntry;
      
      private var _skin:SkinDescription;
      
      public function CommandHeroSkinChange(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean)
      {
         super();
         this.isImmediate = param3;
         this._skin = param2;
         this.hero = param1;
         rpcRequest = new RpcRequest("heroSkinChange");
         rpcRequest.writeParam("heroId",param1.hero.id);
         rpcRequest.writeParam("skinId",param2.id);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.heroes.heroChangeSkin(hero,_skin);
         super.clientExecute(param1);
      }
   }
}
