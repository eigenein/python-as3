package battle
{
   import battle.skills.Context;
   
   public class BattleCore
   {
      
      public static var ARMOR_SCALE_FACTOR:Number = 3000;
      
      public static var lastRandomRoll:int;
       
      
      public function BattleCore()
      {
      }
      
      public static function random(param1:Number, param2:Number) : int
      {
         var _loc3_:int = Context.engine.randomSource(int(param1),int(param2));
         BattleCore.lastRandomRoll = _loc3_;
         return _loc3_;
      }
      
      public static function rollPercent(param1:Number) : Boolean
      {
         var _loc2_:int = Context.engine.randomSource(1,100);
         BattleCore.lastRandomRoll = _loc2_;
         return param1 >= _loc2_;
      }
      
      public static function rollMiss(param1:HeroStats, param2:HeroStats) : Boolean
      {
         var _loc3_:int = Context.engine.randomSource(1,100);
         BattleCore.lastRandomRoll = _loc3_;
         return Number(100 + param1.accuracy) < _loc3_;
      }
      
      public static function rollDodge(param1:HeroStats, param2:HeroStats) : Boolean
      {
         var _loc3_:int = Context.engine.randomSource(1,int(Number(param2.dodge + param1.antidodge)));
         BattleCore.lastRandomRoll = _loc3_;
         return param2.dodge >= _loc3_;
      }
      
      public static function rollCrit(param1:HeroStats, param2:HeroStats) : Boolean
      {
         var _loc3_:int = Context.engine.randomSource(1,int(Number(param1.physicalCritChance + param2.anticrit)));
         BattleCore.lastRandomRoll = _loc3_;
         return param1.physicalCritChance >= _loc3_;
      }
      
      public static function rollHitrate(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 < 0 || param1 >= param2)
         {
            return true;
         }
         if(param1 > 0)
         {
            _loc3_ = Context.engine.randomSource(1,4 + param2 - param1);
            return _loc3_ < 4;
         }
         return false;
      }
      
      public static function hitrateIntensity(param1:int, param2:int, param3:int = 4) : Number
      {
         if(param1 < 0 || param1 >= param2)
         {
            return 1;
         }
         if(param1 > 0)
         {
            return param3 / (param3 + param2 - param1);
         }
         return 0;
      }
      
      public static function getSkillRange(param1:Number, param2:Hero, param3:BattleConfig) : Number
      {
         return param1 + param3.skillRangeOffset * param2.desc.scale - 70 * (1 - param2.desc.scale);
      }
      
      public static function getPenetration(param1:Number, param2:Number, param3:Number) : int
      {
         param2 = Number(param2 - param3);
         if(param2 < 0)
         {
            param2 = 0;
         }
         return int(param1 / (Number(1 + param2 / 3000)));
      }
      
      public static function getElementalPenetration(param1:Number, param2:Number) : int
      {
         if(param2 < 0)
         {
            param2 = 0;
         }
         return int(param1 / (Number(1 + param2 / 300000)));
      }
   }
}
