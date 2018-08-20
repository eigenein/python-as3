package battle.utils
{
   import flash.utils.getTimer;
   
   public class Util
   {
       
      
      public function Util()
      {
      }
      
      public static function timer() : Number
      {
         return getTimer();
      }
      
      public static function hasMethod(param1:*, param2:String) : Boolean
      {
         return Boolean(Reflect.hasField(param1,param2));
      }
      
      public static function _int(param1:Number) : int
      {
         return int(param1);
      }
      
      public static function skillInt(param1:Number) : int
      {
         return int(param1);
      }
   }
}
