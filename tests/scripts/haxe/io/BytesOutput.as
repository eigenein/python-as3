package haxe.io
{
   import flash.Boot;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BytesOutput extends Output
   {
       
      
      public var b:ByteArray;
      
      public function BytesOutput()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         b = new ByteArray();
         b.endian = Endian.LITTLE_ENDIAN;
      }
      
      public function writeUInt16(param1:int) : void
      {
         if(param1 < 0 || param1 >= 65536)
         {
            throw Error.Overflow;
         }
         b.writeShort(param1);
      }
      
      public function writeString(param1:String) : void
      {
         b.writeUTFBytes(param1);
      }
      
      public function writeInt32(param1:int) : void
      {
         b.writeInt(param1);
      }
      
      public function writeInt16(param1:int) : void
      {
         if(param1 < -32768 || param1 >= 32768)
         {
            throw Error.Overflow;
         }
         b.writeShort(param1);
      }
      
      public function writeFloat(param1:Number) : void
      {
         b.writeFloat(param1);
      }
      
      public function writeDouble(param1:Number) : void
      {
         b.writeDouble(param1);
      }
      
      override public function writeBytes(param1:Bytes, param2:int, param3:int) : int
      {
         if(param2 < 0 || param3 < 0 || param2 + param3 > param1.length)
         {
            throw Error.OutsideBounds;
         }
         b.writeBytes(param1.b,param2,param3);
         return param3;
      }
      
      override public function writeByte(param1:int) : void
      {
         b.writeByte(param1);
      }
      
      public function set_bigEndian(param1:Boolean) : Boolean
      {
         bigEndian = param1;
         if(param1)
         {
            b.endian = Endian.BIG_ENDIAN;
         }
         else
         {
            b.endian = Endian.LITTLE_ENDIAN;
         }
         return param1;
      }
      
      public function getBytes() : Bytes
      {
         var _loc1_:ByteArray = b;
         b = null;
         return new Bytes(_loc1_.length,_loc1_);
      }
   }
}
