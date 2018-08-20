package engine.core.utils.thread
{
   import com.probertson.utils.GZIPBytesEncoder;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class GZIPLoaderThread extends URLLoaderThread
   {
       
      
      private var _data:Object;
      
      private const _decoder:GZIPBytesEncoder = new GZIPBytesEncoder();
      
      public function GZIPLoaderThread(param1:String = null, param2:URLRequest = null)
      {
         super(param1,param2);
         _urlLoader.dataFormat = "binary";
      }
      
      override protected function loader_onComplete(param1:Event) : void
      {
         _data = parseJSONBytesOrNull(_urlLoader.data);
         super.loader_onComplete(param1);
      }
      
      public function get data() : Object
      {
         return _data;
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
