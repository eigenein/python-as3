package game.battle.controller.statistic
{
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   
   public class BattleDamageStatistics
   {
       
      
      public const attackers:BattleDamageStatisticTeamEntry = new BattleDamageStatisticTeamEntry();
      
      public const defenders:BattleDamageStatisticTeamEntry = new BattleDamageStatisticTeamEntry();
      
      public function BattleDamageStatistics()
      {
         super();
      }
      
      public static function deserialize(param1:Object) : BattleDamageStatistics
      {
         var _loc3_:* = null;
         var _loc2_:BattleDamageStatistics = new BattleDamageStatistics();
         var _loc6_:int = 0;
         var _loc5_:* = param1.attackers;
         for(var _loc4_ in param1.attackers)
         {
            _loc3_ = new BattleDamageStatisticEntry(int(_loc4_),int(_loc4_),param1.attackers[_loc4_]);
            _loc2_.attackers.team.push(_loc3_);
         }
         var _loc8_:int = 0;
         var _loc7_:* = param1.defenders;
         for(_loc4_ in param1.defenders)
         {
            _loc3_ = new BattleDamageStatisticEntry(int(_loc4_),int(_loc4_),param1.defenders[_loc4_]);
            _loc2_.defenders.team.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function add(param1:BattleData) : void
      {
         parse(attackers,param1.attackers);
         parse(defenders,param1.defenders);
      }
      
      public function serialize() : Object
      {
         var _loc2_:Object = {};
         _loc2_.attackers = {};
         var _loc4_:int = 0;
         var _loc3_:* = attackers.team;
         for each(var _loc1_ in attackers.team)
         {
            _loc2_.attackers[_loc1_.heroId] = _loc1_.damageDealt;
         }
         _loc2_.defenders = {};
         var _loc6_:int = 0;
         var _loc5_:* = defenders.team;
         for each(_loc1_ in defenders.team)
         {
            _loc2_.defenders[_loc1_.heroId] = _loc1_.damageDealt;
         }
         return _loc2_;
      }
      
      private function parse(param1:BattleDamageStatisticTeamEntry, param2:BattleTeamDescription) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc3_:int = param2.heroes.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = param2.heroes[_loc6_];
            _loc9_ = false;
            _loc10_ = param1.team.length;
            _loc7_ = 0;
            while(_loc7_ < _loc10_)
            {
               _loc8_ = param1.team[_loc7_];
               if(_loc8_.id == _loc5_.id)
               {
                  _loc9_ = true;
                  _loc8_.damageDealt = _loc5_.state.statistics.damageDealt;
                  break;
               }
               if(_loc8_.heroId == _loc5_.heroId)
               {
                  _loc9_ = true;
                  _loc8_.damageDealt = _loc8_.damageDealt + _loc5_.state.statistics.damageDealt;
                  break;
               }
               _loc7_++;
            }
            if(!_loc9_)
            {
               _loc4_ = new BattleDamageStatisticEntry(_loc5_.id,_loc5_.heroId,_loc5_.state.statistics.damageDealt);
               param1.team.push(_loc4_);
            }
            _loc6_++;
         }
      }
   }
}
