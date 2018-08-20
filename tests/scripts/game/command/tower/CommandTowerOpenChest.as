package game.command.tower
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.tower.TowerChestValueObject;
   import game.model.user.Player;
   
   public class CommandTowerOpenChest extends CostCommand
   {
       
      
      private var chest:TowerChestValueObject;
      
      public function CommandTowerOpenChest(param1:TowerChestValueObject)
      {
         super();
         this.chest = param1;
         rpcRequest = new RpcRequest("towerOpenChest");
         rpcRequest.writeParam("num",param1.entry.num);
         _cost = param1.cost;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         var _loc3_:* = result.body;
         var _loc2_:RewardData = new RewardData(_loc3_.reward);
         param1.takeReward(_loc2_);
         param1.tower.updateChestReward(_loc3_.num,_loc2_,_loc3_.opened,_loc3_.critMultiplier);
      }
      
      override protected function successHandler() : void
      {
         super.successHandler();
      }
   }
}
