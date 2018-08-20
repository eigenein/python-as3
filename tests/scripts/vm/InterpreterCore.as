package vm
{
   import flash.Boot;
   import flash.Lib;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import haxe.CallStack;
   import haxe.Http;
   import haxe.List;
   import haxe.Log;
   import haxe.Serializer;
   import haxe.Template;
   import haxe.Unserializer;
   import haxe.Utf8;
   import haxe.crypto.Adler32;
   import haxe.crypto.BaseCode;
   import haxe.crypto.Crc32;
   import haxe.crypto.Md5;
   import haxe.crypto.Sha1;
   import haxe.ds.ArraySort;
   import haxe.ds.BalancedTree;
   import haxe.ds.EnumValueMap;
   import haxe.ds.IntMap;
   import haxe.ds.ObjectMap;
   import haxe.ds.StringMap;
   import haxe.ds.UnsafeStringMap;
   import haxe.ds.WeakMap;
   import haxe.io.BufferInput;
   import haxe.io.Bytes;
   import haxe.io.BytesBuffer;
   import haxe.io.BytesInput;
   import haxe.io.BytesOutput;
   import haxe.io.Eof;
   import haxe.io.Input;
   import haxe.io.Output;
   import haxe.io.Path;
   import haxe.io.StringInput;
   import vm.expr.EClassLevel;
   import vm.expr.Expr;
   
   public class InterpreterCore
   {
      
      public static var exprTypeIndex:Array = [null,null,null,EFunction,EReturn,ECall,EConst,EVar,EIdent,EClassIdent,EObject,EParent,EField,EBlock,EBinop,EUnop,EIf,ETernary,EWhile,EFor,EBreak,EContinue,EArray,EArrayDecl,ENew,EThrow,ETry,ELine,EFieldCall,EImport,EClass];
      
      public static var n:int = 0;
       
      
      public var stack;
      
      public var env:UnsafeStringMap;
      
      public var context;
      
      public var classMap:UnsafeStringMap;
      
      public function InterpreterCore()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         Expr.context = this;
         classMap = new UnsafeStringMap();
         initEnv();
      }
      
      public static function typeIndex(param1:Expr) : int
      {
         var _loc4_:* = null as Class;
         var _loc2_:Class = Type.getClass(param1);
         var _loc3_:int = InterpreterCore.exprTypeIndex.indexOf(_loc2_);
         if(_loc3_ == -1)
         {
            _loc4_ = Type.getSuperClass(_loc2_);
            _loc3_ = InterpreterCore.exprTypeIndex.indexOf(_loc4_);
            if(_loc3_ == -1)
            {
               _loc4_ = Type.getSuperClass(_loc4_);
               _loc3_ = InterpreterCore.exprTypeIndex.indexOf(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function resolveClass(param1:String) : *
      {
         var _loc3_:* = null as String;
         if(param1 in classMap.h)
         {
            return classMap.h[param1].sVars;
         }
         var _loc2_:* = env.h[param1];
         if(_loc2_ == null)
         {
            _loc2_ = Type.resolveClass(param1);
         }
         if(_loc2_ == null)
         {
            _loc3_ = stack.__proto__.className;
            _loc3_ = _loc3_.substr(0,int(_loc3_.lastIndexOf(".")) + 1) + param1;
            if(_loc3_ in classMap.h)
            {
               return classMap.h[_loc3_].sVars;
            }
         }
         if(_loc2_ == null)
         {
            error(Error.EInvalid("Class:" + param1));
         }
         return _loc2_;
      }
      
      public function resolve(param1:String) : *
      {
         var _loc2_:* = null;
         if(stack != null && stack.hasOwnProperty(param1))
         {
            return stack[param1];
         }
         if(context != null)
         {
            if(context.hasOwnProperty(param1))
            {
               return context[param1];
            }
            if(context.__static__ != null && context.__static__.hasOwnProperty(param1))
            {
               return context.__static__[param1];
            }
            if(param1 in env.h)
            {
               return env.h[param1];
            }
            if(param1 == "this")
            {
               return context;
            }
            if(param1 == "super")
            {
               return context.__super__;
            }
            _loc2_ = context.__super__;
            while(_loc2_ != null)
            {
               if(_loc2_.hasOwnProperty(param1))
               {
                  return _loc2_[param1];
               }
               _loc2_ = _loc2_.__super__;
            }
            return error(Error.EInvalid("Access:" + param1));
         }
         return error(Error.EInvalid("Access:" + param1));
      }
      
      public function register(param1:String, param2:*) : void
      {
         var _loc3_:* = param2;
         env.h[param1] = _loc3_;
      }
      
      public function log(param1:*) : void
      {
         Interpreter.trace((stack.__proto__ != null?stack.__proto__.fileName:"unknown") + ":" + Std.string(stack.__line__) + ": " + Std.string(stack.__method__) + " " + Std.string(param1));
      }
      
      public function loadClasses(param1:Array) : void
      {
         var _loc3_:* = null as EClassLevel;
         var _loc2_:int = 0;
         while(_loc2_ < int(param1.length))
         {
            _loc3_ = param1[_loc2_];
            _loc2_++;
            _loc3_.initialize();
         }
      }
      
      public function initEnv() : void
      {
         env = new UnsafeStringMap();
         env.h["trace"] = log;
         env.h["null"] = null;
         env.h["true"] = true;
         env.h["false"] = false;
         env.h["Type"] = Type;
         env.h["Date"] = Date;
         env.h["DateTools"] = DateTools;
         env.h["EReg"] = EReg;
         env.h["IntIterator"] = IntIterator;
         env.h["Lambda"] = Lambda;
         env.h["List"] = List;
         env.h["Math"] = Math;
         env.h["Reflect"] = Reflect;
         env.h["Std"] = Std;
         env.h["String"] = String;
         env.h["StringBuf"] = StringBuf;
         env.h["StringTools"] = StringTools;
         env.h["Type"] = Type;
         env.h["Xml"] = Xml;
         env.h["haxe.CallStack"] = CallStack;
         env.h["haxe.Http"] = Http;
         env.h["haxe.Json"] = JSON;
         env.h["haxe.Log"] = Log;
         env.h["haxe.Serializer"] = Serializer;
         env.h["haxe.Template"] = Template;
         env.h["haxe.Unserializer"] = Unserializer;
         env.h["haxe.Utf8"] = Utf8;
         env.h["haxe.crypto.Adler32"] = Adler32;
         env.h["haxe.crypto.BaseCode"] = BaseCode;
         env.h["haxe.crypto.Crc32"] = Crc32;
         env.h["haxe.crypto.Md5"] = Md5;
         env.h["haxe.crypto.Sha1"] = Sha1;
         env.h["haxe.ds.ArraySort"] = ArraySort;
         env.h["haxe.ds.BalancedTree"] = BalancedTree;
         env.h["haxe.ds.EnumValueMap"] = EnumValueMap;
         env.h["haxe.ds.IntMap"] = IntMap;
         env.h["haxe.ds.ObjectMap"] = ObjectMap;
         env.h["haxe.ds.StringMap"] = StringMap;
         env.h["haxe.ds.WeakMap"] = WeakMap;
         env.h["haxe.io.BufferInput"] = BufferInput;
         env.h["haxe.io.Bytes"] = Bytes;
         env.h["haxe.io.BytesBuffer"] = BytesBuffer;
         env.h["haxe.io.BytesData"] = ByteArray;
         env.h["haxe.io.BytesInput"] = BytesInput;
         env.h["haxe.io.BytesOutput"] = BytesOutput;
         env.h["haxe.io.Eof"] = Eof;
         env.h["haxe.io.Input"] = Input;
         env.h["haxe.io.Output"] = Output;
         env.h["haxe.io.Path"] = Path;
         env.h["haxe.io.StringInput"] = StringInput;
         env.h["Lib"] = Lib;
         env.h["Point"] = Point;
         env.h["Matrix"] = Matrix;
      }
      
      public function exprReturn(param1:Object) : *
      {
         var _loc3_:* = null as Stop;
         var _loc4_:* = null;
         try
         {
            return param1.resolve();
         }
         catch(:Stop)
         {
            _loc3_ = ;
            switch(_loc3_.index)
            {
               case 0:
                  error(Error.EInvalid("break"));
                  break;
               case 1:
                  error(Error.EInvalid("continue"));
                  break;
               case 2:
                  _loc4_ = _loc3_.params[0];
                  return _loc4_;
            }
         }
         break loop0;
      }
      
      public function error(param1:Error) : *
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function declare(param1:String, param2:*) : void
      {
         stack[param1] = param2;
      }
      
      public function createInstance(param1:String, param2:Array) : *
      {
         var _loc3_:* = null as VirtualClass;
         var _loc4_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null as Array;
         var _loc9_:int = 0;
         var _loc10_:* = null as String;
         var _loc11_:* = null;
         if(param1 in classMap.h)
         {
            _loc3_ = classMap.h[param1];
            _loc4_ = true;
            _loc5_ = null;
            _loc6_ = {};
            _loc6_.__proto__ = _loc3_;
            _loc6_.__static__ = _loc3_.sVars;
            if(_loc3_.superName != null && _loc3_.superName != "")
            {
               _loc6_.__super__ = _loc3_.interp.createEmptyInstance(_loc3_.superName,_loc6_);
            }
            else
            {
               _loc6_.__super__ = null;
            }
            _loc7_ = _loc3_.interp.context;
            _loc3_.interp.context = _loc6_;
            if(_loc5_ == null)
            {
               _loc5_ = _loc6_;
            }
            _loc8_ = Reflect.fields(_loc3_.funsProto);
            _loc9_ = 0;
            while(_loc9_ < int(_loc8_.length))
            {
               _loc10_ = _loc8_[_loc9_];
               _loc9_++;
               _loc11_ = _loc3_.funsProto[_loc10_].bind(_loc5_);
               _loc6_[_loc10_] = _loc11_;
            }
            _loc8_ = Reflect.fields(_loc3_.varsProto);
            _loc9_ = 0;
            while(_loc9_ < int(_loc8_.length))
            {
               _loc10_ = _loc8_[_loc9_];
               _loc9_++;
               if(_loc3_.varsProto[_loc10_] != null)
               {
                  _loc11_ = _loc3_.varsProto[_loc10_].resolve();
                  _loc6_[_loc10_] = _loc11_;
               }
               else
               {
                  _loc6_[_loc10_] = null;
               }
            }
            if(!!_loc4_ && _loc6_.hasOwnProperty("new"))
            {
               _loc6_["new"].apply(null,param2);
            }
            _loc3_.interp.context = _loc7_;
            return _loc6_;
         }
         _loc5_ = env.h[param1];
         if(_loc5_ == null)
         {
            _loc5_ = Type.resolveClass(param1);
         }
         if(_loc5_ == null)
         {
            error(Error.EInvalid("Class:" + param1));
         }
         return Type.createInstance(_loc5_,param2);
      }
      
      public function createEmptyInstance(param1:String, param2:*) : *
      {
         if(param1 in classMap.h)
         {
            return classMap.h[param1].createInstance(null,false,param2);
         }
         var _loc3_:* = env.h[param1];
         if(_loc3_ == null)
         {
            _loc3_ = Type.resolveClass(param1);
         }
         if(_loc3_ == null)
         {
            error(Error.EInvalid("Class:" + param1));
         }
         return Type.createEmptyInstance(_loc3_);
      }
      
      public function callStatic(param1:String, param2:String, param3:Array) : *
      {
         return classMap.h[param1].sVars[param2].apply(null,param3);
      }
      
      public function assignIdent(param1:String, param2:*) : *
      {
         var _loc3_:* = null;
         if(stack.hasOwnProperty(param1))
         {
            stack[param1] = param2;
         }
         else if(context != null)
         {
            if(context.hasOwnProperty(param1))
            {
               context[param1] = param2;
            }
            else if(context.__static__.hasOwnProperty(param1))
            {
               context.__static__[param1] = param2;
            }
            else
            {
               _loc3_ = context.__super__;
               while(_loc3_ != null)
               {
                  if(_loc3_.hasOwnProperty(param1))
                  {
                     _loc3_[param1] = param2;
                     return param2;
                  }
                  _loc3_ = _loc3_.__super__;
               }
               error(Error.EInvalid("assignment"));
            }
         }
         else
         {
            error(Error.EInvalid("assignment"));
         }
         return param2;
      }
   }
}
