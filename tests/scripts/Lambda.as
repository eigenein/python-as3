package
{
   public class Lambda
   {
       
      
      public function Lambda()
      {
      }
      
      public static function indexOf(param1:Object, param2:Object) : int
      {
         var _loc5_:* = null as Object;
         var _loc3_:int = 0;
         var _loc4_:* = param1.iterator();
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            if(param2 == _loc5_)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}
