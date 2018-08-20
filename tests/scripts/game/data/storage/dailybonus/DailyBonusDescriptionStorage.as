package game.data.storage.dailybonus
{
   public class DailyBonusDescriptionStorage
   {
       
      
      private var monthIndex:Vector.<DailyBonusDescription>;
      
      public function DailyBonusDescriptionStorage()
      {
         super();
         monthIndex = new Vector.<DailyBonusDescription>();
      }
      
      public function init(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            parseItem(_loc2_);
         }
         monthIndex.sort(__sort);
      }
      
      protected function parseItem(param1:Object) : void
      {
         var _loc2_:DailyBonusDescription = new DailyBonusDescription(param1);
         monthIndex.push(_loc2_);
      }
      
      public function getVector() : Vector.<DailyBonusDescription>
      {
         return monthIndex.slice();
      }
      
      public function getByDay(param1:int) : DailyBonusDescription
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<DailyBonusDescription> = monthIndex;
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_[_loc4_].day == param1)
            {
               return _loc3_[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      private function __sort(param1:DailyBonusDescription, param2:DailyBonusDescription) : int
      {
         return param1.day - param2.day;
      }
   }
}
