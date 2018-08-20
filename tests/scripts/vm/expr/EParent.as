package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EParent extends Expr
   {
       
      
      public var e:Expr;
      
      public function EParent(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
      }
      
      override public function resolve() : *
      {
         return e.resolve();
      }
      
      override public function print() : String
      {
         return "(" + e.print() + ")";
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
      }
   }
}
