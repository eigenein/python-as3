package game.data.storage.rule
{
   import game.data.cost.CostData;
   
   public class BossRule
   {
       
      
      private var _groupDaysInTimetable:Boolean;
      
      private var _chestRepeatFromId:int;
      
      private var _chestPackAmount:int;
      
      private var _chestPackCost:CostData;
      
      public function BossRule(param1:Object)
      {
         super();
         this._groupDaysInTimetable = param1.groupDaysInTimetable;
         this._chestRepeatFromId = param1.chestRepeatFromId;
         var _loc3_:Object = param1.chestPack;
         if(_loc3_)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for(this._chestPackAmount in _loc3_)
            {
               this._chestPackCost = new CostData(_loc3_[_loc2_].cost);
            }
         }
      }
      
      public function get groupDaysInTimetable() : Boolean
      {
         return _groupDaysInTimetable;
      }
      
      public function get chestRepeatFromId() : int
      {
         return _chestRepeatFromId;
      }
      
      public function get chestPackAmount() : int
      {
         return _chestPackAmount;
      }
      
      public function get chestPackCost() : CostData
      {
         return _chestPackCost;
      }
   }
}
