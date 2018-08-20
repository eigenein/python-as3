package game.model.user.refillable
{
   import game.data.storage.level.PlayerTeamLevel;
   import game.model.user.Player;
   
   public class PlayerRefillableLevelSource
   {
       
      
      private var player:Player;
      
      public function PlayerRefillableLevelSource(param1:Player)
      {
         super();
         this.player = param1;
      }
      
      public function get level() : PlayerTeamLevel
      {
         return player.levelData.level;
      }
   }
}
