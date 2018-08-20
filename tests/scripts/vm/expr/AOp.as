package vm.expr
{
   import flash.Boot;
   
   public class AOp extends EBinop
   {
       
      
      public function AOp(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
      
      public function resolveAssignment(param1:*) : *
      {
         return param1 + b.resolve();
      }
      
      override public function resolve() : *
      {
         return a.reverseAssign(this);
      }
   }
}
