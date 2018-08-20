package haxe.crypto
{
   import haxe.io.Bytes;
   
   public class Base64
   {
      
      public static var CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      
      public static var BYTES:Bytes = Bytes.ofString(Base64.CHARS);
       
      
      public function Base64()
      {
      }
      
      public static function encode(param1:Bytes, param2:Boolean = true) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = new BaseCode(Base64.BYTES).encodeBytes(param1).toString();
         if(param2)
         {
            _loc4_ = param1.length % 3;
            switch(_loc4_)
            {
               default:
                  break;
               case 1:
                  _loc3_ = _loc3_ + "==";
                  break;
               case 2:
                  _loc3_ = _loc3_ + "=";
            }
         }
         return _loc3_;
      }
      
      public static function decode(param1:String, param2:Boolean = true) : Bytes
      {
         if(param2)
         {
            while(param1.charCodeAt(param1.length - 1) == 61)
            {
               param1 = param1.substr(0,-1);
            }
         }
         return new BaseCode(Base64.BYTES).decodeBytes(Bytes.ofString(param1));
      }
   }
}
