package game.model.user.refillable
{
   import game.model.user.Player;
   
   public class PlayerRefillableVIPSource
   {
       
      
      private var player:Player;
      
      public function PlayerRefillableVIPSource(param1:Player)
      {
         super();
         this.player = param1;
      }
      
      public function get vip() : int
      {
         return player.vipLevel.level;
      }
   }
}
