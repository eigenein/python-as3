package game.command.rpc.mission
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandPirateTreasureFarm extends CostCommand
   {
       
      
      public function CommandPirateTreasureFarm()
      {
         super();
         rpcRequest = new RpcRequest("pirateTreasureFarm");
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.easterEggs.action_farmTreasure();
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body);
         super.successHandler();
      }
   }
}
