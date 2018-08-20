package game.mechanics.clan_war.storage
{
   import com.progrestar.common.lang.Translate;
   
   public class ClanWarLeagueDescription
   {
       
      
      public var id:int;
      
      public var divisionSize:int;
      
      public var frameId:int;
      
      public var promoCount:int;
      
      public var bestCount:int;
      
      public var maxChampions:int;
      
      public var maxAttackAttempts:int;
      
      public var divisions:Vector.<ClanWarLeagueDivisionDescription>;
      
      public function ClanWarLeagueDescription(param1:Object)
      {
         divisions = new Vector.<ClanWarLeagueDivisionDescription>();
         super();
         id = param1.id;
         divisionSize = param1.divisionSize;
         frameId = param1.frameId;
         promoCount = param1.promoCount;
         maxChampions = param1.maxChampions;
         maxAttackAttempts = param1.maxAttackAttempts;
         var _loc4_:int = 0;
         var _loc3_:* = param1.divisions;
         for(var _loc2_ in param1.divisions)
         {
            divisions.push(new ClanWarLeagueDivisionDescription(parseInt(_loc2_),param1.divisions[_loc2_]));
         }
      }
      
      public function get name() : String
      {
         return Translate.translate("LIB_CLANWAR_LEAGUE_NAME_" + id);
      }
   }
}
