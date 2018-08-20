package vm.expr
{
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   import vm.Stop;
   
   public class EFor extends BlockExpr
   {
       
      
      public var n:String;
      
      public var it:Expr;
      
      public function EFor(param1:String = undefined, param2:Expr = undefined, param3:Expr = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         n = param1;
         it = param2;
         e = param3;
      }
      
      override public function resolve() : *
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as Array;
         var _loc5_:* = null;
         var _loc6_:* = null as Stop;
         var _loc7_:* = null;
         var _loc8_:* = null as IntIterator;
         var _loc9_:* = null as IntIterator;
         var _loc10_:int = 0;
         var _loc2_:* = it.resolve();
         if(_loc2_ is Array)
         {
            _loc3_ = 0;
            _loc4_ = _loc2_;
            loop3:
            while(_loc3_ < int(_loc4_.length))
            {
               _loc5_ = _loc4_[_loc3_];
               _loc3_++;
               Expr.context.stack[n] = _loc5_;
               try
               {
                  e.resolve();
               }
               catch(:Stop)
               {
                  _loc6_ = ;
                  switch(_loc6_.index)
                  {
                     case 0:
                        break loop3;
                     case 1:
                        continue;
                     case 2:
                        _loc7_ = _loc6_.params[0];
                        throw Stop.SReturn(_loc7_);
                  }
               }
            }
            return null;
         }
         if(_loc2_.hasOwnProperty("iterator"))
         {
            _loc2_ = _loc2_.iterator();
         }
         else if(_loc2_ is Dictionary)
         {
            _loc5_ = _loc2_;
            _loc3_ = 0;
            loop0:
            for(Expr.context.stack[n] in _loc2_)
            {
               try
               {
                  e.resolve();
               }
               catch(:Stop)
               {
                  _loc6_ = ;
                  switch(_loc6_.index)
                  {
                     case 0:
                        break loop0;
                     case 1:
                        continue;
                     case 2:
                        _loc7_ = _loc6_.params[0];
                        throw Stop.SReturn(_loc7_);
                  }
               }
            }
            return null;
         }
         if(_loc2_ is IntIterator)
         {
            _loc8_ = _loc2_;
            _loc9_ = _loc8_;
            loop2:
            while(_loc9_.min < _loc9_.max)
            {
               _loc10_ = _loc9_.min;
               _loc9_.min = _loc9_.min + 1;
               _loc3_ = _loc10_;
               Expr.context.stack[n] = _loc3_;
               try
               {
                  e.resolve();
               }
               catch(:Stop)
               {
                  _loc6_ = ;
                  switch(_loc6_.index)
                  {
                     case 0:
                        break loop2;
                     case 1:
                        continue;
                     case 2:
                        _loc5_ = _loc6_.params[0];
                        throw Stop.SReturn(_loc5_);
                  }
               }
            }
         }
         else
         {
            loop1:
            while(_loc2_.hasNext())
            {
               _loc5_ = _loc2_.next();
               Expr.context.stack[n] = _loc5_;
               try
               {
                  e.resolve();
               }
               catch(:Stop)
               {
                  _loc6_ = ;
                  switch(_loc6_.index)
                  {
                     case 0:
                        break loop1;
                     case 1:
                        continue;
                     case 2:
                        _loc5_ = _loc6_.params[0];
                        throw Stop.SReturn(_loc5_);
                  }
               }
            }
         }
         return null;
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
         it.encode(param1);
         e.encode(param1);
      }
   }
}
