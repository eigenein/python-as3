package game.data.storage.hero
{
   import battle.BattleStats;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.gear.GearItemDescription;
   
   public class HeroColorData
   {
       
      
      private var _battleStatData:BattleStats;
      
      private var _itemList:Vector.<GearItemDescription>;
      
      private var _color:HeroColor;
      
      public var next:HeroColorData;
      
      public var prev:HeroColorData;
      
      public function HeroColorData(param1:Object, param2:HeroColor)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _itemList = new Vector.<GearItemDescription>(6);
         super();
         _color = param2;
         if(param1)
         {
            if(param1.battleStatData)
            {
               _battleStatData = BattleStats.fromRawData(param1.battleStatData);
            }
            _loc3_ = param1.items.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               itemList[_loc4_] = DataStorage.gear.getById(param1.items[_loc4_]) as GearItemDescription;
               _loc4_++;
            }
         }
      }
      
      public function get battleStatData() : BattleStats
      {
         return _battleStatData;
      }
      
      public function get itemList() : Vector.<GearItemDescription>
      {
         return _itemList;
      }
      
      public function get color() : HeroColor
      {
         return _color;
      }
      
      public function get skillTierAvailable() : int
      {
         var _loc1_:* = this;
         while(_loc1_._color.skillTierUnlock == 0)
         {
            _loc1_ = _loc1_.prev;
         }
         return _loc1_._color.skillTierUnlock;
      }
   }
}
