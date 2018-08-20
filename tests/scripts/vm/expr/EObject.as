package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EObject extends Expr
   {
       
      
      public var fl:Array;
      
      public function EObject(param1:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         fl = param1;
      }
      
      override public function resolve() : *
      {
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc6_:* = null;
         var _loc1_:* = {};
         var _loc2_:int = 0;
         var _loc3_:Array = fl;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc5_ = _loc4_.name;
            _loc6_ = _loc4_.e.resolve();
            if(_loc1_ == null)
            {
               error(vm.Error.EInvalidAccess(_loc5_));
            }
            if(_loc1_.hasOwnProperty(_loc5_))
            {
               _loc1_[_loc5_] = _loc6_;
            }
            else if(_loc1_.hasOwnProperty("__super__"))
            {
               _loc1_.__super__[_loc5_] = _loc6_;
            }
            _loc6_;
         }
         return _loc1_;
      }
      
      override public function isBlock() : Boolean
      {
         return true;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc6_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         param1.output.writeByte(int(fl.length));
         _loc2_ = 0;
         var _loc3_:Array = fl;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            _loc2_++;
            _loc5_ = _loc4_.name;
            if(_loc5_ != null)
            {
               _loc6_ = Bytes.ofString(_loc5_);
               param1.output.writeUInt16(_loc6_.length);
               param1.output.write(_loc6_);
            }
            else
            {
               param1.output.writeUInt16(0);
            }
            _loc4_.e.encode(param1);
         }
      }
   }
}
