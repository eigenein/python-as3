package vm
{
   import flash.Boot;
   import vm.expr.Expr;
   
   public class VirtualFunction
   {
       
      
      public var params:Array;
      
      public var name:String;
      
      public var interp:InterpreterCore;
      
      public var expr:Expr;
      
      public function VirtualFunction(param1:InterpreterCore = undefined, param2:String = undefined, param3:Array = undefined, param4:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         interp = param1;
         params = param3;
         expr = param4;
         name = param2;
      }
      
      public function exec(param1:*, param2:Array) : *
      {
         var _loc7_:int = 0;
         if(int(param2.length) < int(params.length))
         {
         }
         var _loc3_:* = interp.context;
         interp.context = param1;
         var _loc4_:* = {};
         _loc4_.__stack__ = interp.stack;
         _loc4_.__proto__ = param1.__proto__;
         _loc4_.__method__ = name;
         interp.stack = _loc4_;
         var _loc5_:int = 0;
         var _loc6_:int = params.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            interp.stack[params[_loc7_]] = param2[_loc7_];
         }
         var _loc8_:* = interp.exprReturn(expr);
         interp.context = _loc3_;
         interp.stack = _loc4_.__stack__;
         _loc4_.__stack__ = null;
         _loc4_.__proto__ = null;
         return _loc8_;
      }
      
      public function bind(param1:*) : *
      {
         var f:Function = exec;
         var a1:* = param1;
         return Reflect.makeVarArgs(function(param1:Array):*
         {
            return f(a1,param1);
         });
      }
   }
}
