package game.mechanics.clan_war.model
{
   import flash.utils.Dictionary;
   import game.model.user.clan.ClanBasicInfoValueObject;
   
   public class ClanWarRaitingData
   {
       
      
      public var playerClanCurrentPosition:int;
      
      public var playerClanPosition:int;
      
      public var playerClanPoints:int;
      
      public var playerClanLeague:int;
      
      public var promoCount:int;
      
      public var topList:Vector.<ClanWarRaitingClanData>;
      
      public var clansInfo:Dictionary;
      
      public function ClanWarRaitingData()
      {
         super();
      }
      
      public function deserialize(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         playerClanCurrentPosition = param1.clanPlace;
         promoCount = param1.promoCount;
         var _loc5_:Object = param1.clanData;
         if(_loc5_)
         {
            playerClanPoints = _loc5_.points;
            playerClanPosition = _loc5_.position;
            playerClanLeague = _loc5_.league;
         }
         clansInfo = new Dictionary();
         var _loc3_:Array = param1.clans;
         if(_loc3_)
         {
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length)
            {
               _loc4_ = new ClanBasicInfoValueObject(_loc3_[_loc7_]);
               clansInfo[_loc4_.id] = _loc4_;
               _loc7_++;
            }
         }
         topList = new Vector.<ClanWarRaitingClanData>();
         var _loc2_:Array = param1.top;
         if(_loc2_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc8_ = new ClanWarRaitingClanData(_loc2_[_loc6_]);
               _loc8_.promoCount = promoCount;
               _loc8_.clanInfo = clansInfo[_loc8_.clanId];
               topList.push(_loc8_);
               _loc6_++;
            }
         }
      }
      
      private function sortClans(param1:ClanWarRaitingClanData, param2:ClanWarRaitingClanData) : int
      {
         return param2.points - param1.points;
      }
   }
}
