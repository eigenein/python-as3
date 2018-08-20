package vm.expr
{
   import flash.Boot;
   
   public class OpUnaryMinus extends EUnop
   {
       
      
      public function OpUnaryMinus(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      override public function resolve() : *
      {
         return -e.resolve();
      }
      
      override public function op() : String
      {
         return "-";
      }
   }
}
