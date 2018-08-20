package game.battle.controller.statistic
{
   public class BattleDamageStatisticTeamEntry
   {
       
      
      private var _team:Vector.<BattleDamageStatisticEntry>;
      
      public function BattleDamageStatisticTeamEntry()
      {
         _team = new Vector.<BattleDamageStatisticEntry>();
         super();
      }
      
      public function get team() : Vector.<BattleDamageStatisticEntry>
      {
         return _team;
      }
      
      public function getStat(param1:int) : BattleDamageStatisticEntry
      {
         var _loc3_:int = 0;
         var _loc2_:int = _team.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_team[_loc3_].heroId == param1)
            {
               return _team[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
   }
}
