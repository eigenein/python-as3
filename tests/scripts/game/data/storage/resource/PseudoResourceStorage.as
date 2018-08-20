package game.data.storage.resource
{
   import game.data.storage.DescriptionStorage;
   
   public class PseudoResourceStorage extends DescriptionStorage
   {
       
      
      public var STARMONEY:PseudoResourceDescription;
      
      public var COIN:PseudoResourceDescription;
      
      public var XP:PseudoResourceDescription;
      
      public var STAMINA:PseudoResourceDescription;
      
      public var VIP:PseudoResourceDescription;
      
      public var CLAN_ACTIVITY:PseudoResourceDescription;
      
      public var DUNGEON_ACTIVITY:PseudoResourceDescription;
      
      public var CLAN_GIFT:PseudoResourceDescription;
      
      public var QUIZ_POINT:PseudoResourceDescription;
      
      public var BOSS_CHEST_PSEUDO:PseudoResourceDescription;
      
      public var TITAN_TOURNAMENT_POINT:PseudoResourceDescription;
      
      public function PseudoResourceStorage()
      {
         super();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:PseudoResourceDescription = new PseudoResourceDescription(param1);
         if(this.hasOwnProperty(_loc2_.constName))
         {
            this[_loc2_.constName] = _loc2_;
         }
         _items[_loc2_.id] = _loc2_;
      }
   }
}
