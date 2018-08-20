package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EField extends Assignable
   {
       
      
      public var f:String;
      
      public var e:Expr;
      
      public function EField(param1:Expr = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         e = param1;
         f = param2;
      }
      
      override public function reverseAssign(param1:AOp) : *
      {
         var _loc2_:* = e.resolve();
         var _loc3_:String = f;
         var _loc5_:String = f;
         var _loc6_:* = _loc2_[_loc5_];
         var _loc4_:* = param1.resolveAssignment(_loc6_ != null || _loc2_.hasOwnProperty(_loc5_)?_loc6_:!!_loc2_.hasOwnProperty("__super__")?_loc2_.__super__[_loc5_]:null);
         if(_loc2_ == null)
         {
            error(vm.Error.EInvalidAccess(_loc3_));
         }
         if(_loc2_.hasOwnProperty(_loc3_))
         {
            _loc2_[_loc3_] = _loc4_;
         }
         else if(_loc2_.hasOwnProperty("__super__"))
         {
            _loc2_.__super__[_loc3_] = _loc4_;
         }
         return _loc4_;
      }
      
      override public function resolve() : *
      {
         var _loc1_:* = e.resolve();
         var _loc2_:String = f;
         var _loc3_:* = _loc1_[_loc2_];
         if(_loc3_ != null || _loc1_.hasOwnProperty(_loc2_))
         {
            return _loc3_;
         }
         if(_loc1_.hasOwnProperty("__super__"))
         {
            return _loc1_.__super__[_loc2_];
         }
         return null;
      }
      
      override public function print() : String
      {
         return e.print() + "." + f;
      }
      
      override public function increment(param1:Boolean, param2:int) : *
      {
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc6_:* = null;
         var _loc3_:* = e.resolve();
         _loc5_ = f;
         _loc6_ = _loc3_[_loc5_];
         if(_loc6_ != null || _loc3_.hasOwnProperty(_loc5_))
         {
            _loc4_ = _loc6_;
         }
         else if(_loc3_.hasOwnProperty("__super__"))
         {
            _loc4_ = _loc3_.__super__[_loc5_];
         }
         else
         {
            _loc4_ = null;
         }
         if(param1)
         {
            _loc4_ = _loc4_ + param2;
            _loc5_ = f;
            if(_loc3_ == null)
            {
               error(vm.Error.EInvalidAccess(_loc5_));
            }
            if(_loc3_.hasOwnProperty(_loc5_))
            {
               _loc3_[_loc5_] = _loc4_;
            }
            else if(_loc3_.hasOwnProperty("__super__"))
            {
               _loc3_.__super__[_loc5_] = _loc4_;
            }
            _loc4_;
         }
         else
         {
            _loc5_ = f;
            _loc6_ = _loc4_ + param2;
            if(_loc3_ == null)
            {
               error(vm.Error.EInvalidAccess(_loc5_));
            }
            if(_loc3_.hasOwnProperty(_loc5_))
            {
               _loc3_[_loc5_] = _loc6_;
            }
            else if(_loc3_.hasOwnProperty("__super__"))
            {
               _loc3_.__super__[_loc5_] = _loc6_;
            }
            _loc6_;
         }
         return _loc4_;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         e.encode(param1);
         var _loc3_:String = f;
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
      }
      
      override public function assign(param1:*) : *
      {
         var _loc2_:Expr = param1;
         var _loc3_:* = e.resolve();
         var _loc4_:String = f;
         var _loc5_:* = _loc2_.resolve();
         if(_loc3_ == null)
         {
            error(vm.Error.EInvalidAccess(_loc4_));
         }
         if(_loc3_.hasOwnProperty(_loc4_))
         {
            _loc3_[_loc4_] = _loc5_;
         }
         else if(_loc3_.hasOwnProperty("__super__"))
         {
            _loc3_.__super__[_loc4_] = _loc5_;
         }
         return _loc5_;
      }
   }
}
