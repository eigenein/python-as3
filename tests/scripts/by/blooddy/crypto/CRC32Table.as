package by.blooddy.crypto
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.getQualifiedClassName;
   
   [ExcludeClass]
   public final class CRC32Table
   {
      
      private static var _table:ByteArray;
       
      
      public function CRC32Table()
      {
         super();
         Error.throwError(ArgumentError,2012,getQualifiedClassName(this));
      }
      
      public static function getTable() : ByteArray
      {
         if(!_table)
         {
            _table = createTable();
         }
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeBytes(_table);
         return _loc1_;
      }
      
      private static function createTable() : ByteArray
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.endian = Endian.LITTLE_ENDIAN;
         _loc4_ = 0;
         while(_loc4_ < 256)
         {
            _loc2_ = _loc4_;
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               if(_loc2_ & 1 == 1)
               {
                  _loc2_ = 3988292384 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ = _loc2_ >>> 1;
               }
               _loc3_++;
            }
            _loc1_.writeUnsignedInt(_loc2_);
            _loc4_++;
         }
         return _loc1_;
      }
   }
}
