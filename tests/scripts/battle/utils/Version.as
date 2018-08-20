package battle.utils
{
   public class Version
   {
      
      public static var last:int = Std.parseInt("142");
      
      public static var current:int = Version.last;
      
      public static var debug:int = 0;
      
      public static var test:int = 0;
       
      
      public function Version()
      {
      }
      
      public static function isActualVersion(param1:int) : Boolean
      {
         if(param1 == Version.debug || param1 == Version.test)
         {
            return true;
         }
         return param1 == Version.current;
      }
   }
}
