package game.command.rpc.player
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandOfferGetAll extends RPCCommandBase
   {
       
      
      public function CommandOfferGetAll()
      {
         super();
         rpcRequest = new RpcRequest("offerGetAll");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.specialOffer.reset(result.body);
         param1.specialOffer.init(result.body);
      }
   }
}
