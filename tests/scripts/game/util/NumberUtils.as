package game.util
{
   import com.progrestar.common.lang.Translate;
   
   public class NumberUtils
   {
      
      private static var digitsDelimeter:String = " ";
       
      
      public function NumberUtils()
      {
         super();
      }
      
      public static function numberToString(param1:Number) : String
      {
         var _loc2_:String = String(param1);
         var _loc4_:uint = _loc2_.length;
         var _loc3_:uint = param1 < 0?_loc4_ - 1:_loc4_;
         if(_loc3_ < 4)
         {
            return _loc2_;
         }
         if(!digitsDelimeter)
         {
            digitsDelimeter = Translate.translate("T_DIGITS_DELIMITER");
         }
         if(_loc3_ < 7)
         {
            return _loc2_.substr(0,_loc4_ - 3) + digitsDelimeter + _loc2_.substr(_loc4_ - 3);
         }
         if(_loc3_ < 10)
         {
            return _loc2_.substr(0,_loc4_ - 6) + digitsDelimeter + _loc2_.substr(_loc4_ - 6,3) + digitsDelimeter + _loc2_.substr(_loc4_ - 3,3);
         }
         if(_loc3_ < 13)
         {
            return _loc2_.substr(0,_loc4_ - 9) + digitsDelimeter + _loc2_.substr(_loc4_ - 9,3) + digitsDelimeter + _loc2_.substr(_loc4_ - 6,3) + digitsDelimeter + _loc2_.substr(_loc4_ - 3,3);
         }
         return _loc2_;
      }
   }
}
