package game.mechanics.titan_arena.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import idv.cjcat.signals.Signal;
   
   public class CommandTitanArenaTrophyRewardFarm extends RPCCommandBase
   {
      
      public static const TITAN_ARENA_REWARD_TYPE_CHAMPION:String = "champion";
      
      public static const TITAN_ARENA_REWARD_TYPE_SERVER:String = "server";
      
      public static const TITAN_ARENA_REWARD_TYPE_CLAN:String = "clan";
       
      
      private var notFarmedRewardType:String;
      
      private var trophy:PlayerTitanArenaTrophyData;
      
      private var reward:RewardData;
      
      public const signal_rewardFarm:Signal = new Signal(RPCCommandBase);
      
      public function CommandTitanArenaTrophyRewardFarm(param1:PlayerTitanArenaTrophyData)
      {
         super();
         rpcRequest = new RpcRequest("hallOfFameFarmTrophyReward");
         this.trophy = param1;
         if(param1)
         {
            if(!param1.championRewardFarmed && param1.hasChampionReward)
            {
               notFarmedRewardType = "champion";
            }
            else if(!param1.serverRewardFarmed && param1.hasServerReward)
            {
               notFarmedRewardType = "server";
            }
            else if(!param1.clanRewardFarmed && param1.hasClanReward)
            {
               notFarmedRewardType = "clan";
            }
         }
         rpcRequest.writeParam("trophyId",param1.week);
         rpcRequest.writeParam("rewardType",notFarmedRewardType);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(reward)
         {
            param1.takeReward(reward);
            if(trophy)
            {
               var _loc2_:* = notFarmedRewardType;
               if("champion" !== _loc2_)
               {
                  if("server" !== _loc2_)
                  {
                     if("clan" === _loc2_)
                     {
                        trophy.clanRewardFarmed = true;
                     }
                  }
                  else
                  {
                     trophy.serverRewardFarmed = true;
                  }
               }
               else
               {
                  trophy.championRewardFarmed = true;
               }
               if(!trophy.hasNotFarmedReward)
               {
                  param1.titanArenaData.trophyWithNotFarmedReward = null;
               }
            }
         }
         signal_rewardFarm.dispatch(this);
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         if(result.body)
         {
            reward = new RewardData(result.body);
         }
         super.successHandler();
      }
   }
}
