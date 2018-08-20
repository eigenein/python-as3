package game.command.rpc.billing
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.social.SocialBillingBuyResult;
   
   public class CommandBillingGetLast extends RPCCommandBase
   {
       
      
      public function CommandBillingGetLast()
      {
         super();
         rpcRequest = new RpcRequest("billingGetLast");
      }
      
      public function get emptyResult() : Boolean
      {
         if(result && result.body && result.body.info && result.body.info.transactionId)
         {
            return false;
         }
         return true;
      }
      
      public function get transactionId() : String
      {
         if(result && result.body && result.body.info && result.body.info.transactionId)
         {
            return result.body.info.transactionId;
         }
         return null;
      }
      
      public function createResultObject() : SocialBillingBuyResult
      {
         return new SocialBillingBuyResult(result.body.billingReward,result.body.starmoney,transactionId,result.body.specialOffers);
      }
   }
}
