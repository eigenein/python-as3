package game.data.storage.refillable
{
   import game.data.cost.CostData;
   import game.data.storage.DescriptionBase;
   
   public class RefillableDescription extends DescriptionBase
   {
      
      public static const STAMINA:String = "stamina";
      
      public static const SKILLPOINT:String = "skill_point";
      
      public static const ARENA_BATTLE:String = "arena_battle";
      
      public static const ARENA_COOLDOWN:String = "arena_cooldown";
      
      public static const GRAND_BATTLE:String = "grand_arena_battle";
      
      public static const GRAND_COOLDOWN:String = "grand_arena_cooldown";
      
      public static const ELITE_MISSION_RESET:String = "eliteMission";
      
      public static const ALCHEMY:String = "alchemy";
      
      public static const CLAN_ENTER_COOLDOWN:String = "clanReenter_cooldown";
      
      public static const BOSS_BATTLE:String = "boss_battle";
      
      public static const BOSS_COOLDOWN:String = "boss_cooldown";
       
      
      public var ident:String;
      
      public var refillSeconds:Number;
      
      public var maxValue:Vector.<int>;
      
      public var refillCost:Vector.<CostData>;
      
      public var maxRefillCount:Vector.<int>;
      
      public var refillAmount:int;
      
      public function RefillableDescription(param1:Object)
      {
         super();
         _id = param1.id;
         ident = param1.ident;
         refillAmount = param1.refillAmount;
         refillSeconds = param1.refillSeconds;
         parseIntVect("maxValue",param1);
         parseIntVect("maxRefillCount",param1);
         parseCostVect("refillCost",param1);
      }
      
      public static function removeMaxRefillCount(param1:RefillableDescription) : void
      {
         param1.maxRefillCount = null;
      }
      
      public function maxValueByLevel(param1:int) : int
      {
         if(!maxValue)
         {
            return 0;
         }
         if(param1 < maxValue.length)
         {
            return maxValue[param1];
         }
         return maxValue[maxValue.length - 1];
      }
      
      public function refillCostByLevel(param1:int) : CostData
      {
         if(!refillCost)
         {
            return null;
         }
         if(param1 < refillCost.length)
         {
            return refillCost[param1];
         }
         return refillCost[refillCost.length - 1];
      }
      
      public function maxRefillCountByLevel(param1:int) : int
      {
         if(!maxRefillCount)
         {
            return 0;
         }
         if(param1 < maxRefillCount.length)
         {
            return maxRefillCount[param1];
         }
         return maxRefillCount[maxRefillCount.length - 1];
      }
      
      private function parseCostVect(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Vector.<CostData> = null;
         if(param2[param1] is Array)
         {
            _loc4_ = new Vector.<CostData>();
            _loc3_ = param2[param1].length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_[_loc5_] = new CostData(param2[param1][_loc5_]);
               _loc5_++;
            }
         }
         this[param1] = _loc4_;
      }
      
      private function parseIntVect(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(param2[param1] is Array)
         {
            _loc4_ = new Vector.<int>();
            _loc3_ = param2[param1].length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_[_loc5_] = param2[param1][_loc5_];
               _loc5_++;
            }
         }
         this[param1] = _loc4_;
      }
   }
}
