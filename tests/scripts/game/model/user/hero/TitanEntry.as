package game.model.user.hero
{
   import battle.BattleStats;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.TitanEvolutionStar;
   import game.data.storage.level.HeroLevel;
   import game.data.storage.level.TitanLevel;
   import game.data.storage.titan.TitanDescription;
   import game.data.storage.titan.TitanStarEvolutionData;
   import starling.textures.Texture;
   
   public class TitanEntry extends UnitEntry
   {
       
      
      protected var _titan:TitanDescription;
      
      protected var _level:TitanLevel;
      
      protected var _star:TitanStarEvolutionData;
      
      protected var _precalculatedPower:int;
      
      public function TitanEntry(param1:TitanDescription, param2:TitanEntrySourceData)
      {
         super();
         if(param1)
         {
            _titan = param1;
         }
         else
         {
            _titan = DataStorage.titan.getTitanById(param2.id);
         }
         if(param2)
         {
            parseExp(param2);
            _star = _titan.getStarData(DataStorage.enum.getById_titanEvolutionStar(param2.star));
         }
         else
         {
            _star = _titan.startingStar;
         }
         _precalculatedPower = param2.power;
      }
      
      override public function get id() : uint
      {
         return _titan.id;
      }
      
      public function get titan() : TitanDescription
      {
         return _titan;
      }
      
      public function get level() : HeroLevel
      {
         return _level;
      }
      
      public function get levelMax() : HeroLevel
      {
         var _loc1_:HeroLevel = _level;
         while(_loc1_.nextLevel)
         {
            _loc1_ = _loc1_.nextLevel as HeroLevel;
         }
         return _loc1_;
      }
      
      public function get star() : TitanStarEvolutionData
      {
         return _star;
      }
      
      public function get name() : String
      {
         return _titan.name;
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.inventory.getItemTexture(_titan);
      }
      
      override public function get battleStats() : BattleStats
      {
         return getBasicBattleStats();
      }
      
      override public function getPower() : int
      {
         return _precalculatedPower;
      }
      
      public function getPowerNext(param1:Boolean = false, param2:Boolean = false) : int
      {
         return BattleDataFactory.getTitanStatsPower(getStatsNext(param1,param2),null);
      }
      
      public function getStatsNext(param1:Boolean = false, param2:Boolean = false) : BattleStats
      {
         var _loc4_:HeroLevel = !!param1?_level.nextLevel as HeroLevel:_level;
         var _loc3_:TitanEvolutionStar = !!param2?_star.next.star:_star.star;
         return _titan.getStatsByLevelAndStar(_loc4_,_loc3_);
      }
      
      public function getSortPower() : int
      {
         return getPower();
      }
      
      public function getBasicBattleStatsNextStar() : BattleStats
      {
         return getStatsNext(false,true);
      }
      
      public function getBasicBattleStatsNextLevel() : BattleStats
      {
         return getStatsNext(true,false);
      }
      
      protected function getBasicBattleStats() : BattleStats
      {
         return getStatsNext();
      }
      
      protected function parseExp(param1:TitanEntrySourceData) : void
      {
         _level = DataStorage.level.getTitanLevel(param1.level);
      }
   }
}
