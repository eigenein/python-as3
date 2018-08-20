package game.mechanics.dungeon.model.command
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   
   public class CommandDungeonSaveProgress extends CostCommand
   {
       
      
      private var _respawnFloor:int;
      
      public function CommandDungeonSaveProgress()
      {
         super();
         rpcRequest = new RpcRequest("dungeonSaveProgress");
      }
      
      public function get respawnFloor() : int
      {
         return _respawnFloor;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         _respawnFloor = result.body.dungeon.respawnFloor;
         _reward = new RewardData(result.body.reward);
         super.successHandler();
      }
   }
}
