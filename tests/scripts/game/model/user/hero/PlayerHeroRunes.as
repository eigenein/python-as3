package game.model.user.hero
{
   import battle.BattleStats;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.rune.RuneTierDescription;
   import game.data.storage.rune.RuneTypeDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerHeroRunes
   {
      
      public static const MAX_SLOTS_COUNT:int = 5;
       
      
      private const enchantment:Vector.<int> = new Vector.<int>(5,true);
      
      private var _color:HeroColorData;
      
      private var runes:Vector.<RuneTypeDescription>;
      
      public const stats:BattleStats = new BattleStats();
      
      public const signal_runeUpdated:Signal = new Signal(RuneTierDescription);
      
      public function PlayerHeroRunes()
      {
         super();
      }
      
      public function initialize(param1:Vector.<RuneTypeDescription>, param2:Array) : void
      {
         var _loc3_:int = 0;
         this.runes = param1;
         if(param2 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               this.enchantment[_loc3_] = int(param2[_loc3_]);
               _loc3_++;
            }
         }
         updateStats();
      }
      
      public function getRuneLevel(param1:int) : int
      {
         if(param1 < 0 || param1 >= 5)
         {
            return 0;
         }
         return DataStorage.rune.getLevelByEnchantment(enchantment[param1]);
      }
      
      public function getMaxLevel(param1:int) : int
      {
         return DataStorage.rune.maxLevel;
      }
      
      public function getRuneEnchantment(param1:int) : int
      {
         return enchantment[param1];
      }
      
      public function getRuneNextLevelEnchantment(param1:int) : int
      {
         var _loc2_:int = DataStorage.rune.getLevelByEnchantment(enchantment[param1]);
         if(_loc2_ >= getMaxLevel(param1))
         {
            return DataStorage.rune.getLevel(_loc2_).enchantValue;
         }
         return DataStorage.rune.getLevel(_loc2_ + 1).enchantValue;
      }
      
      public function getRuneLevelEnchantment(param1:int) : int
      {
         var _loc2_:int = DataStorage.rune.getLevelByEnchantment(enchantment[param1]);
         if(_loc2_ == 0)
         {
            return 0;
         }
         return DataStorage.rune.getLevel(_loc2_).enchantValue;
      }
      
      function enchantSlot(param1:int, param2:int) : void
      {
         var _loc3_:* = param1;
         var _loc4_:* = enchantment[_loc3_] + param2;
         enchantment[_loc3_] = _loc4_;
         updateStats();
         signal_runeUpdated.dispatch(DataStorage.rune.getTier(param1));
      }
      
      private function updateStats() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:* = null;
         stats.nullify();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(enchantment[_loc2_] > 0)
            {
               _loc1_ = DataStorage.rune.getLevelByEnchantment(enchantment[_loc2_]);
               _loc3_ = runes[_loc2_];
               stats[_loc3_.stat] = stats[_loc3_.stat] + _loc3_.getValueByLevel(_loc1_);
            }
            _loc2_++;
         }
      }
   }
}
