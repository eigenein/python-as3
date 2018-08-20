package battle.skills
{
   import flash.Boot;
   
   public class ValueOverTime
   {
       
      
      public var totalValue:int;
      
      public var ticksTotal:int;
      
      public var ticks:int;
      
      public function ValueOverTime(param1:int = 0, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         var _loc3_:int = param2;
         ticks = _loc3_;
         ticksTotal = _loc3_;
         totalValue = param1;
      }
      
      public function next() : int
      {
         ticks = ticks - 1;
         return int((totalValue + ticks) / ticksTotal);
      }
      
      public function hasNext() : Boolean
      {
         return ticks > 0;
      }
   }
}
