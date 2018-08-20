package game.command.rpc.friends
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   
   public class CommandSocialQuestUpdate extends RPCCommandBase
   {
       
      
      private var posted:Boolean;
      
      private var groupJoined:Boolean;
      
      public function CommandSocialQuestUpdate(param1:Boolean, param2:Boolean)
      {
         super();
         isImmediate = false;
         this.groupJoined = param2;
         this.posted = param1;
         rpcRequest = new RpcRequest("socialQuestPost");
         rpcRequest.writeParam("value",param1);
         var _loc3_:RpcRequest = new RpcRequest("socialQuestGroupJoin");
         _loc3_.writeParam("value",param2);
         if(rpcRequest)
         {
            rpcRequest.writeRequest(_loc3_);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(posted)
         {
            param1.socialQuestData.updateStep_bookmark(true);
         }
         if(groupJoined)
         {
            param1.socialQuestData.updateStep_groupJoined(true);
         }
         super.clientExecute(param1);
      }
   }
}
