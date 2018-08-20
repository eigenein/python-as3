package game.data.storage.rune
{
   public class RuneDescriptionStorage
   {
       
      
      private const types:Vector.<RuneTypeDescription> = new Vector.<RuneTypeDescription>();
      
      private const levels:Vector.<RuneLevelDescription> = new Vector.<RuneLevelDescription>();
      
      private const tiers:Vector.<RuneTierDescription> = new Vector.<RuneTierDescription>();
      
      public function RuneDescriptionStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = undefined;
         types.push(null);
         var _loc4_:int = 0;
         var _loc3_:* = param1.type;
         for each(_loc2_ in param1.type)
         {
            types.push(new RuneTypeDescription(_loc2_));
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1.level;
         for each(_loc2_ in param1.level)
         {
            levels.push(new RuneLevelDescription(_loc2_));
         }
         var _loc8_:int = 0;
         var _loc7_:* = param1.tier;
         for each(_loc2_ in param1.tier)
         {
            tiers.push(new RuneTierDescription(_loc2_));
         }
      }
      
      public function get maxLevel() : int
      {
         return levels.length - 1;
      }
      
      public function getTypeById(param1:int) : RuneTypeDescription
      {
         if(param1 <= 0 || param1 > types.length)
         {
            return null;
         }
         return types[param1];
      }
      
      public function getLevel(param1:int) : RuneLevelDescription
      {
         if(param1 < 0 || param1 >= levels.length)
         {
            return null;
         }
         return levels[param1];
      }
      
      public function getTier(param1:int) : RuneTierDescription
      {
         if(param1 < 0 || param1 > tiers.length)
         {
            return null;
         }
         return tiers[param1];
      }
      
      public function getLevelByEnchantment(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = levels.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(levels[_loc3_].enchantValue > param1)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return levels.length - 1;
      }
      
      public function getNextLevelByEnchantment(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = levels.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(levels[_loc3_].enchantValue > param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return levels.length - 1;
      }
      
      public function getMaxLevelByHeroLevel(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = levels.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(levels[_loc3_].heroLevel > param1)
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return levels.length - 1;
      }
   }
}
