package game.command.rpc.refillable
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerAlchemyRefillableEntry;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandAlchemyUse extends CostCommand
   {
      
      public static const MULTI_ROLL:int = 10;
       
      
      private var refillableDesc:RefillableDescription;
      
      private var playerEntry:PlayerAlchemyRefillableEntry;
      
      private var _rewardList:Vector.<AlchemyRewardValueObject>;
      
      private var multiUse:Boolean;
      
      public function CommandAlchemyUse(param1:Boolean)
      {
         super();
         this.multiUse = param1;
         rpcRequest = new RpcRequest("refillableAlchemyUse");
         rpcRequest.writeParam("multi",param1);
         refillableDesc = DataStorage.refillable.getByIdent("alchemy");
      }
      
      public function get rewardList() : Vector.<AlchemyRewardValueObject>
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc5_:int = 0;
         var _loc3_:RefillableDescription = DataStorage.refillable.getByIdent("alchemy");
         var _loc4_:PlayerRefillableEntry = param1.refillable.getById(_loc3_.id);
         var _loc2_:int = !!multiUse?10:1;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            param1.refillable.refill(_loc4_);
            _loc5_++;
         }
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _reward = new RewardData(null);
         var _loc4_:Array = result.body as Array;
         var _loc2_:int = _loc4_.length;
         _rewardList = new Vector.<AlchemyRewardValueObject>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc4_[_loc5_];
            _loc1_ = playerEntry.getCostForAttempt(playerEntry.refillCount + _loc5_);
            _rewardList[_loc5_] = new AlchemyRewardValueObject(new RewardData(_loc3_.reward),_cost,_loc3_.crit,_loc3_.tryNumber);
            _loc5_++;
         }
         super.successHandler();
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         playerEntry = param1.refillable.getById(refillableDesc.id) as PlayerAlchemyRefillableEntry;
         _cost = new CostData();
         _cost.add(playerEntry.getCostForAttempt(playerEntry.refillCount));
         var _loc2_:int = !!multiUse?10:1;
         _cost.multiply(_loc2_);
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         if(!(playerEntry && playerEntry.refillCount + _loc2_ <= playerEntry.maxRefillCount))
         {
            _loc3_.vipLevel = playerEntry.getVipLevelToRefill(_loc2_);
         }
         return _loc3_;
      }
   }
}
