package haxe.io
{
   import flash.Boot;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class Bytes
   {
       
      
      public var length:int;
      
      public var b:ByteArray;
      
      public function Bytes(param1:int = 0, param2:ByteArray = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         length = param1;
         b = param2;
         param2.endian = Endian.LITTLE_ENDIAN;
      }
      
      public static function alloc(param1:int) : Bytes
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.length = param1;
         return new Bytes(param1,_loc2_);
      }
      
      public static function ofString(param1:String) : Bytes
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return new Bytes(_loc2_.length,_loc2_);
      }
      
      public static function ofData(param1:ByteArray) : Bytes
      {
         return new Bytes(param1.length,param1);
      }
      
      public function toString() : String
      {
         b.position = 0;
         return b.readUTFBytes(length);
      }
      
      public function blit(param1:int, param2:Bytes, param3:int, param4:int) : void
      {
         if(param1 < 0 || param3 < 0 || param4 < 0 || param1 + param4 > length || param3 + param4 > param2.length)
         {
            throw Error.OutsideBounds;
         }
         b.position = param1;
         if(param4 > 0)
         {
            b.writeBytes(param2.b,param3,param4);
         }
      }
   }
}
