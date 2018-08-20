package game.command.rpc.hero
{
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.resource.ConsumableDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class CommandHeroConsumableUseXPAggregator
   {
      
      private static var unsentCommandsByKey:Dictionary = new Dictionary();
       
      
      public function CommandHeroConsumableUseXPAggregator()
      {
         super();
      }
      
      public static function flush() : Vector.<CommandHeroConsumableUseXP>
      {
         var _loc1_:Vector.<CommandHeroConsumableUseXP> = new Vector.<CommandHeroConsumableUseXP>();
         var _loc4_:int = 0;
         var _loc3_:* = unsentCommandsByKey;
         for each(var _loc2_ in unsentCommandsByKey)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sort(CommandHeroConsumableUseXP.sort_byPotionReward);
         unsentCommandsByKey = new Dictionary();
         return _loc1_;
      }
      
      public static function addCommand(param1:Player, param2:PlayerHeroEntry, param3:ConsumableDescription, param4:int) : CommandHeroConsumableUseXP
      {
         var _loc8_:String = param2.id + "." + param3.id;
         var _loc7_:CommandHeroConsumableUseXP = unsentCommandsByKey[_loc8_];
         if(_loc7_)
         {
            _loc7_.addAmount(param4);
         }
         else
         {
            _loc7_ = new CommandHeroConsumableUseXP(param2,param3,param4);
            unsentCommandsByKey[_loc8_] = _loc7_;
         }
         var _loc6_:CostData = new CostData();
         _loc6_.addInventoryItem(param3,param4);
         var _loc5_:RewardData = new RewardData();
         _loc5_.addHeroXp(param2.hero,param3.rewardAmount * param4);
         param1.spendCost(_loc6_);
         param1.takeReward(_loc5_);
         return _loc7_;
      }
   }
}
