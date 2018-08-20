package game.model.user.hero
{
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   
   public class PlayerHeroTeamResolver
   {
       
      
      private var heroes:PlayerHeroData;
      
      private var temp_minHeroLevel:int;
      
      public function PlayerHeroTeamResolver(param1:PlayerHeroData)
      {
         super();
         this.heroes = param1;
      }
      
      public function countHeroesOfLevel(param1:int) : int
      {
         this.temp_minHeroLevel = param1;
         var _loc2_:Vector.<PlayerHeroEntry> = heroes.getFilteredList(filter_byMinLevel);
         return !!_loc2_?_loc2_.length:0;
      }
      
      public function countHeroes() : int
      {
         return heroes.getList().length;
      }
      
      public function needMissionTeamGathering() : Boolean
      {
         var _loc1_:int = heroes.getList().length;
         return _loc1_ > 5;
      }
      
      public function gatherDefaultMissionTeam() : Vector.<PlayerHeroEntry>
      {
         var _loc1_:Vector.<PlayerHeroEntry> = heroes.getList();
         if(_loc1_.length > 5)
         {
            _loc1_.length = 5;
         }
         heroes.teamData.saveTeam(heroEntriesToHeroDescriptions(_loc1_),MechanicStorage.MISSION);
         return _loc1_;
      }
      
      public function needArenaTeamGathering() : Boolean
      {
         this.temp_minHeroLevel = MechanicStorage.ARENA.minHeroLevel;
         var _loc1_:Vector.<PlayerHeroEntry> = heroes.getFilteredList(filter_byMinLevel);
         return _loc1_ && _loc1_.length > 5;
      }
      
      public function gatherDefaultArenaTeam() : Vector.<UnitDescription>
      {
         var _loc1_:Vector.<UnitDescription> = getArenaDefenders();
         heroes.teamData.saveTeam(_loc1_,MechanicStorage.ARENA);
         return _loc1_;
      }
      
      public function getArenaDefenders() : Vector.<UnitDescription>
      {
         this.temp_minHeroLevel = MechanicStorage.ARENA.minHeroLevel;
         var _loc1_:Vector.<PlayerHeroEntry> = heroes.getFilteredList(filter_byMinLevel);
         if(_loc1_.length > 5)
         {
            _loc1_.length = 5;
         }
         return heroEntriesToHeroDescriptions(_loc1_);
      }
      
      public function getTowerHeroes() : Vector.<PlayerHeroEntry>
      {
         this.temp_minHeroLevel = MechanicStorage.TOWER.minHeroLevel;
         return heroes.getFilteredList(filter_byMinLevel);
      }
      
      public function getTowerHeroesDescriptions() : Vector.<UnitDescription>
      {
         return heroEntriesToHeroDescriptions(getTowerHeroes());
      }
      
      private function filter_byMinLevel(param1:PlayerHeroEntry) : Boolean
      {
         return param1 && param1.level.level >= temp_minHeroLevel;
      }
      
      private function heroEntriesToHeroDescriptions(param1:Vector.<PlayerHeroEntry>) : Vector.<UnitDescription>
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_[_loc3_] = param1[_loc3_].hero;
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function heroDescriptionsToHeroEntries(param1:Vector.<UnitDescription>) : Vector.<PlayerHeroEntry>
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<PlayerHeroEntry> = new Vector.<PlayerHeroEntry>();
         var _loc4_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = heroes.getById(param1[_loc5_].id);
            if(_loc2_)
            {
               _loc3_.push(_loc2_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
