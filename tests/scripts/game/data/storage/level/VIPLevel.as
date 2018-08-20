package game.data.storage.level
{
   import game.data.storage.DataStorage;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   
   public class VIPLevel extends LevelBase
   {
      
      public static const NOT_AVAILABLE:int = -1;
       
      
      public var rewardModifier:Vector.<int>;
      
      public function VIPLevel(param1:Object)
      {
         super(param1);
         exp = param1.vipPoints;
         if(param1.rewardModifier)
         {
            rewardModifier = Vector.<int>(param1.rewardModifier);
         }
      }
      
      public function getGemsMultiplyer() : Number
      {
         var _loc1_:Vector.<RewardModifierDescription> = DataStorage.rewardModifier.getByVipLevel(this);
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for each(var _loc2_ in _loc1_)
         {
            if(_loc2_.isOnBilling)
            {
               return _loc2_.multiplier;
            }
         }
         return 1;
      }
   }
}
