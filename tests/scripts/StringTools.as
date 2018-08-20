package
{
   public class StringTools
   {
       
      
      public function StringTools()
      {
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
   }
}
