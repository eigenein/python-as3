package by.blooddy.crypto
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class CRC32
   {
       
      
      public function CRC32()
      {
      }
      
      public static function hash(param1:ByteArray) : uint
      {
         var _loc3_:* = null as ByteArray;
         var _loc4_:* = null as ByteArray;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc2_:uint = param1.length;
         if(_loc2_ > 0)
         {
            _loc2_ = _loc2_ + 1024;
            _loc3_ = ApplicationDomain.currentDomain.domainMemory;
            _loc4_ = CRC32Table.getTable();
            _loc4_.position = 1024;
            _loc4_.writeBytes(param1);
            if(_loc4_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
               _loc4_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = _loc4_;
            _loc5_ = -1;
            _loc6_ = 1024;
            do
            {
               _loc5_ = li32(((_loc5_ ^ li8(_loc6_)) & 255) << 2) ^ _loc5_ >>> 8;
               _loc6_++;
            }
            while(_loc6_ < _loc2_);
            
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            return _loc5_ ^ -1;
         }
         return 0;
      }
   }
}
