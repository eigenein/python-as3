package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EParameter extends EVar
   {
       
      
      public function EParameter(param1:String = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
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
