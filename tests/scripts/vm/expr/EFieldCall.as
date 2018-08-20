package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EFieldCall extends ECall
   {
       
      
      public var f:String;
      
      public function EFieldCall(param1:Expr = undefined, param2:String = undefined, param3:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param3);
         f = param2;
      }
      
      override public function resolve() : *
      {
         var _loc5_:* = null as Expr;
         var _loc6_:* = null;
         var _loc1_:* = e.resolve();
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         var _loc4_:Array = params;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            _loc2_.push(_loc5_.resolve());
         }
         var _loc7_:String = f;
         var _loc8_:* = _loc1_[_loc7_];
         if(_loc8_ != null || _loc1_.hasOwnProperty(_loc7_))
         {
            _loc6_ = _loc8_;
         }
         else if(_loc1_.hasOwnProperty("__super__"))
         {
            _loc6_ = _loc1_.__super__[_loc7_];
         }
         else
         {
            _loc6_ = null;
         }
         return _loc6_.apply(_loc1_,_loc2_);
      }
      
      override public function print() : String
      {
         var _loc5_:* = null as Expr;
         var _loc1_:String = e.print() + "." + f + "(";
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         var _loc4_:Array = params;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            if(_loc2_)
            {
               _loc1_ = _loc1_ + _loc5_.print();
               _loc2_ = false;
            }
            else
            {
               _loc1_ = _loc1_ + (", " + _loc5_.print());
            }
         }
         return _loc1_ + ")";
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc6_:* = null as Expr;
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
         param1.output.writeByte(int(params.length));
         _loc2_ = 0;
         var _loc5_:Array = params;
         while(_loc2_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc2_];
            _loc2_++;
            _loc6_.encode(param1);
         }
      }
   }
}
