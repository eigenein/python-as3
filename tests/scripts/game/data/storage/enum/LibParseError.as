package game.data.storage.enum
{
   public class LibParseError extends Error
   {
      
      public static const ERROR_NOT_IMPLEMENTED:LibParseError = new LibParseError("ERROR_NOT_IMPLEMENTED");
       
      
      public function LibParseError(param1:* = "", param2:* = 0)
      {
         super(param1,param2);
      }
   }
}
