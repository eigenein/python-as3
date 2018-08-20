package game.command.rpc.chest
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   
   public class CommandChestBuyDevMulti extends CostCommand
   {
       
      
      public function CommandChestBuyDevMulti(param1:int = 1)
      {
         var _loc3_:int = 0;
         super();
         this.rpcRequest = addRequest();
         _cost = new CostData();
         _cost.starmoney = _cost.starmoney + DataStorage.chest.CHEST_TOWN.cost.starmoney;
         var _loc2_:int = param1 - 1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.rpcRequest.writeRequest(addRequest(),"open_" + _loc3_);
            _cost.starmoney = _cost.starmoney + DataStorage.chest.CHEST_TOWN.cost.starmoney;
            _loc3_++;
         }
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _reward = new RewardData();
         var _loc6_:int = 0;
         var _loc5_:* = result.data;
         for(var _loc3_ in result.data)
         {
            _loc1_ = result.data[_loc3_].rewards;
            _loc2_ = _loc1_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _reward.add(new RewardData(_loc1_[_loc4_]));
               _loc4_++;
            }
         }
         super.successHandler();
      }
      
      private function addRequest() : RpcRequest
      {
         var _loc1_:RpcRequest = new RpcRequest("chestBuy");
         _loc1_.writeParam("chest",DataStorage.chest.CHEST_TOWN.ident);
         _loc1_.writeParam("free",false);
         _loc1_.writeParam("pack",true);
         return _loc1_;
      }
   }
}
