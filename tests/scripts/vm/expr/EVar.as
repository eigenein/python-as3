package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EVar extends BlockExpr
   {
       
      
      public var n:String;
      
      public function EVar(param1:String = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         n = param1;
         e = param2;
      }
      
      override public function resolve() : *
      {
         var _loc1_:* = null;
         if(e == null)
         {
            _loc1_ = null;
         }
         else
         {
            _loc1_ = e.resolve();
         }
         Expr.context.stack[n] = _loc1_;
         return null;
      }
      
      override public function print() : String
      {
         if(e == null)
         {
            return "var " + n;
         }
         return "var " + n + " = " + e.print();
      }
      
      override public function isBlock() : Boolean
      {
         return e != null && e.isBlock();
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:String = n;
         if(_loc3_ != null)
         {
            _loc4_ = Bytes.ofString(_loc3_);
            param1.output.writeUInt16(_loc4_.length);
            param1.output.write(_loc4_);
         }
         else
         {
            param1.output.writeUInt16(0);
         }
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
