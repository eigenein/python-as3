package vm.expr
{
   public class BlockExpr extends Expr
   {
       
      
      public var e:Expr;
      
      public function BlockExpr()
      {
      }
      
      override public function isBlock() : Boolean
      {
         return Boolean(e.isBlock());
      }
   }
}
