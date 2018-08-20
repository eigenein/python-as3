package engine.loader
{
   public class ClientVersion
   {
      
      public static var preloader_ver:String;
      
      public static var lib_ver:String;
      
      public static var game_ver:String;
       
      
      public function ClientVersion()
      {
         super();
      }
      
      public static function get version() : String
      {
         return preloader_ver + " * " + lib_ver + " * " + game_ver;
      }
   }
}
