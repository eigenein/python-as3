package game.command.tower
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.model.user.Player;
   
   public class CommandTowerChooseDifficulty extends RPCCommandBase
   {
       
      
      private var difficulty:TowerBattleDifficulty;
      
      public function CommandTowerChooseDifficulty(param1:TowerBattleDifficulty)
      {
         super();
         this.difficulty = param1;
         rpcRequest = new RpcRequest("towerChooseDifficulty");
         rpcRequest.writeParam("difficulty",param1.value);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.tower.chooseDifficulty(difficulty);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
