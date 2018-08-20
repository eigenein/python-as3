package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EBinop extends Expr
   {
       
      
      public var b:Expr;
      
      public var a:Expr;
      
      public function EBinop(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         a = param1;
         b = param2;
      }
      
      public static function create(param1:String, param2:Expr, param3:Expr) : EBinop
      {
         var _loc4_:String = param1;
         if(_loc4_ == "+")
         {
            return new BPlus(param2,param3);
         }
         if(_loc4_ == "-")
         {
            return new BMinus(param2,param3);
         }
         if(_loc4_ == "*")
         {
            return new BMultiply(param2,param3);
         }
         if(_loc4_ == "/")
         {
            return new BDivide(param2,param3);
         }
         if(_loc4_ == "%")
         {
            return new BMod(param2,param3);
         }
         if(_loc4_ == "&")
         {
            return new BBitAnd(param2,param3);
         }
         if(_loc4_ == "|")
         {
            return new BBitOr(param2,param3);
         }
         if(_loc4_ == "^")
         {
            return new BBitXor(param2,param3);
         }
         if(_loc4_ == "<<")
         {
            return new BLShift(param2,param3);
         }
         if(_loc4_ == ">>")
         {
            return new BRShift(param2,param3);
         }
         if(_loc4_ == ">>>")
         {
            return new BURShift(param2,param3);
         }
         if(_loc4_ == "==")
         {
            return new BEqual(param2,param3);
         }
         if(_loc4_ == "!=")
         {
            return new BNotEqual(param2,param3);
         }
         if(_loc4_ == ">=")
         {
            return new BMoreEqual(param2,param3);
         }
         if(_loc4_ == "<=")
         {
            return new BLessEqual(param2,param3);
         }
         if(_loc4_ == ">")
         {
            return new BMore(param2,param3);
         }
         if(_loc4_ == "<")
         {
            return new BLess(param2,param3);
         }
         if(_loc4_ == "||")
         {
            return new BOr(param2,param3);
         }
         if(_loc4_ == "&&")
         {
            return new BAnd(param2,param3);
         }
         if(_loc4_ == "=")
         {
            return new BAssign(param2,param3);
         }
         if(_loc4_ == "...")
         {
            return new BIntIterator(param2,param3);
         }
         if(_loc4_ == "+=")
         {
            return new APlus(param2,param3);
         }
         if(_loc4_ == "-=")
         {
            return new AMinus(param2,param3);
         }
         if(_loc4_ == "*=")
         {
            return new AMultiply(param2,param3);
         }
         if(_loc4_ == "/=")
         {
            return new ADivide(param2,param3);
         }
         if(_loc4_ == "%=")
         {
            return new AMod(param2,param3);
         }
         if(_loc4_ == "&=")
         {
            return new ABitAnd(param2,param3);
         }
         if(_loc4_ == "|=")
         {
            return new ABitOr(param2,param3);
         }
         if(_loc4_ == "^=")
         {
            return new ABitXor(param2,param3);
         }
         if(_loc4_ == "<<=")
         {
            return new ALShift(param2,param3);
         }
         if(_loc4_ == ">>=")
         {
            return new ARShift(param2,param3);
         }
         if(_loc4_ == ">>>=")
         {
            return new AURShift(param2,param3);
         }
         Expr.creationError(vm.Error.EInvalidOp(param1));
         return null;
      }
      
      override public function print() : String
      {
         return a.print() + " " + op() + " " + b.print();
      }
      
      public function op() : String
      {
         return "unknown";
      }
      
      override public function isBlock() : Boolean
      {
         return Boolean(b.isBlock());
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
         a.encode(param1);
         b.encode(param1);
      }
   }
}
