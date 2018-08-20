package haxe.zip
{
   import flash.utils.ByteArray;
   import haxe.io.Bytes;
   
   public class Uncompress
   {
       
      
      public function Uncompress()
      {
      }
      
      public static function run(param1:Bytes, param2:Object = undefined) : Bytes
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeBytes(param1.b,0,param1.length);
         _loc3_.uncompress();
         return Bytes.ofData(_loc3_);
      }
   }
}
