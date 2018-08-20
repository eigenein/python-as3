package game.command.rpc.titan
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryItem;
   
   public class CommandTitanLevelUp extends CostCommand
   {
       
      
      private var titan:PlayerTitanEntry;
      
      public function CommandTitanLevelUp(param1:PlayerTitanEntry, param2:InventoryItem)
      {
         super();
         this.titan = param1;
         isImmediate = false;
         rpcRequest = new RpcRequest("titanLevelUp");
         rpcRequest.writeParam("titanId",param1.titan.id);
         _cost = new CostData();
         _cost.starmoney = param2.amount;
         _reward = new RewardData();
         _reward.addTitanXp(param1.titan,Math.round(param2.amount / DataStorage.rule.titanExperienceStarMoneyCost));
         _reward.addInventoryItem(DataStorage.consumable.getTitanSparkDesc(),param1.getPowerNext(true) - param1.getPower());
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:CommandRequirement = super.prerequisiteCheck(param1);
         var _loc3_:int = param1.titans.getMaxTitanExp();
         if(titan.experience > _loc3_)
         {
            _loc2_.invalid = true;
         }
         return _loc2_;
      }
   }
}
