package game.mechanics.clan_war.popup.leagues
{
   public class ClanWarLeagueInfoValueObject
   {
       
      
      public var leagueId:int;
      
      public var points:int;
      
      public var position:int;
      
      public var prevLeague:int;
      
      public var prevPoints:int;
      
      public var prevPosition:int;
      
      public var clanPlace:int;
      
      public function ClanWarLeagueInfoValueObject()
      {
         super();
      }
      
      public function deserialize(param1:Object) : void
      {
         if(param1 && param1.clanData)
         {
            this.leagueId = param1.clanData.leagueId;
            this.points = param1.clanData.points;
            this.position = param1.clanData.position;
            this.prevLeague = param1.clanData.prevLeague;
            this.prevPoints = param1.clanData.prevPoints;
            this.prevPosition = param1.clanData.prevPosition;
            this.clanPlace = param1.clanPlace;
         }
      }
   }
}
