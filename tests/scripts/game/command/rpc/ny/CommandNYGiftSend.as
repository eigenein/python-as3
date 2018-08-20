package game.command.rpc.ny
{
   import engine.context.platform.PlatformUser;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.command.social.CommandSocialSendRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.notification.NotificationDescription;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class CommandNYGiftSend extends CostCommand
   {
       
      
      private var user:UserInfo;
      
      public var userGiftId:int;
      
      public var resultGiftIds:Array;
      
      public function CommandNYGiftSend(param1:UserInfo, param2:NYGiftDescription, param3:uint, param4:uint = 0)
      {
         super();
         this.user = param1;
         rpcRequest = new RpcRequest("newYearGiftSend");
         rpcRequest.writeParam("userId",param1.id);
         rpcRequest.writeParam("giftNum",param2.id);
         rpcRequest.writeParam("amount",param3);
         rpcRequest.writeParam("inReplayTo",param4);
         _cost = new CostData();
         _cost.addInventoryItem(param2.cost.outputDisplayFirst.item,param2.cost.outputDisplayFirst.amount * param3);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         command_sendRequests();
         super.clientExecute(param1);
      }
      
      protected function command_sendRequests() : CommandSocialSendRequest
      {
         var _loc1_:* = null;
         var _loc3_:Vector.<PlatformUser> = new Vector.<PlatformUser>();
         var _loc2_:PlatformUser = GameModel.instance.context.platformFacade.getPlatformUserById(user.accountId);
         if(_loc2_)
         {
            _loc3_.push(_loc2_);
            _loc1_ = DataStorage.notification.getByIdent("newYear2018Gift");
            return GameModel.instance.actionManager.platform.requestSend(_loc3_,_loc1_);
         }
         return null;
      }
      
      override protected function successHandler() : void
      {
         resultGiftIds = result.body.giftIds;
         _reward = new RewardData(result.body.reward);
         super.successHandler();
      }
   }
}
