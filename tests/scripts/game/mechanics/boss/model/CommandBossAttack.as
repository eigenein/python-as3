package game.mechanics.boss.model
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandBossAttack extends RPCCommandBase
   {
       
      
      private var heroes:Vector.<PlayerHeroEntry>;
      
      private var boss:PlayerBossEntry;
      
      public function CommandBossAttack(param1:PlayerBossEntry, param2:Vector.<PlayerHeroEntry>)
      {
         var _loc5_:int = 0;
         super();
         this.heroes = param2;
         this.boss = param1;
         var _loc4_:Array = [];
         var _loc3_:int = param2.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = param2[_loc5_].id;
            _loc5_++;
         }
         rpcRequest = new RpcRequest("bossAttack");
         rpcRequest.writeParam("heroes",_loc4_);
         rpcRequest.writeParam("bossId",param1.type.id);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.boss.startBattle(heroes,result.body,boss.type);
      }
   }
}
