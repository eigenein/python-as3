package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.VirtualFunction;
   
   public class EFunction extends BlockExpr
   {
       
      
      public var name:String;
      
      public var args:Array;
      
      public function EFunction(param1:String = undefined, param2:Array = undefined, param3:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
         args = param2;
         e = param3;
      }
      
      override public function resolve() : *
      {
         if(name == null)
         {
            name = "anonymous";
         }
         var _loc1_:VirtualFunction = new VirtualFunction(Expr.context,name,args,e);
         return _loc1_.bind(Expr.context.stack);
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc3_:* = null as String;
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         if(name == null)
         {
            _loc3_ = "";
         }
         else
         {
            _loc3_ = name;
         }
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
         param1.output.writeByte(int(args.length));
         _loc2_ = 0;
         var _loc5_:Array = args;
         while(_loc2_ < int(_loc5_.length))
         {
            _loc3_ = _loc5_[_loc2_];
            _loc2_++;
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
         e.encode(param1);
      }
   }
}
