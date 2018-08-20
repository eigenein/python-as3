package battle.utils
{
   import flash.Boot;
   
   public class Exception extends Error
   {
       
      
      public function Exception(param1:ExceptionType = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(Type.enumConstructor(param1));
      }
   }
}
