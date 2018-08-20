package game.mechanics.clan_war.mediator.log
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.popup.log.ClanWarLogSeasonEntry;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   
   public class ClanWarLogSeasonEndData
   {
       
      
      private var _lastSeasonResult:ClanWarLogSeasonEntry;
      
      private var _hasDecider:Boolean;
      
      private var _promotionDecider:Boolean;
      
      public function ClanWarLogSeasonEndData(param1:ClanWarLogSeasonEntry, param2:Boolean, param3:Boolean)
      {
         super();
         this._lastSeasonResult = param1;
         this._hasDecider = param2;
         this._promotionDecider = param3;
      }
      
      public function get seasonPointsSum() : int
      {
         return _lastSeasonResult.points;
      }
      
      public function get league() : ClanWarLeagueDescription
      {
         return DataStorage.clanWar.getLeagueById(_lastSeasonResult.league);
      }
      
      public function get position() : int
      {
         return _lastSeasonResult.position;
      }
      
      public function get hasDecider() : Boolean
      {
         return _hasDecider;
      }
      
      public function get promotionDecider() : Boolean
      {
         return _promotionDecider;
      }
   }
}
