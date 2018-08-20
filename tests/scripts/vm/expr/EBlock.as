package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EBlock extends Expr
   {
       
      
      public var expressions:Array;
      
      public function EBlock(param1:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         expressions = param1;
      }
      
      override public function resolve() : *
      {
         var _loc4_:* = null as Expr;
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:Array = expressions;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_ = _loc4_.resolve();
         }
         return _loc1_;
      }
      
      override public function print() : String
      {
         var _loc4_:* = null as Expr;
         var _loc1_:String = "";
         var _loc2_:int = 0;
         var _loc3_:Array = expressions;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_ = _loc1_ + (_loc4_.print() + ";\n");
         }
         return _loc1_;
      }
      
      override public function isBlock() : Boolean
      {
         return true;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Expr;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         param1.output.writeUInt16(int(expressions.length));
         _loc2_ = 0;
         var _loc3_:Array = expressions;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc4_.encode(param1);
         }
      }
   }
}
