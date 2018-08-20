package battle.log
{
   import flash.Boot;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import format.tools.Deflate;
   import haxe.IMap;
   import haxe.crypto.Base64;
   import haxe.ds.StringMap;
   import haxe.ds._StringMap.StringMapKeysIterator;
   import haxe.io.Bytes;
   import haxe.io.BytesOutput;
   
   public class BattleLogWriter extends BytesOutput
   {
       
      
      public var time:Number;
      
      public var stringsCount:int;
      
      public var strings:IMap;
      
      public var currentBytePosition:int;
      
      public function BattleLogWriter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         time = 0;
         stringsCount = 0;
         strings = new StringMap();
         super();
      }
      
      public function writeEventId(param1:Number, param2:int) : void
      {
         if(param1 != time)
         {
            writeByte(BattleLogEvent.TIME_BLOCK_ID);
            writeInt16(int(Math.round(param1 * 100)));
         }
         writeByte(param2);
         currentBytePosition = int(b.length);
      }
      
      public function writeEncodedString(param1:String) : void
      {
         var _loc2_:* = null as StringMap;
         var _loc3_:int = 0;
         _loc2_ = strings;
         if(param1 in StringMap.reserved?Boolean(_loc2_.existsReserved(param1)):param1 in _loc2_.h)
         {
            _loc2_ = strings;
            writeInt16(param1 in StringMap.reserved?_loc2_.getReserved(param1):_loc2_.h[param1]);
         }
         else
         {
            _loc2_ = strings;
            _loc3_ = stringsCount;
            if(param1 in StringMap.reserved)
            {
               _loc2_.setReserved(param1,_loc3_);
            }
            else
            {
               _loc2_.h[param1] = _loc3_;
            }
            writeInt16(stringsCount);
            stringsCount = stringsCount + 1;
         }
      }
      
      public function getEncodedString() : String
      {
         var _loc3_:* = null as StringMap;
         var _loc5_:* = null as String;
         var _loc1_:Bytes = getBytes();
         b = new ByteArray();
         b.endian = Endian.LITTLE_ENDIAN;
         writeBytes(_loc1_,0,_loc1_.length);
         var _loc2_:BytesOutput = new BytesOutput();
         _loc2_.writeInt16(stringsCount);
         _loc3_ = strings;
         var _loc4_:* = new StringMapKeysIterator(_loc3_.h,_loc3_.rh);
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc3_ = strings;
            _loc2_.writeInt16(_loc5_ in StringMap.reserved?_loc3_.getReserved(_loc5_):_loc3_.h[_loc5_]);
            _loc2_.writeByte(_loc5_.length);
            _loc2_.writeString(_loc5_);
         }
         var _loc6_:int = b.length;
         _loc2_.writeBytes(_loc1_,0,_loc6_);
         var _loc7_:Bytes = Deflate.run(_loc2_.getBytes());
         return Base64.encode(_loc7_);
      }
   }
}
