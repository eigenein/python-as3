package haxe.zip
{
   import flash.utils.ByteArray;
   import haxe.io.Bytes;
   
   public class Compress
   {
       
      
      public function Compress()
      {
      }
      
      public static function run(param1:Bytes, param2:int) : Bytes
      {
         var _loc3_:* = null as Bytes;
         if(param1.length == 0)
         {
            _loc3_ = Bytes.alloc(8);
            _loc3_.b[0] = 120;
            _loc3_.b[1] = 218;
            _loc3_.b[2] = 3;
            _loc3_.b[7] = 1;
            return _loc3_;
         }
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeBytes(param1.b,0,param1.length);
         _loc4_.compress();
         return Bytes.ofData(_loc4_);
      }
   }
}
