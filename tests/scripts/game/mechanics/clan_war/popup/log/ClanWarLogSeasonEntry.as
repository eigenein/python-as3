package game.mechanics.clan_war.popup.log
{
   public class ClanWarLogSeasonEntry
   {
       
      
      private var _league:int;
      
      private var _points:int;
      
      private var _position:int;
      
      public function ClanWarLogSeasonEntry(param1:Object)
      {
         super();
         _league = param1.league;
         _points = param1.points;
         _position = param1.position;
      }
      
      public function get league() : int
      {
         return _league;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function get position() : int
      {
         return _position;
      }
   }
}
