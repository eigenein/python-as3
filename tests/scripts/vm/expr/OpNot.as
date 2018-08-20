package vm.expr
{
   import flash.Boot;
   
   public class OpNot extends EUnop
   {
       
      
      public function OpNot(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      override public function resolve() : *
      {
         return e.resolve() != true;
      }
      
      override public function op() : String
      {
         return "!";
      }
   }
}
