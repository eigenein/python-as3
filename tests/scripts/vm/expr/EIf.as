package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EIf extends Expr
   {
       
      
      public var e2:Expr;
      
      public var e1:Expr;
      
      public var cond:Expr;
      
      public function EIf(param1:Expr = undefined, param2:Expr = undefined, param3:Expr = undefined)
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
         if(e2 == null)
         {
            return null;
         }
         return e2.resolve();
      }
      
      override public function print() : String
      {
         return "if " + cond.print() + " {\n" + e1.print() + (e2 == null?"\n}":"\n} else {\n" + e2.print() + "\n}");
      }
      
      override public function isBlock() : Boolean
      {
         if(e2 != null)
         {
            return Boolean(e2.isBlock());
         }
         return Boolean(e1.isBlock());
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         cond.encode(param1);
         e1.encode(param1);
         if(e2 == null)
         {
            param1.output.writeByte(255);
         }
         else
         {
            e2.encode(param1);
         }
      }
   }
}
