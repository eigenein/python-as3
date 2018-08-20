package game.mechanics.grand.mediator
{
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.command.rpc.grand.GrandBattleResult;
   import game.data.storage.DataStorage;
   import game.data.storage.arena.ArenaRewardDescription;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class GrandBattleResultValueObject
   {
       
      
      private var player:Player;
      
      private var entry:GrandBattleResult;
      
      private var battleIndex:int;
      
      public function GrandBattleResultValueObject(param1:Player, param2:GrandBattleResult, param3:int)
      {
         super();
         this.player = param1;
         this.entry = param2;
         this.battleIndex = param3;
      }
      
      public function get oldPlace() : int
      {
         return entry.oldPlace;
      }
      
      public function get newPlace() : int
      {
         return entry.newPlace;
      }
      
      public function get attacker() : UserInfo
      {
         return entry.attacker;
      }
      
      public function get defender() : UserInfo
      {
         return entry.defender;
      }
      
      public function get battleCount() : int
      {
         return entry.battles.length;
      }
      
      public function get placeReward() : ArenaRewardDescription
      {
         return DataStorage.arena.getRewardByPlace(entry.newPlace);
      }
      
      public function get placeRewardChanged() : Boolean
      {
         var _loc2_:int = Math.max(player.arena.getPlace(),entry.oldPlace);
         var _loc1_:ArenaRewardDescription = DataStorage.arena.getRewardByPlace(_loc2_);
         return _loc1_ != placeReward;
      }
      
      public function get win() : Boolean
      {
         return entry.battles[battleIndex].win;
      }
      
      public function get currentBattle() : ArenaBattleResultValueObject
      {
         return entry.battles[battleIndex];
      }
      
      public function getBattleAt(param1:int) : ArenaBattleResultValueObject
      {
         return entry.battles[param1];
      }
      
      public function getScoreString(param1:int = -1) : String
      {
         var _loc4_:int = 0;
         if(param1 == -1)
         {
            param1 = this.battleIndex;
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ <= param1)
         {
            if(entry.battles[_loc4_].win)
            {
               _loc2_++;
            }
            else
            {
               _loc3_++;
            }
            _loc4_++;
         }
         return _loc2_ + " : " + _loc3_;
      }
   }
}
