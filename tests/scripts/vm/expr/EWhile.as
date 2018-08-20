package vm.expr
{
   import flash.Boot;
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class EWhile extends BlockExpr
   {
       
      
      public var cond:Expr;
      
      public function EWhile(param1:Expr = undefined, param2:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cond = param1;
         e = param2;
      }
      
      override public function resolve() : *
      {
         var _loc2_:* = null as Stop;
         var _loc3_:* = null;
         loop0:
         while(cond.resolve() == true)
         {
            try
            {
               e.resolve();
            }
            catch(:Stop)
            {
               _loc2_ = ;
               switch(_loc2_.index)
               {
                  case 0:
                     break loop0;
                  case 1:
                     continue;
                  case 2:
                     _loc3_ = _loc2_.params[0];
                     throw Stop.SReturn(_loc3_);
               }
            }
         }
         return null;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         cond.encode(param1);
         e.encode(param1);
      }
   }
}
