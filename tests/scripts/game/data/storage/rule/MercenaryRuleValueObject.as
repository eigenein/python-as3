package game.data.storage.rule
{
   public class MercenaryRuleValueObject
   {
       
      
      private var _log:Number;
      
      private var _k:Number;
      
      private var _pow:Number;
      
      private var _minTime:Number;
      
      private var _maxMercenariesPerVipLevel:Vector.<int>;
      
      public function MercenaryRuleValueObject(param1:*)
      {
         _maxMercenariesPerVipLevel = new Vector.<int>();
         super();
         _log = param1.log;
         _k = param1.k;
         _pow = param1.pow;
         _minTime = param1.minTime;
         if(param1.maxMercenaries)
         {
            var _loc4_:int = 0;
            var _loc3_:* = param1.maxMercenaries;
            for(var _loc2_ in param1.maxMercenaries)
            {
               if(_loc2_ >= _maxMercenariesPerVipLevel.length)
               {
                  _maxMercenariesPerVipLevel.length = _loc2_ + 1;
               }
               _maxMercenariesPerVipLevel[_loc2_] = param1.maxMercenaries[_loc2_];
            }
         }
      }
      
      public function getHireProfit(param1:Number) : int
      {
         return (Math.log(param1) * _log + param1 * _pow) * _k;
      }
      
      public function getGuardianProfit(param1:Number, param2:Number) : int
      {
         return (Math.log(param1) * _log + param1 * _pow) * param2;
      }
      
      public function getMercenariesCountPerVipLevel(param1:uint) : uint
      {
         if(param1 > _maxMercenariesPerVipLevel.length)
         {
            return _maxMercenariesPerVipLevel[_maxMercenariesPerVipLevel.length - 1];
         }
         return _maxMercenariesPerVipLevel[param1];
      }
   }
}
