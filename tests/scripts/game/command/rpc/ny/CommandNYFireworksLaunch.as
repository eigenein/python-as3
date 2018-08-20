package game.command.rpc.ny
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   
   public class CommandNYFireworksLaunch extends CostCommand
   {
       
      
      public function CommandNYFireworksLaunch(param1:Boolean, param2:Boolean)
      {
         super();
         rpcRequest = new RpcRequest("fireworksLaunch");
         rpcRequest.writeParam("hideName",param1);
         rpcRequest.writeParam("hideClan",param2);
         _cost = DataStorage.rule.ny2018TreeRule.fireworks.decorateAction.cost;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.ny.treeLevel = result.body.treeLevel;
         param1.ny.treeExpPercent = result.body.treeExpPercent;
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body.reward);
         super.successHandler();
      }
   }
}
