package engine.core.assets.file
{
   public class AssetPath
   {
      
      private static var _empty:AssetPath;
       
      
      public var url:String;
      
      public function AssetPath(param1:String)
      {
         super();
         this.url = param1;
      }
      
      public static function get EMPTY() : AssetPath
      {
         if(!_empty)
         {
            _empty = new AssetPath("");
         }
         return _empty;
      }
   }
}
