package game.data.storage.rune
{
   import game.data.storage.DataStorage;
   
   public class RuneLevelDescription
   {
       
      
      private var _level:int;
      
      private var _heroLevel:int;
      
      private var _enchantValue:int;
      
      private var _goldPerEnchantPoint:int;
      
      private var _summaryGoldCost:int;
      
      public function RuneLevelDescription(param1:*)
      {
         super();
         _level = param1.level;
         _heroLevel = param1.heroLevel;
         _enchantValue = param1.enchantValue;
         _goldPerEnchantPoint = param1.goldPerEnchantPoint;
         _summaryGoldCost = param1.summaryGoldCost;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get heroLevel() : int
      {
         return _heroLevel;
      }
      
      public function get enchantValue() : int
      {
         return _enchantValue;
      }
      
      public function get goldPerEnchantPoint() : int
      {
         return _goldPerEnchantPoint;
      }
      
      public function get summaryGoldCost() : int
      {
         return _summaryGoldCost;
      }
      
      public function get nextLevel() : RuneLevelDescription
      {
         return DataStorage.rune.getLevel(_level + 1);
      }
   }
}
