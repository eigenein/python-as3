package game.data.storage.titanarenaleague
{
   import com.progrestar.common.lang.Translate;
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   
   public class TitanArenaLeagueDescription extends DescriptionBase
   {
      
      public static var CHAMPIONS_LEAGUE_ID:uint = 5;
       
      
      public var days:Array;
      
      public var assetBattleground:String;
      
      public var assetScreenBackground:String;
      
      public var divisionSize:uint;
      
      public var promotionSize:uint;
      
      public var battlePointsReward:RewardData;
      
      public var battleVictoryReward:RewardData;
      
      public var bestGuildMemberReward:RewardData;
      
      public var bestOnServerReward:RewardData;
      
      public var dailyReward:RewardData;
      
      public var winnerReward:RewardData;
      
      public function TitanArenaLeagueDescription(param1:Object)
      {
         super();
         this._id = param1.id;
         this.days = param1.days;
         if(param1.asset)
         {
            this.assetBattleground = param1.asset.battleground;
            this.assetScreenBackground = param1.asset.screenBackground;
         }
         if(param1.divisions)
         {
            this.divisionSize = param1.divisions.divisionSize;
            this.promotionSize = param1.divisions.promotionSize;
         }
         if(param1.rewards)
         {
            this.battlePointsReward = new RewardData(param1.rewards.battlePoints);
            this.battleVictoryReward = new RewardData(param1.rewards.battleVictory);
            this.bestGuildMemberReward = new RewardData(param1.rewards.bestGuildMember);
            this.bestOnServerReward = new RewardData(param1.rewards.bestOnServer);
            this.dailyReward = new RewardData(param1.rewards.daily);
            this.winnerReward = new RewardData(param1.rewards.winnerReward);
         }
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_TITAN_ARENA_LEAGUE_NAME_" + id);
         _descText = Translate.translate("LIB_TITAN_ARENA_LEAGUE_DESC_" + id);
      }
   }
}
