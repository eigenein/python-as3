package game.data.storage.rule
{
   public class VipRuleValueObject
   {
       
      
      private var _missionRaid:int;
      
      private var _missionMultiRaid:int;
      
      private var _towerReset:int;
      
      private var _tower3rdChest:int;
      
      private var _enchant:int;
      
      private var _allBundlesCarousel:int;
      
      private var _expeditionVip:int;
      
      public function VipRuleValueObject(param1:*)
      {
         super();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            if(this.hasOwnProperty(_loc2_))
            {
               this["_" + _loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function get missionRaid() : int
      {
         return _missionRaid;
      }
      
      public function get missionMultiRaid() : int
      {
         return _missionMultiRaid;
      }
      
      public function get towerReset() : int
      {
         return _towerReset;
      }
      
      public function get enchant() : int
      {
         return _enchant;
      }
      
      public function get tower3rdChest() : int
      {
         return _tower3rdChest;
      }
      
      public function get allBundlesCarousel() : int
      {
         return _allBundlesCarousel;
      }
      
      public function get expeditionVip() : int
      {
         return _expeditionVip;
      }
   }
}
