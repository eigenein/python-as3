package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandTowerSkipFloor extends RPCCommandBase
   {
       
      
      public function CommandTowerSkipFloor()
      {
         super();
         rpcRequest = new RpcRequest("towerSkipFloor");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         var _loc2_:RewardData = new RewardData(result.body.reward);
         param1.takeReward(_loc2_);
         param1.tower.parseNewState(result.body.tower);
         param1.tower.battleSkipReward(_loc2_);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
