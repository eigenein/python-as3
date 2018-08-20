package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class ECall extends Expr
   {
       
      
      public var params:Array;
      
      public var e:Expr;
      
      public function ECall(param1:Expr = undefined, param2:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
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
         var _loc5_:* = e.resolve();
         return _loc5_.apply(null,_loc1_);
      }
      
      override public function print() : String
      {
         var _loc5_:* = null as Expr;
         var _loc1_:String = e.print() + "(";
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
         var _loc4_:* = null as Expr;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
         param1.output.writeByte(int(params.length));
         _loc2_ = 0;
         var _loc3_:Array = params;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc4_.encode(param1);
         }
      }
   }
}
