package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class EReturn extends BlockExpr
   {
       
      
      public function EReturn(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
      }
      
      override public function resolve() : *
      {
         throw Stop.SReturn(e == null?null:e.resolve());
      }
      
      override public function print() : String
      {
         if(e != null)
         {
            return "return " + e.print();
         }
         return "return";
      }
      
      override public function isBlock() : Boolean
      {
         return e != null && e.isBlock();
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         if(e == null)
         {
            param1.output.writeByte(255);
         }
         else
         {
            e.encode(param1);
         }
      }
   }
}
