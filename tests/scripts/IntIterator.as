package
{
   import flash.Boot;
   
   public class IntIterator
   {
       
      
      public var min:int;
      
      public var max:int;
      
      public function IntIterator(param1:int = 0, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         min = param1;
         max = param2;
      }
      
      public function next() : int
      {
         var _loc1_:int = min;
         min = min + 1;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         return min < max;
      }
   }
}
