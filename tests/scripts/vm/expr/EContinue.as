package vm.expr
{
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class EContinue extends Expr
   {
       
      
      public function EContinue()
      {
      }
      
      override public function resolve() : *
      {
         throw Stop.SContinue;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
      }
   }
}
