package vm.expr
{
   import flash.Boot;
   
   public class EPackage extends EClassLevel
   {
       
      
      public var v:String;
      
      public function EPackage(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         v = param1;
      }
   }
}
