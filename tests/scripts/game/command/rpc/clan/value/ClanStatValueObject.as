package game.command.rpc.clan.value
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   
   public class ClanStatValueObject
   {
       
      
      private const _activitySum:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _todayActivity:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _todayItemsActivity:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _dungeonActivitySum:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _todayDungeonActivity:IntPropertyWriteable = new IntPropertyWriteable();
      
      private const _activityForRuneAvailable:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      public const activitySum:IntProperty = _activitySum;
      
      public const todayActivity:IntProperty = _todayActivity;
      
      public const todayItemsActivity:IntProperty = _todayItemsActivity;
      
      public const dungeonActivitySum:IntProperty = _dungeonActivitySum;
      
      public const todayDungeonActivity:IntProperty = _todayDungeonActivity;
      
      public const activityForRuneAvailable:BooleanProperty = _activityForRuneAvailable;
      
      private var _todayRaid:Dictionary;
      
      private var _mercenaries:Vector.<ClanMercenaryValueObject>;
      
      public function ClanStatValueObject(param1:Object)
      {
         super();
         _todayRaid = new Dictionary();
         if(param1)
         {
            update(param1);
         }
      }
      
      public function get todayRaid() : Dictionary
      {
         return _todayRaid;
      }
      
      public function get mercenaries() : Vector.<ClanMercenaryValueObject>
      {
         return _mercenaries;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _activitySum.value = param1.activitySum;
         _todayActivity.value = param1.todayActivity;
         _todayItemsActivity.value = param1.todayItemsActivity;
         _dungeonActivitySum.value = param1.dungeonActivitySum;
         _todayDungeonActivity.value = param1.todayDungeonActivity;
         _activityForRuneAvailable.value = param1.activityForRuneAvailable;
         _mercenaries = new Vector.<ClanMercenaryValueObject>();
         if(param1.mercenaries)
         {
            _loc2_ = param1.mercenaries.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _mercenaries[_loc3_] = new ClanMercenaryValueObject(param1.mercenaries[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function addPersonalDungeonActivity(param1:int) : void
      {
         _todayDungeonActivity.value = _todayDungeonActivity.value + param1;
      }
      
      public function spendItemsForActivity(param1:int) : void
      {
         _activitySum.value = _activitySum.value + param1;
         _todayActivity.value = _todayActivity.value + param1;
         _todayItemsActivity.value = _todayItemsActivity.value + param1;
      }
   }
}
