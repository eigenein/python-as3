package game.data.storage.level
{
   public class PlayerTeamLevel extends LevelBase
   {
       
      
      public var delta:int;
      
      public var maxStamina:int;
      
      public var levelUpRewardStamina:int;
      
      public var maxHeroLevel:int;
      
      public var maxTitanLevel:int;
      
      public var goldConst:Number;
      
      public function PlayerTeamLevel(param1:Object)
      {
         super(param1);
         delta = param1.delta;
         maxStamina = param1.maxStamina;
         levelUpRewardStamina = param1.levelUpRewardStamina;
         maxHeroLevel = param1.maxHeroLevel;
         maxTitanLevel = param1.maxTitanLevel;
         goldConst = param1.goldConst;
      }
   }
}
