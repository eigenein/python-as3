package vm.expr
{
   import flash.Boot;
   
   public class BAnd extends EBinop
   {
       
      
      public function BAnd(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
      
      override public function resolve() : *
      {
         return a.resolve() == true && b.resolve() == true;
      }
      
      override public function op() : String
      {
         return "&&";
      }
   }
}
