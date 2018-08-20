package vm
{
   import flash.Boot;
   
   public class VirtualClass
   {
       
      
      public var varsProto;
      
      public var superName:String;
      
      public var sVarsProto;
      
      public var sVars;
      
      public var sFunsProto;
      
      public var interp:InterpreterCore;
      
      public var funsProto;
      
      public var fileName:String;
      
      public var className:String;
      
      public function VirtualClass(param1:InterpreterCore = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         interp = param1;
         varsProto = {};
         sVarsProto = {};
         funsProto = {};
         sFunsProto = {};
         sVars = {};
         sVars.__proto__ = this;
      }
      
      public function initialize() : void
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc1_:* = interp.context;
         interp.context = sVars;
         var _loc2_:Array = Reflect.fields(sFunsProto);
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            _loc5_ = sFunsProto[_loc4_].bind(sVars);
            sVars[_loc4_] = _loc5_;
         }
         _loc2_ = Reflect.fields(sVarsProto);
         _loc3_ = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            if(sVarsProto[_loc4_] != null)
            {
               _loc5_ = sVarsProto[_loc4_].resolve();
               sVars[_loc4_] = _loc5_;
            }
            else
            {
               sVars[_loc4_] = null;
            }
         }
         interp.context = _loc1_;
      }
      
      public function createInstance(param1:Array, param2:Boolean = true, param3:* = undefined) : *
      {
         var _loc8_:* = null as String;
         var _loc9_:* = null;
         var _loc4_:* = {};
         _loc4_.__proto__ = this;
         _loc4_.__static__ = sVars;
         if(superName != null && superName != "")
         {
            _loc4_.__super__ = interp.createEmptyInstance(superName,_loc4_);
         }
         else
         {
            _loc4_.__super__ = null;
         }
         var _loc5_:* = interp.context;
         interp.context = _loc4_;
         if(param3 == null)
         {
            param3 = _loc4_;
         }
         var _loc6_:Array = Reflect.fields(funsProto);
         var _loc7_:int = 0;
         while(_loc7_ < int(_loc6_.length))
         {
            _loc8_ = _loc6_[_loc7_];
            _loc7_++;
            _loc9_ = funsProto[_loc8_].bind(param3);
            _loc4_[_loc8_] = _loc9_;
         }
         _loc6_ = Reflect.fields(varsProto);
         _loc7_ = 0;
         while(_loc7_ < int(_loc6_.length))
         {
            _loc8_ = _loc6_[_loc7_];
            _loc7_++;
            if(varsProto[_loc8_] != null)
            {
               _loc9_ = varsProto[_loc8_].resolve();
               _loc4_[_loc8_] = _loc9_;
            }
            else
            {
               _loc4_[_loc8_] = null;
            }
         }
         if(!!param2 && _loc4_.hasOwnProperty("new"))
         {
            _loc4_["new"].apply(null,param1);
         }
         interp.context = _loc5_;
         return _loc4_;
      }
      
      public function callStatic(param1:String, param2:Array) : *
      {
         return sVars[param1].apply(null,param2);
      }
   }
}
