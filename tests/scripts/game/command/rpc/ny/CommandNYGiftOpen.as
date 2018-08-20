package game.command.rpc.ny
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.ny.NewYearGiftData;
   
   public class CommandNYGiftOpen extends CostCommand
   {
       
      
      private var player:Player;
      
      public var gift:NewYearGiftData;
      
      public function CommandNYGiftOpen(param1:NewYearGiftData)
      {
         super();
         this.gift = param1;
         player = GameModel.instance.player;
         rpcRequest = new RpcRequest("newYearGiftOpen");
         rpcRequest.writeParam("giftId",param1.id);
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body);
         player.ny.giftsToOpen--;
         super.successHandler();
      }
   }
}
