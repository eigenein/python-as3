package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import haxe.io.BytesOutput;
   import vm.ByteCode;
   import vm.VirtualClass;
   import vm.VirtualFunction;
   
   public class EClass extends EClassLevel
   {
       
      
      public var vars:Array;
      
      public var sVars:Array;
      
      public var sFuns:Array;
      
      public var parent:String;
      
      public var name:String;
      
      public var funs:Array;
      
      public var file:String;
      
      public function EClass(param1:String = undefined, param2:String = undefined, param3:String = undefined, param4:Array = undefined, param5:Array = undefined, param6:Array = undefined, param7:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
         file = param2;
         parent = param3;
         vars = param4;
         sVars = param5;
         funs = param6;
         sFuns = param7;
      }
      
      override public function writeHeader(param1:BytesOutput) : void
      {
         param1.writeByte(name.length);
         param1.write(Bytes.ofString(name));
      }
      
      override public function writeBody(param1:BytesOutput) : void
      {
         var _loc2_:Bytes = ByteCode.encode(this);
         param1.writeUInt24(_loc2_.length);
         param1.write(_loc2_);
      }
      
      override public function print() : String
      {
         var _loc4_:* = null as EVar;
         var _loc5_:* = null as EFunction;
         var _loc1_:String = "class " + name;
         if(parent != null)
         {
            _loc1_ = _loc1_ + (" extends " + parent + " {");
         }
         else
         {
            _loc1_ = _loc1_ + "{";
         }
         var _loc2_:int = 0;
         var _loc3_:Array = sVars;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.e != null)
            {
               _loc1_ = _loc1_ + ("\n" + "public static var " + _loc4_.n + " = " + _loc4_.e.print() + ";");
            }
            else
            {
               _loc1_ = _loc1_ + ("\n" + "public static var " + _loc4_.n + ";");
            }
         }
         _loc1_ = _loc1_ + "\n";
         _loc2_ = 0;
         _loc3_ = vars;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            if(_loc4_.e != null)
            {
               _loc1_ = _loc1_ + ("\n\t" + "public var " + _loc4_.n + " = " + _loc4_.e.print() + ";");
            }
            else
            {
               _loc1_ = _loc1_ + ("\n" + "public var " + _loc4_.n + ";");
            }
         }
         _loc1_ = _loc1_ + "\n";
         _loc2_ = 0;
         _loc3_ = sFuns;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc5_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_ = _loc1_ + ("\n" + "public static function " + _loc5_.name + "(" + _loc5_.args.join(", ") + " ) {\n\t" + _loc5_.e.print().split("\n").join("\n\t") + "\n}");
         }
         _loc1_ = _loc1_ + "\n";
         _loc2_ = 0;
         _loc3_ = funs;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc5_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_ = _loc1_ + ("\n" + "public function " + _loc5_.name + "(" + _loc5_.args.join(", ") + " ) {\n\t" + _loc5_.e.print().split("\n").join("\n\t") + "\n}");
         }
         _loc1_ + "\n}";
         return _loc1_;
      }
      
      override public function initialize() : void
      {
         var _loc4_:* = null as EVar;
         var _loc5_:* = null as EFunction;
         var _loc6_:* = null;
         var _loc1_:VirtualClass = new VirtualClass(Expr.context);
         _loc1_.className = name;
         _loc1_.fileName = file;
         _loc1_.superName = parent;
         var _loc2_:int = 0;
         var _loc3_:Array = vars;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_.varsProto[_loc4_.n] = _loc4_.e;
         }
         _loc2_ = 0;
         _loc3_ = sVars;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc1_.sVarsProto[_loc4_.n] = _loc4_.e;
         }
         _loc2_ = 0;
         _loc3_ = funs;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc5_ = _loc3_[_loc2_];
            _loc2_++;
            _loc6_ = new VirtualFunction(Expr.context,_loc5_.name,_loc5_.args,_loc5_.e);
            _loc1_.funsProto[_loc5_.name] = _loc6_;
         }
         _loc2_ = 0;
         _loc3_ = sFuns;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc5_ = _loc3_[_loc2_];
            _loc2_++;
            _loc6_ = new VirtualFunction(Expr.context,_loc5_.name,_loc5_.args,_loc5_.e);
            _loc1_.sFunsProto[_loc5_.name] = _loc6_;
         }
         Expr.context.classMap.h[name] = _loc1_;
         _loc1_.initialize();
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc3_:* = null as Bytes;
         var _loc6_:* = null as EVar;
         var _loc7_:* = null as EFunction;
         var _loc2_:String = name;
         if(_loc2_ != null)
         {
            _loc3_ = Bytes.ofString(_loc2_);
            param1.output.writeUInt16(_loc3_.length);
            param1.output.write(_loc3_);
         }
         else
         {
            param1.output.writeUInt16(0);
         }
         _loc2_ = file;
         if(_loc2_ != null)
         {
            _loc3_ = Bytes.ofString(_loc2_);
            param1.output.writeUInt16(_loc3_.length);
            param1.output.write(_loc3_);
         }
         else
         {
            param1.output.writeUInt16(0);
         }
         _loc2_ = parent;
         if(_loc2_ != null)
         {
            _loc3_ = Bytes.ofString(_loc2_);
            param1.output.writeUInt16(_loc3_.length);
            param1.output.write(_loc3_);
         }
         else
         {
            param1.output.writeUInt16(0);
         }
         param1.output.writeUInt16(int(vars.length));
         var _loc4_:int = 0;
         var _loc5_:Array = vars;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc4_];
            _loc4_++;
            _loc6_.encode(param1);
         }
         param1.output.writeUInt16(int(sVars.length));
         _loc4_ = 0;
         _loc5_ = sVars;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc4_];
            _loc4_++;
            _loc6_.encode(param1);
         }
         param1.output.writeUInt16(int(funs.length));
         _loc4_ = 0;
         _loc5_ = funs;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc7_ = _loc5_[_loc4_];
            _loc4_++;
            _loc7_.encode(param1);
         }
         param1.output.writeUInt16(int(sFuns.length));
         _loc4_ = 0;
         _loc5_ = sFuns;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc7_ = _loc5_[_loc4_];
            _loc4_++;
            _loc7_.encode(param1);
         }
      }
      
      override public function classCounter() : int
      {
         return 1;
      }
   }
}
