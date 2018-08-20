package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EClassIdent extends Expr
   {
       
      
      public var v:String;
      
      public function EClassIdent(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         v = param1;
      }
      
      override public function resolve() : *
      {
         return Expr.context.resolveClass(v);
      }
      
      override public function print() : String
      {
         return v;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:String = v;
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
      }
   }
}
