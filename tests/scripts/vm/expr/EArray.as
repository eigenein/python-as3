package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EArray extends Assignable
   {
       
      
      public var index:Expr;
      
      public var e:Expr;
      
      public function EArray(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
         index = param2;
      }
      
      override public function reverseAssign(param1:AOp) : *
      {
         var _loc2_:Array = e.resolve();
         var _loc3_:int = index.resolve();
         var _loc4_:* = param1.resolveAssignment(_loc2_[_loc3_]);
         _loc2_[_loc3_] = _loc4_;
         return _loc4_;
      }
      
      override public function resolve() : *
      {
         return e.resolve()[index.resolve()];
      }
      
      override public function increment(param1:Boolean, param2:int) : *
      {
         var _loc3_:Array = e.resolve();
         var _loc4_:int = index.resolve();
         var _loc5_:* = int(_loc3_[_loc4_]);
         if(param1)
         {
            _loc5_ = _loc5_ + param2;
            _loc3_[_loc4_] = _loc5_;
         }
         else
         {
            _loc3_[_loc4_] = _loc5_ + param2;
         }
         return _loc5_;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
         index.encode(param1);
      }
      
      override public function assign(param1:*) : *
      {
         var _loc2_:Expr = param1;
         var _loc3_:* = _loc2_.resolve();
         e.resolve()[index.resolve()] = _loc3_;
         return _loc3_;
      }
   }
}
