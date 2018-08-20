package game.command.rpc.billing
{
   import engine.context.platform.social.FBSocialFacadeHelper;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class CommandBillingsGet extends RPCCommandBase
   {
       
      
      public function CommandBillingsGet(param1:Boolean)
      {
         var _loc2_:* = null;
         super();
         rpcRequest = new RpcRequest("billingGetAll");
         if(param1)
         {
            rpcRequest.writeRequest(new RpcRequest("offerGetAll"));
            rpcRequest.writeRequest(new RpcRequest("questGetPaymentDependent"));
         }
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            _loc2_ = FBSocialFacadeHelper.fbCurrency;
            if(_loc2_)
            {
               rpcRequest.writeParam("currency",_loc2_.user_currency);
            }
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.billingData.reset(this.result.data.body);
         var _loc3_:Object = result.data["offerGetAll"];
         if(_loc3_)
         {
            param1.specialOffer.reset(_loc3_);
         }
         var _loc2_:Array = result.data["questGetPaymentDependent"];
         if(_loc2_)
         {
            param1.questData.addOrUpdateQuests(_loc2_);
         }
      }
   }
}
