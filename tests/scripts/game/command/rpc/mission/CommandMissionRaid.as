package game.command.rpc.mission
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.pve.mission.MissionDescription;
   import game.model.user.Player;
   import game.model.user.mission.PlayerEliteMissionEntry;
   
   public class CommandMissionRaid extends CostCommand
   {
       
      
      private var mission:MissionDescription;
      
      private var times:int;
      
      private var _rewardList:Vector.<RewardData>;
      
      private var _raidReward:RewardData;
      
      public function CommandMissionRaid(param1:MissionDescription, param2:int)
      {
         super();
         this.times = param2;
         this.mission = param1;
         rpcRequest = new RpcRequest("missionRaid");
         rpcRequest.writeParam("id",param1.id);
         rpcRequest.writeParam("times",param2);
         _cost = param1.totalCost.clone() as CostData;
         _cost.multiply(param2);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:PlayerEliteMissionEntry = param1.missions.getByDesc(mission) as PlayerEliteMissionEntry;
         param1.missions.missionRaid(mission,times);
         _rewardList = new Vector.<RewardData>();
         _reward = new RewardData();
         var _loc5_:int = 0;
         var _loc4_:* = result.body;
         for(var _loc3_ in result.body)
         {
            if(_loc3_ == "raid")
            {
               _raidReward = new RewardData(result.body[_loc3_]);
               if(param1.clan.clan)
               {
                  _raidReward.clanActivity = _cost.stamina;
               }
               _reward.addRawData(result.body[_loc3_]);
            }
            else
            {
               rewardList.push(new RewardData(result.body[_loc3_]));
               _reward.addRawData(result.body[_loc3_]);
            }
         }
         super.clientExecute(param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:* = null;
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         if(mission.isHeroic)
         {
            _loc2_ = param1.missions.getByDesc(mission) as PlayerEliteMissionEntry;
            if(_loc2_ && _loc2_.eliteTries)
            {
               _loc3_.invalid = _loc2_.eliteTries.value < times;
            }
         }
         return _loc3_;
      }
      
      public function get rewardList() : Vector.<RewardData>
      {
         return _rewardList;
      }
      
      public function get raidReward() : RewardData
      {
         return _raidReward;
      }
   }
}
