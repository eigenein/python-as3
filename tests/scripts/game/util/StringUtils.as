package game.util
{
   public class StringUtils
   {
      
      private static const _TRIM_PATTERN:RegExp = /^\s*|\s*$/g;
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function trim(param1:String) : String
      {
         return param1.replace(_TRIM_PATTERN,"");
      }
      
      public static function sub(param1:String, param2:Object) : String
      {
         var _loc5_:int = 0;
         var _loc4_:* = param2;
         for(var _loc3_ in param2)
         {
            param1 = param1.replace("{" + _loc3_ + "}",param2[_loc3_]);
         }
         return param1;
      }
      
      public static function getFilenameFromPath(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1.indexOf("/"))
         {
            _loc2_ = param1.split("/");
            param1 = _loc2_[_loc2_.length - 1];
         }
         return param1;
      }
      
      public static function trimExtension(param1:String) : String
      {
         if(!param1 || !param1.length)
         {
            return param1;
         }
         if(param1.indexOf("."))
         {
            param1 = param1.split(".")[0];
         }
         return param1;
      }
      
      public static function isURL(param1:String) : Boolean
      {
         var _loc2_:Array = param1.match(/[http|s]+:\/\//g);
         return _loc2_ && _loc2_.length > 0;
      }
      
      public static function upperFirst(param1:String) : String
      {
         var _loc2_:String = param1.slice(0,1);
         return _loc2_.toUpperCase() + param1.slice(1);
      }
      
      public static function upperFirstLowerTail(param1:String) : String
      {
         var _loc2_:String = param1.charAt(0);
         return _loc2_.toUpperCase() + param1.slice(1).toLowerCase();
      }
   }
}
