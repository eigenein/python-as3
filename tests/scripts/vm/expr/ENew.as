package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class ENew extends Expr
   {
       
      
      public var params:Array;
      
      public var cl:String;
      
      public function ENew(param1:String = undefined, param2:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cl = param1;
         params = param2;
      }
      
      override public function resolve() : *
      {
         var _loc4_:* = null as Expr;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         var _loc3_:Array = params;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_.push(_loc4_.resolve());
         }
         return Expr.context.createInstance(cl,_loc1_);
      }
      
      override public function print() : String
      {
         var _loc5_:* = null as Expr;
         var _loc1_:String = "new " + cl + "(";
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         var _loc4_:Array = params;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            if(_loc2_)
            {
               _loc1_ = _loc1_ + _loc5_.print();
               _loc2_ = false;
            }
            else
            {
               _loc1_ = _loc1_ + (", " + _loc5_.print());
            }
         }
         return _loc1_ + ")";
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc6_:* = null as Expr;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:String = cl;
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
         param1.output.writeByte(int(params.length));
         _loc2_ = 0;
         var _loc5_:Array = params;
         while(_loc2_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc2_];
            _loc2_++;
            _loc6_.encode(param1);
         }
      }
   }
}
