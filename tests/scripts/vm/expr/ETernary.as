package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class ETernary extends Expr
   {
       
      
      public var e2:Expr;
      
      public var e1:Expr;
      
      public var cond:Expr;
      
      public function ETernary(param1:Expr = undefined, param2:Expr = undefined, param3:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cond = param1;
         e1 = param2;
         e2 = param3;
      }
      
      override public function resolve() : *
      {
         if(cond.resolve() == true)
         {
            return e1.resolve();
         }
         return e2.resolve();
      }
      
      override public function print() : String
      {
         return cond.print() + " ? " + e1.print() + (e2 == null?"":" : " + e2.print());
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         cond.encode(param1);
         e1.encode(param1);
         e2.encode(param1);
      }
   }
}
