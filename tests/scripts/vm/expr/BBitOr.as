package vm.expr
{
   import flash.Boot;
   
   public class BBitOr extends EBinop
   {
       
      
      public function BBitOr(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
      }
      
      override public function resolve() : *
      {
         return a.resolve() | b.resolve();
      }
      
      override public function op() : String
      {
         return "|";
      }
   }
}
