package game.command.rpc.artifact
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestLevelUpRewardVO;
   
   public class CommandArtifactChestOpen extends CostCommand
   {
       
      
      private var player:Player;
      
      private var _amount:uint;
      
      private var _free:Boolean;
      
      private var _rewardList:Vector.<RewardData>;
      
      private var _levelUpRewards:Vector.<ArtifactChestLevelUpRewardVO>;
      
      private var _newLevel:int;
      
      public function CommandArtifactChestOpen(param1:Player, param2:uint, param3:Boolean)
      {
         super();
         this.player = param1;
         _amount = param2;
         _free = param3;
         rpcRequest = new RpcRequest("artifactChestOpen");
         rpcRequest.writeParam("amount",param2);
         rpcRequest.writeParam("free",param3);
         _cost = new CostData();
         if(param2 == 100)
         {
            _cost = param1.specialOffer.costReplace.artifactChestX100(DataStorage.rule.artifactChestRule.openCostX100);
         }
         else if(param2 == 10)
         {
            if(_free)
            {
               _cost = param1.specialOffer.costReplace.artifactChestX10Free(DataStorage.rule.artifactChestRule.openCostX10Free);
            }
            else
            {
               _cost = param1.specialOffer.costReplace.artifactChestX10(DataStorage.rule.artifactChestRule.openCostX10);
            }
         }
         else
         {
            _cost = param1.specialOffer.costReplace.artifactChestX1(DataStorage.rule.artifactChestRule.openCostX1);
         }
      }
      
      public function get amount() : uint
      {
         return _amount;
      }
      
      public function get free() : Boolean
      {
         return _free;
      }
      
      public function get rewardList() : Vector.<RewardData>
      {
         return _rewardList;
      }
      
      public function get levelUpRewards() : Vector.<ArtifactChestLevelUpRewardVO>
      {
         return _levelUpRewards;
      }
      
      public function get newLevel() : int
      {
         return _newLevel;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         var _loc3_:int = 0;
         player.artifactChest.update(result.body);
         _reward = new RewardData(null);
         _rewardList = new Vector.<RewardData>();
         var _loc4_:Array = result.body.chestReward;
         var _loc1_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _reward.addRawData(_loc4_[_loc3_]);
            _rewardList.push(new RewardData(_loc4_[_loc3_]));
            _loc3_++;
         }
         if(result.body.newLevel > 0)
         {
            _levelUpRewards = new Vector.<ArtifactChestLevelUpRewardVO>();
            var _loc6_:int = 0;
            var _loc5_:* = result.body.levelUpReward;
            for(var _loc2_ in result.body.levelUpReward)
            {
               _levelUpRewards.push(new ArtifactChestLevelUpRewardVO(_loc2_,new RewardData(result.body.levelUpReward[_loc2_])));
               _reward.addRawData(result.body.levelUpReward[_loc2_]);
            }
         }
         super.successHandler();
      }
   }
}
