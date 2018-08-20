package game.data.storage.mechanic
{
   import game.data.storage.DescriptionStorage;
   
   public class MechanicStorage extends DescriptionStorage
   {
      
      public static var MISSION:MechanicDescription;
      
      public static var ARENA:MechanicDescription;
      
      public static var GRAND:MechanicDescription;
      
      public static var CHEST:MechanicDescription;
      
      public static var SKILLS:MechanicDescription;
      
      public static var SOCIAL_GIFT:MechanicDescription;
      
      public static var CLAN:MechanicDescription;
      
      public static var ENCHANT:MechanicDescription;
      
      public static var TOWER:MechanicDescription;
      
      public static var RATING:MechanicDescription;
      
      public static var CHALLENGE:MechanicDescription;
      
      public static var BOSS:MechanicDescription;
      
      public static var CHAT:MechanicDescription;
      
      public static var CLAN_DUNGEON:MechanicDescription;
      
      public static var CLAN_CHEST:MechanicDescription;
      
      public static var TITAN_GIFT:MechanicDescription;
      
      public static var TITAN_ARENA:MechanicDescription;
      
      public static var TITAN_ARTIFACT:MechanicDescription;
      
      public static var TITAN_ARTIFACT_CHEST:MechanicDescription;
      
      public static var TITAN_VALLEY:MechanicDescription;
      
      public static var TITAN_SPIRITS:MechanicDescription;
      
      public static var TITAN_ARTIFACT_MERCHANT:MechanicDescription;
      
      public static var TITAN_ARENA_HALL_OF_FAME:MechanicDescription;
      
      public static var CLAN_PVP:MechanicDescription;
      
      public static var ARTIFACT:MechanicDescription;
      
      public static var ZEPPELIN:MechanicDescription;
      
      public static var ARTIFACT_CHEST:MechanicDescription;
      
      public static var ARTIFACT_MERCHANT:MechanicDescription;
      
      public static var EXPEDITIONS:MechanicDescription;
      
      public static var SUBSCRIPTION:MechanicDescription;
      
      public static var NY2018_GIFTS:MechanicDescription;
      
      public static var NY2018_TREE:MechanicDescription;
      
      public static var NY2018_WELCOME:MechanicDescription;
       
      
      public function MechanicStorage()
      {
         super();
      }
      
      override public function init(param1:Object) : void
      {
         super.init(param1.level);
      }
      
      public function getByType(param1:String) : MechanicDescription
      {
         return _items[param1];
      }
      
      public function getUnlockedByTeamLevel(param1:int) : Vector.<MechanicDescription>
      {
         var _loc2_:Vector.<MechanicDescription> = new Vector.<MechanicDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc3_ in _items)
         {
            if(_loc3_.teamLevel == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:MechanicDescription = new MechanicDescription(param1);
         _items[_loc2_.type] = _loc2_;
         try
         {
            MechanicStorage[_loc2_.type.toUpperCase()] = _loc2_;
            return;
         }
         catch(error:Error)
         {
            return;
         }
      }
   }
}
