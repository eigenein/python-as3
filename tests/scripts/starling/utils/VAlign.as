package starling.utils
{
   import starling.errors.AbstractClassError;
   
   public final class VAlign
   {
      
      public static const TOP:String = "top";
      
      public static const CENTER:String = "center";
      
      public static const BOTTOM:String = "bottom";
       
      
      public function VAlign()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function isValid(param1:String) : Boolean
      {
         return param1 == "top" || param1 == "center" || param1 == "bottom";
      }
   }
}
