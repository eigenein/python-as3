package vm
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import haxe.io.Bytes;
   import haxe.io.BytesInput;
   import haxe.zip.Uncompress;
   import vm.expr.EClass;
   import vm.expr.Expr;
   
   public class Interpreter
   {
      
      public static var trace = function(param1:Array):void
      {
      };
      
      public static var log = function(param1:String, param2:*):void
      {
      };
      
      public static var useDeflation:Boolean = true;
      
      public static var interpreterReadyCallback:Function;
       
      
      public var parser:Parser;
      
      public var interp:InterpreterCore;
      
      public var classes:Array;
      
      public function Interpreter()
      {
      }
      
      public static function loadFile(param1:String) : void
      {
         var _loc2_:Interpreter = new Interpreter();
         _loc2_.runBytes(param1);
      }
      
      public static function main() : void
      {
         var _loc7_:* = null as Interpreter;
         var _loc1_:String = "runbytes";
         var _loc2_:String = "script.hxc";
         var _loc3_:String = "-flag";
         var _loc4_:String = "flash";
         var _loc5_:String = _loc1_;
         var _loc6_:String = _loc5_;
         if(_loc6_ == "runbytes")
         {
            _loc7_ = new Interpreter();
            _loc7_.runBytes(_loc2_);
            null;
         }
         else
         {
            Interpreter.printUsage();
         }
      }
      
      public static function printUsage() : void
      {
      }
      
      public function runCompressedBytes(param1:Bytes) : void
      {
         if(Interpreter.useDeflation)
         {
            param1 = Uncompress.run(param1);
         }
         runBytesInput(new BytesInput(param1));
      }
      
      public function runBytesInput(param1:BytesInput) : void
      {
         var _loc2_:* = null as InterpreterCore;
         var _loc7_:int = 0;
         var _loc8_:* = null as String;
         var _loc9_:* = null as Array;
         var _loc10_:* = null as Class;
         var _loc11_:int = 0;
         if(Expr.context == null)
         {
            _loc2_ = new InterpreterCore();
            Expr.context = _loc2_;
            interp = _loc2_;
         }
         else
         {
            interp = Expr.context;
         }
         param1.set_bigEndian(true);
         var _loc3_:int = param1.readByte();
         var _loc4_:String = param1.read(_loc3_).toString();
         var _loc5_:int = param1.readUInt16();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc6_++;
            _loc7_ = _loc6_;
            _loc3_ = param1.readByte();
            _loc8_ = param1.read(_loc3_).toString();
            _loc9_ = _loc8_.split(".");
            _loc10_ = Type.resolveClass(_loc8_);
            if(_loc10_ != null)
            {
               Expr.context.env.h[_loc9_[int(_loc9_.length) - 1]] = _loc10_;
            }
         }
         _loc6_ = param1.readUInt16();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc7_++;
            _loc11_ = _loc7_;
            _loc3_ = param1.readByte();
            param1.read(_loc3_).toString();
         }
         classes = [];
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc7_++;
            _loc11_ = _loc7_;
            _loc3_ = param1.readUInt24();
            classes.push(ByteCode.decode(param1.read(_loc3_)));
         }
         interp.loadClasses(classes);
         classes = null;
         if(Interpreter.interpreterReadyCallback != null)
         {
            Interpreter.interpreterReadyCallback(interp);
         }
      }
      
      public function runBytes(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader(new URLRequest(param1));
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.addEventListener("complete",onFlashBytesLoaded);
      }
      
      public function onFlashBytesLoaded(param1:Event) : void
      {
         runCompressedBytes(Bytes.ofData(param1.target.data));
      }
      
      public function loadSourceCode(param1:String, param2:String, param3:Array) : void
      {
         if(interp == null)
         {
            interp = new InterpreterCore();
         }
         parser = new Parser();
         var _loc4_:Array = parser.parseString(param1,param2,param3);
         interp.loadClasses(_loc4_);
      }
      
      public function createInstance(param1:String, param2:Array) : *
      {
         if(interp != null)
         {
            return interp.createInstance(param1,param2);
         }
         return null;
      }
      
      public function callStatic(param1:String, param2:String, param3:Array) : *
      {
         if(interp != null)
         {
            return interp.callStatic(param1,param2,param3);
         }
         return null;
      }
   }
}
