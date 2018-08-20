package game.mechanics.clan_war.model
{
   import game.model.user.clan.ClanBasicInfoValueObject;
   
   public class ClanWarRaitingClanData
   {
       
      
      public var clanId:int;
      
      public var position:int;
      
      public var leagueId:int;
      
      public var points:int;
      
      public var promoCount:uint;
      
      public var clanInfo:ClanBasicInfoValueObject;
      
      public function ClanWarRaitingClanData(param1:Object)
      {
         super();
         this.clanId = param1.clanId;
         this.position = param1.position;
         this.leagueId = param1.league;
         this.points = param1.points;
      }
   }
}
