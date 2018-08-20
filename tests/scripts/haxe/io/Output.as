package haxe.io
{
   import flash.utils.ByteArray;
   
   public class Output
   {
       
      
      public var bigEndian:Boolean;
      
      public function Output()
      {
      }
      
      public function writeUInt24(param1:int) : void
      {
         if(param1 < 0 || param1 >= 16777216)
         {
            throw Error.Overflow;
         }
         if(bigEndian)
         {
            writeByte(param1 >> 16);
            writeByte(param1 >> 8 & 255);
            writeByte(param1 & 255);
         }
         else
         {
            writeByte(param1 & 255);
            writeByte(param1 >> 8 & 255);
            writeByte(param1 >> 16);
         }
      }
      
      public function writeBytes(param1:Bytes, param2:int, param3:int) : int
      {
         var _loc4_:int = param3;
         var _loc5_:ByteArray = param1.b;
         if(param2 < 0 || param3 < 0 || param2 + param3 > param1.length)
         {
            throw Error.OutsideBounds;
         }
         while(_loc4_ > 0)
         {
            writeByte(int(_loc5_[param2]));
            param2++;
            _loc4_--;
         }
         return param3;
      }
      
      public function writeByte(param1:int) : void
      {
         throw "Not implemented";
      }
      
      public function write(param1:Bytes) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = int(param1.length);
         var _loc3_:* = 0;
         while(_loc2_ > 0)
         {
            _loc4_ = writeBytes(param1,_loc3_,_loc2_);
            if(_loc4_ == 0)
            {
               throw Error.Blocked;
            }
            _loc3_ = _loc3_ + _loc4_;
            _loc2_ = _loc2_ - _loc4_;
         }
      }
   }
}
