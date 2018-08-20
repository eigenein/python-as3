package vm.expr
{
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class EBreak extends Expr
   {
       
      
      public function EBreak()
      {
      }
      
      override public function resolve() : *
      {
         throw Stop.SBreak;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
      }
   }
}
