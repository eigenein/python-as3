package game.mechanics.boss.model
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandBossRaid extends RPCCommandBase
   {
       
      
      public var reward:RewardData;
      
      public function CommandBossRaid(param1:PlayerBossEntry)
      {
         super();
         rpcRequest = new RpcRequest("bossRaid");
         rpcRequest.writeParam("bossId",param1.type.id);
         rpcRequest.writeRequest(new RpcRequest("bossGetAll"),"bossGetAll");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         reward = new RewardData(result.body.everyWinReward);
         param1.takeReward(reward);
         param1.boss.updateAll(result.data["bossGetAll"]);
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
