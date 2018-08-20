package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class OpDec extends EUnop
   {
       
      
      public var prefix:Boolean;
      
      public function OpDec(param1:Boolean = false, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         prefix = param1;
         super(param2);
      }
      
      override public function resolve() : *
      {
         var _loc1_:Assignable = e;
         if(_loc1_ == null)
         {
            error(vm.Error.EInvalidOp("--"));
            return null;
         }
         return _loc1_.increment(prefix,-1);
      }
      
      override public function print() : String
      {
         if(prefix)
         {
            return op() + e.print();
         }
         return Std.string(e.print) + op();
      }
      
      override public function op() : String
      {
         return "--";
      }
      
      override public function isBlock() : Boolean
      {
         return !prefix && e.isBlock();
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
         param1.output.writeByte(!!prefix?1:0);
         e.encode(param1);
      }
   }
}
