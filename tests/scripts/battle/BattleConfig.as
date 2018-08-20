package battle
{
   import flash.Boot;
   
   public class BattleConfig
   {
       
      
      public var stunRate:Number;
      
      public var skillRangeOffset:Number;
      
      public var rightTeamStartPosition:Number;
      
      public var rightBattleBorder:Number;
      
      public var passiveHpBuffs:Vector.<String>;
      
      public var maxGlobalCooldown:Number;
      
      public var leftTeamStartPosition:Number;
      
      public var leftBattleBorder:Number;
      
      public var inTeamHeroInterval:Number;
      
      public var immediateDefendersUltimates:Boolean;
      
      public var immediateAttackersUltimates:Boolean;
      
      public var heroSize:Number;
      
      public var energyPerKill:Number;
      
      public var energyPerAttack:int;
      
      public var energyHurtMultiplyer:Number;
      
      public var defaultMaxEnergy:int;
      
      public var defaultHeroSpeed:Number;
      
      public var defaultCastCooldown:Number;
      
      public var defaultAnimationDelay:Number;
      
      public var critMultiplier:Number;
      
      public var controllEffects:Vector.<String>;
      
      public var battleDuration:Number;
      
      public function BattleConfig()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         immediateAttackersUltimates = true;
         immediateDefendersUltimates = false;
         maxGlobalCooldown = 0.85;
         leftBattleBorder = -100;
         rightBattleBorder = 1100;
         leftTeamStartPosition = 300;
         rightTeamStartPosition = 700;
         inTeamHeroInterval = 80;
         heroSize = 25;
         skillRangeOffset = 125;
         defaultHeroSpeed = 160;
         defaultAnimationDelay = 0.5;
         critMultiplier = 2;
         stunRate = 0.2;
         defaultCastCooldown = 2;
         energyHurtMultiplyer = 1;
         energyPerAttack = 100;
         energyPerKill = 300;
         defaultMaxEnergy = 1000;
         battleDuration = 120;
         passiveHpBuffs = Vector.<String>(["PveModifier","PassiveSelfBuff","PassiveAllyTeamBuff"]);
         controllEffects = Vector.<String>(["silence","stun","knockup","Silence","Stun","Knockup"]);
      }
   }
}
