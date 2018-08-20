package starling.textures
{
   import flash.utils.ByteArray;
   
   public class AtfData
   {
       
      
      private var mFormat:String;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mNumTextures:int;
      
      private var mData:ByteArray;
      
      public function AtfData(param1:ByteArray)
      {
         var _loc3_:* = false;
         var _loc2_:* = 0;
         super();
         if(!isAtfData(param1))
         {
            throw new ArgumentError("Invalid ATF data");
         }
         if(param1[6] == 255)
         {
            param1.position = 12;
         }
         else
         {
            param1.position = 6;
         }
         switch(int(param1.readUnsignedByte()))
         {
            case 0:
            case 1:
               mFormat = "bgra";
               break;
            case 2:
            case 3:
               mFormat = "compressed";
               break;
            case 4:
            case 5:
               mFormat = "compressedAlpha";
         }
         mWidth = Math.pow(2,param1.readUnsignedByte());
         mHeight = Math.pow(2,param1.readUnsignedByte());
         mNumTextures = param1.readUnsignedByte();
         mData = param1;
         if(param1[5] != 0 && param1[6] == 255)
         {
            _loc3_ = (param1[5] & 1) == 1;
            _loc2_ = param1[5] >> 1 & 127;
            mNumTextures = !!_loc3_?1:_loc2_;
         }
      }
      
      public static function isAtfData(param1:ByteArray) : Boolean
      {
         var _loc2_:* = null;
         if(param1.length < 3)
         {
            return false;
         }
         _loc2_ = String.fromCharCode(param1[0],param1[1],param1[2]);
         return _loc2_ == "ATF";
      }
      
      public function get format() : String
      {
         return mFormat;
      }
      
      public function get width() : int
      {
         return mWidth;
      }
      
      public function get height() : int
      {
         return mHeight;
      }
      
      public function get numTextures() : int
      {
         return mNumTextures;
      }
      
      public function get data() : ByteArray
      {
         return mData;
      }
   }
}
