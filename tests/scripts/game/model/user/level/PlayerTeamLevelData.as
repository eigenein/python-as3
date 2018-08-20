package game.model.user.level
{
   import game.data.storage.DataStorage;
   import game.data.storage.level.PlayerTeamLevel;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTeamLevelData
   {
       
      
      private var _experience:int;
      
      private var _level:PlayerTeamLevel;
      
      private var _signal_levelUp:Signal;
      
      public function PlayerTeamLevelData()
      {
         _signal_levelUp = new Signal(PlayerTeamLevel);
         super();
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      public function get experience() : int
      {
         return _experience;
      }
      
      public function set experience(param1:int) : void
      {
         _experience = param1;
         if(_level == null)
         {
            updateLevel();
         }
         var _loc2_:PlayerTeamLevel = _level;
         while(_level.nextLevel && _experience >= _level.delta)
         {
            _experience = _experience - _level.delta;
            _level = _level.nextLevel as PlayerTeamLevel;
         }
         if(!_level.nextLevel)
         {
            _experience = 0;
         }
         if(_loc2_ != _level)
         {
            _signal_levelUp.dispatch(_loc2_);
         }
      }
      
      public function get level() : PlayerTeamLevel
      {
         return _level;
      }
      
      public function get nextLeveLExpirience() : int
      {
         return !!_level?_level.delta:0;
      }
      
      public function init(param1:int, param2:int) : void
      {
         _level = DataStorage.level.getTeamLevelByLevel(param1);
         this.experience = param2;
      }
      
      private function updateLevel() : void
      {
         _level = DataStorage.level.getTeamLevel(experience);
      }
   }
}
