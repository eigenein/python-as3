package vm.expr
{
   import flash.Boot;
   
   public class BAssign extends EBinop
   {
       
      
      public function BAssign(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
      
      override public function resolve() : *
      {
         return a.assign(b);
      }
      
      override public function op() : String
      {
         return "=";
      }
   }
}
