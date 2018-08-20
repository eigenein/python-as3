package game.command.tower
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.tower.PlayerTowerBuffEntry;
   
   public class CommandTowerBuyBuff extends CostCommand
   {
       
      
      public function CommandTowerBuyBuff(param1:PlayerTowerBuffEntry, param2:int = 3)
      {
         super();
         rpcRequest = new RpcRequest("towerBuyBuff");
         rpcRequest.writeParam("buffId",param1.buff.id);
         if(param1.buff.type == "hero")
         {
            rpcRequest.writeParam("heroId",param2);
         }
         _cost = param1.buff.cost;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.tower.parseNewState(result.body);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
