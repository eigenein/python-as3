package engine.loader.thread
{
   import com.probertson.utils.GZIPBytesEncoder;
   import engine.core.assets.file.RawDataFile;
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.utils.thread.AssetLoaderThread;
   import flash.utils.ByteArray;
   
   public class LibLoaderThread extends AssetLoaderThread
   {
       
      
      private const _decoder:GZIPBytesEncoder = new GZIPBytesEncoder();
      
      private var _data:Object;
      
      public function LibLoaderThread(param1:RawDataFile)
      {
         super(param1);
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      override protected function assetLoaded(param1:AssetLoaderItem) : void
      {
         var _loc2_:RawDataFile = this.file as RawDataFile;
         if(_loc2_.completed)
         {
            _data = parseJSONBytesOrNull(_loc2_.bytes);
         }
         super.assetLoaded(param1);
      }
      
      private function parseJSONBytesOrNull(param1:ByteArray) : Object
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         try
         {
            _loc2_ = !!isGZIP(param1)?_decoder.uncompressToByteArray(param1):param1;
            _loc3_ = _loc2_.toString();
            _loc4_ = JSON.parse(_loc3_);
            var _loc6_:* = _loc4_;
            return _loc6_;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      private function isGZIP(param1:ByteArray) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.length == 0)
         {
            return false;
         }
         var _loc2_:String = param1.endian;
         var _loc4_:uint = param1.position;
         param1.position = 0;
         param1.endian = "littleEndian";
         var _loc3_:uint = param1.readUnsignedByte();
         param1.endian = _loc2_;
         param1.position = _loc4_;
         return _loc3_ == 31;
      }
   }
}
