package game.view.popup.test
{
   import battle.HeroStats;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.boss.storage.BossLevelDescription;
   import game.mechanics.boss.storage.BossTypeDescription;
   
   public class BattleTestBossStatsManager
   {
       
      
      public function BattleTestBossStatsManager()
      {
         super();
      }
      
      public static function apply(param1:int, param2:int, param3:HeroStats) : String
      {
         var _loc4_:UnitDescription = DataStorage.hero.getUnitById(param1);
         if(_loc4_.unitType != "boss")
         {
            return "Юнит " + unitName(_loc4_) + " принят за босса, но боссом не является";
         }
         var _loc7_:BossTypeDescription = DataStorage.boss.getBossByUnitId(param1);
         if(_loc7_ == null)
         {
            return "Для босса " + unitName(_loc4_) + " нет описания типа босса";
         }
         var _loc6_:BossLevelDescription = _loc7_.getLevel(param2);
         if(_loc6_ == null)
         {
            return "Для босса " + unitName(_loc4_) + " " + param2 + " уровня нет описания статов";
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_.battleStats;
         for(var _loc5_ in _loc6_.battleStats)
         {
            param3[_loc5_] = _loc6_.battleStats[_loc5_];
         }
         return null;
      }
      
      protected static function applyHeroStats(param1:HeroStats, param2:BossLevelDescription) : void
      {
         var _loc3_:Object = param2.battleStats;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for(var _loc4_ in _loc3_)
         {
            param1[_loc4_] = _loc3_[_loc4_];
         }
      }
      
      protected static function unitName(param1:UnitDescription) : String
      {
         return "[" + param1.id + "] " + param1.name;
      }
   }
}
