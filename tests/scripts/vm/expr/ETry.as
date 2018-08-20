package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class ETry extends Expr
   {
       
      
      public var n:String;
      
      public var ecatch:Expr;
      
      public var e:Expr;
      
      public function ETry(param1:Expr = undefined, param2:String = undefined, param3:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
         n = param2;
         ecatch = param3;
      }
      
      override public function resolve() : *
      {
         var _loc2_:* = null as Stop;
         var _loc3_:* = null;
         try
         {
            return e.resolve();
         }
         catch(:Stop)
         {
            _loc2_ = ;
            error(vm.Error.EStop(Std.string(_loc2_)));
            return null;
         }
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
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
         ecatch.encode(param1);
      }
   }
}
