package game.data.storage.battle
{
   import battle.data.BattleData;
   import game.data.storage.DescriptionBase;
   
   public class BattleDescription extends DescriptionBase
   {
       
      
      private var teams:Vector.<BattleTeam>;
      
      public function BattleDescription(param1:Object)
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super();
         if(param1)
         {
            _id = param1.id;
            _name = param1.name;
            _loc4_ = param1.scenario.teams;
            teams = new Vector.<BattleTeam>();
            _loc2_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               teams[_loc3_] = new BattleTeam(_loc4_[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function createBattleData() : BattleData
      {
         var _loc1_:BattleData = new BattleData();
         if(teams.length < 2)
         {
            return null;
         }
         _loc1_.attackers = teams[0].createBattleTeamDescription();
         _loc1_.attackers.direction = 1;
         _loc1_.defenders = teams[1].createBattleTeamDescription();
         _loc1_.defenders.direction = -1;
         _loc1_.seed = int(Math.random() * 16777215);
         return _loc1_;
      }
   }
}
