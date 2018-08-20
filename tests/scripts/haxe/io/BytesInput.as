package haxe.io
{
   import flash.Boot;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class BytesInput extends Input
   {
       
      
      public var b:ByteArray;
      
      public function BytesInput(param1:Bytes = undefined, param2:Object = undefined, param3:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = 0;
         }
         if(param3 == null)
         {
            param3 = param1.length - param2;
         }
         if(param2 < 0 || param3 < 0 || int(param2 + param3) > param1.length)
         {
            throw Error.OutsideBounds;
         }
         var _loc4_:ByteArray = param1.b;
         _loc4_.position = param2;
         if(param3 != _loc4_.bytesAvailable)
         {
            b = new ByteArray();
            _loc4_.readBytes(b,0,param3);
         }
         else
         {
            b = _loc4_;
         }
         b.endian = Endian.LITTLE_ENDIAN;
      }
      
      public function set_position(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > int(b.length))
         {
            param1 = b.length;
         }
         var _loc2_:uint = param1;
         b.position = _loc2_;
         return _loc2_;
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
      
      public function readUInt16() : int
      {
         try
         {
            return uint(b.readUnsignedShort());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
      
      public function readString(param1:int) : String
      {
         try
         {
            return b.readUTFBytes(param1);
         }
         catch(_loc2_:*)
         {
            throw new Eof();
         }
      }
      
      public function readInt32() : int
      {
         try
         {
            return int(b.readInt());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
      
      public function readInt16() : int
      {
         try
         {
            return int(b.readShort());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
      
      public function readFloat() : Number
      {
         try
         {
            return Number(b.readFloat());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
      
      public function readDouble() : Number
      {
         try
         {
            return Number(b.readDouble());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
      
      override public function readBytes(param1:Bytes, param2:int, param3:int) : int
      {
         if(param2 < 0 || param3 < 0 || param2 + param3 > param1.length)
         {
            throw Error.OutsideBounds;
         }
         var _loc4_:int = b.bytesAvailable;
         if(param3 > _loc4_ && _loc4_ > 0)
         {
            param3 = _loc4_;
         }
         try
         {
            b.readBytes(param1.b,param2,param3);
         }
         catch(_loc5_:*)
         {
            throw new Eof();
         }
         return param3;
      }
      
      override public function readByte() : int
      {
         try
         {
            return uint(b.readUnsignedByte());
         }
         catch(_loc1_:*)
         {
            throw new Eof();
         }
      }
   }
}
