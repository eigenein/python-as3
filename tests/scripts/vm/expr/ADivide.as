package vm.expr
{
   import flash.Boot;
   
   public class ADivide extends AOp
   {
       
      
      public function ADivide(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
      
      override public function resolveAssignment(param1:*) : *
      {
         return param1 / b.resolve();
      }
      
      override public function op() : String
      {
         return "/=";
      }
   }
}
