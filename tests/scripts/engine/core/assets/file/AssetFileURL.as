package engine.core.assets.file
{
   public class AssetFileURL
   {
      
      public static const SWF:String = "swf";
      
      public static const PNG:String = "png";
      
      public static const JPG:String = "jpg";
      
      public static const RSX:String = "rsx";
       
      
      private var _fileName:String;
      
      private var _relativeURL:String;
      
      private var _cacheBreaker:String;
      
      private var _size:int;
      
      private var path:AssetPath;
      
      public var mandatory:Boolean;
      
      public var mobile_priority:int;
      
      public function AssetFileURL(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         var _loc5_:* = null;
         super();
         _fileName = param1;
         _size = param4;
         if(param2.indexOf("?") == -1)
         {
            _relativeURL = param2;
            _cacheBreaker = "";
         }
         else
         {
            _loc5_ = param2.split("?");
            _relativeURL = _loc5_[0];
            _cacheBreaker = "?" + _loc5_[1];
         }
         path = !!param3?param3:AssetPath.EMPTY;
      }
      
      public static function getExtension(param1:String) : String
      {
         return param1.slice(param1.lastIndexOf(".") + 1);
      }
      
      public function get url() : String
      {
         return path.url + _relativeURL + _cacheBreaker;
      }
      
      public function get size() : int
      {
         return _size;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
      
      public function get relativeURL() : String
      {
         return _relativeURL;
      }
      
      public function doNotCheckFileSizeAnyMore() : void
      {
         _size = 0;
      }
   }
}
