package game.mechanics.expedition.model
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandExpeditionSendHeroes extends RPCCommandBase
   {
       
      
      private var expeditionId:int;
      
      private var heroes:Vector.<int>;
      
      public function CommandExpeditionSendHeroes(param1:int, param2:Vector.<int>)
      {
         super();
         this.expeditionId = param1;
         this.heroes = param2;
         rpcRequest = new RpcRequest("expeditionSendHeroes");
         rpcRequest.writeParam("expeditionId",param1);
         rpcRequest.writeParam("heroes",param2);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         var _loc2_:int = result.body.endTime;
         param1.expedition.handleHeroesSent(expeditionId,heroes,_loc2_);
      }
   }
}
