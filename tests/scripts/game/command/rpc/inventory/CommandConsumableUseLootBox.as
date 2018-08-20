package game.command.rpc.inventory
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   
   public class CommandConsumableUseLootBox extends CostCommand
   {
       
      
      private var amount:int;
      
      private var item:ConsumableDescription;
      
      private var _rewardList:Vector.<RewardData>;
      
      private var _lootBoxRewardValueObjectList:LootBoxRewardValueObjectList;
      
      public function CommandConsumableUseLootBox(param1:ConsumableDescription, param2:int, param3:int = -1)
      {
         super();
         this.item = param1;
         this.amount = param2;
         rpcRequest = new RpcRequest("consumableUseLootBox");
         rpcRequest.writeParam("libId",param1.id);
         rpcRequest.writeParam("amount",param2);
         if(param3 != -1)
         {
            rpcRequest.writeParam("playerRewardChoiceIndex",param3);
         }
         _cost = new CostData();
         _cost.addInventoryItem(param1,param2);
      }
      
      public function get rewardList() : Vector.<RewardData>
      {
         return _rewardList;
      }
      
      public function get lootBoxRewardValueObjectList() : LootBoxRewardValueObjectList
      {
         return _lootBoxRewardValueObjectList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         _rewardList = new Vector.<RewardData>();
         _reward = new RewardData();
         var _loc3_:int = 0;
         var _loc2_:* = result.body;
         for(var _loc1_ in result.body)
         {
            rewardList.push(new RewardData(result.body[_loc1_]));
            _reward.addRawData(result.body[_loc1_]);
         }
         _lootBoxRewardValueObjectList = new LootBoxRewardValueObjectList(_rewardList,item);
         super.successHandler();
      }
   }
}
