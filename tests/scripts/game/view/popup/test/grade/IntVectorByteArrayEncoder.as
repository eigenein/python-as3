package game.view.popup.test.grade
{
   import flash.utils.ByteArray;
   
   public class IntVectorByteArrayEncoder
   {
       
      
      public function IntVectorByteArrayEncoder()
      {
         super();
      }
      
      public static function encode(param1:Vector.<Vector.<int>>) : ByteArray
      {
         var _loc5_:int = 0;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:ByteArray = new ByteArray();
         var _loc7_:int = param1.length;
         _loc9_.writeByte(_loc7_);
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc3_ = param1[_loc5_];
            _loc4_ = _loc3_.length;
            _loc2_ = 1;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc8_ = _loc3_[_loc6_];
               if(_loc8_ > 255 && _loc2_ < 2)
               {
                  _loc2_ = 2;
               }
               if(_loc8_ > 65535 && _loc2_ < 4)
               {
                  _loc2_ = 4;
               }
               _loc6_++;
            }
            _loc9_.writeByte(_loc2_);
            _loc9_.writeByte(_loc4_);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc8_ = _loc3_[_loc6_];
               if(_loc2_ == 1)
               {
                  _loc9_.writeByte(_loc8_);
               }
               else if(_loc2_ == 2)
               {
                  _loc9_.writeShort(_loc8_);
               }
               else
               {
                  _loc9_.writeInt(_loc8_);
               }
               _loc6_++;
            }
            _loc5_++;
         }
         return _loc9_;
      }
      
      public static function decode(param1:Vector.<Vector.<int>>, param2:ByteArray) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = param1.length;
         var _loc9_:int = param2.readByte();
         _loc9_ = Math.min(_loc6_,_loc9_);
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc4_ = param1[_loc7_];
            _loc3_ = param2.readByte();
            _loc5_ = param2.readByte();
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               if(_loc3_ == 1)
               {
                  _loc4_[_loc8_] = param2.readByte();
               }
               else if(_loc3_ == 2)
               {
                  _loc4_[_loc8_] = param2.readShort();
               }
               else
               {
                  _loc4_[_loc8_] = param2.readInt();
               }
               _loc8_++;
            }
            _loc7_++;
         }
      }
   }
}
