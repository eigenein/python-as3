package game.model.user.hero
{
   import battle.BattleStats;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.level.ItemEnchantLevel;
   
   public class PlayerHeroEnchantment
   {
      
      public static const SLOTS_COUNT:int = 6;
       
      
      private var _color:HeroColorData;
      
      private var _battleStatData:BattleStats;
      
      private var slots:Vector.<int>;
      
      public function PlayerHeroEnchantment(param1:Object, param2:HeroColorData)
      {
         var _loc5_:int = 0;
         super();
         this._color = param2;
         slots = new Vector.<int>(6);
         var _loc4_:Array = param1 as Array;
         var _loc3_:int = slots.length;
         if(param1 != null)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               slots[_loc5_] = !!param1.hasOwnProperty(_loc5_)?param1[_loc5_]:-1;
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               slots[_loc5_] = -1;
               _loc5_++;
            }
         }
      }
      
      public function getBattleStats() : BattleStats
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = null;
         if(!_color)
         {
            return null;
         }
         if(!_color.battleStatData)
         {
            _battleStatData = new BattleStats();
         }
         else
         {
            _battleStatData = _color.battleStatData.clone();
         }
         var _loc3_:int = _color.itemList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(slots[_loc4_] >= 0)
            {
               _loc1_ = 1;
               _loc2_ = _color.itemList[_loc4_].color.getEnchantLevel(slots[_loc4_]);
               if(_loc2_)
               {
                  _loc1_ = _color.itemList[_loc4_].enchantMultiplier * _loc2_.level;
               }
               _loc5_ = _color.itemList[_loc4_].battleStatData;
               _battleStatData.addMultiply(_loc5_,_loc1_);
            }
            _loc4_++;
         }
         return _battleStatData;
      }
      
      function getSlotEnchant(param1:int) : int
      {
         if(slots[param1] != -1)
         {
            return slots[param1];
         }
         return 0;
      }
      
      function isSlotBusy(param1:int) : Boolean
      {
         return slots[param1] != -1;
      }
      
      public function get color() : HeroColorData
      {
         return _color;
      }
      
      function insertItem(param1:int) : void
      {
         slots[param1] = 0;
      }
      
      function promoteColor() : void
      {
         var _loc2_:int = 0;
         _color = _color.next;
         var _loc1_:int = slots.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            slots[_loc2_] = -1;
            _loc2_++;
         }
      }
      
      function promoteColorBoost(param1:HeroColorData) : void
      {
         var _loc3_:int = 0;
         _color = param1;
         var _loc2_:int = slots.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            slots[_loc3_] = -1;
            _loc3_++;
         }
      }
      
      function enchantSlot(param1:int, param2:int) : void
      {
         var _loc3_:* = param1;
         var _loc4_:* = slots[_loc3_] + param2;
         slots[_loc3_] = _loc4_;
      }
   }
}
