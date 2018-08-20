package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EUnop extends BlockExpr
   {
       
      
      public function EUnop(param1:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
      }
      
      public static function create(param1:String, param2:Boolean, param3:Expr) : EUnop
      {
         var _loc4_:String = param1;
         if(_loc4_ == "!")
         {
            return new OpNot(param3);
         }
         if(_loc4_ == "-")
         {
            return new OpUnaryMinus(param3);
         }
         if(_loc4_ == "++")
         {
            return new OpInc(param2,param3);
         }
         if(_loc4_ == "--")
         {
            return new OpDec(param2,param3);
         }
         if(_loc4_ == "~")
         {
            return new OpBinaryNot(param3);
         }
         Expr.creationError(vm.Error.EInvalidOp(param1));
         return null;
      }
      
      override public function print() : String
      {
         return op() + e.print();
      }
      
      public function op() : String
      {
         return "unknown";
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:String = op();
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
         param1.output.writeByte(0);
         e.encode(param1);
      }
   }
}
