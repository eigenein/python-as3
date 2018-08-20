package haxe.io
{
   import flash.utils.ByteArray;
   
   public class Input
   {
       
      
      public var bigEndian:Boolean;
      
      public function Input()
      {
      }
      
      public function readUInt24() : int
      {
         var _loc1_:int = readByte();
         var _loc2_:int = readByte();
         var _loc3_:int = readByte();
         if(bigEndian)
         {
            return _loc3_ | _loc2_ << 8 | _loc1_ << 16;
         }
         return _loc1_ | _loc2_ << 8 | _loc3_ << 16;
      }
      
      public function readBytes(param1:Bytes, param2:int, param3:int) : int
      {
         var _loc4_:int = param3;
         var _loc5_:ByteArray = param1.b;
         if(param2 < 0 || param3 < 0 || param2 + param3 > param1.length)
         {
            throw Error.OutsideBounds;
         }
         while(_loc4_ > 0)
         {
            _loc5_[param2] = int(readByte());
            param2++;
            _loc4_--;
         }
         return param3;
      }
      
      public function readByte() : int
      {
         throw "Not implemented";
      }
      
      public function read(param1:int) : Bytes
      {
         var _loc4_:int = 0;
         var _loc2_:Bytes = Bytes.alloc(param1);
         var _loc3_:* = 0;
         while(param1 > 0)
         {
            _loc4_ = readBytes(_loc2_,_loc3_,param1);
            if(_loc4_ == 0)
            {
               throw Error.Blocked;
            }
            _loc3_ = _loc3_ + _loc4_;
            param1 = param1 - _loc4_;
         }
         return _loc2_;
      }
   }
}
