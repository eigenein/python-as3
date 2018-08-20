package game.data.storage.battle
{
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import game.battle.BattleDataFactory;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   
   public class BattleTeam
   {
       
      
      public var heroes:Vector.<HeroEntry>;
      
      public function BattleTeam(param1:Object)
      {
         var _loc4_:int = 0;
         super();
         heroes = new Vector.<HeroEntry>();
         var _loc2_:Array = param1.heroes;
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            heroes[_loc4_] = new HeroEntry(null,new HeroEntrySourceData(_loc2_[_loc4_]));
            _loc4_++;
         }
      }
      
      public function createBattleTeamDescription() : BattleTeamDescription
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc3_:BattleTeamDescription = new BattleTeamDescription();
         var _loc1_:int = heroes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = BattleDataFactory.createHeroByEntry(heroes[_loc2_]);
            _loc3_.heroes.push(_loc4_);
            _loc2_++;
         }
         return _loc3_;
      }
   }
}
