package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EThrow extends Expr
   {
       
      
      public var e:Expr;
      
      public function EThrow(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
      }
      
      override public function resolve() : *
      {
         error(vm.Error.EScriptThrow(e.resolve()));
         return null;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
      }
   }
}
