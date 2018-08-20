package vm.expr
{
   import flash.Boot;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EConst extends Expr
   {
       
      
      public var c:Const;
      
      public function EConst(param1:Const = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         c = param1;
      }
      
      override public function resolve() : *
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as String;
         var _loc1_:Const = c;
         switch(_loc1_.index)
         {
            case 0:
               _loc2_ = _loc1_.params[0];
               return _loc2_;
            case 1:
               _loc3_ = _loc1_.params[0];
               return _loc3_;
            case 2:
               _loc4_ = _loc1_.params[0];
               return _loc4_;
         }
      }
      
      override public function print() : String
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as String;
         var _loc1_:Const = c;
         switch(_loc1_.index)
         {
            case 0:
               _loc2_ = _loc1_.params[0];
               return _loc2_;
            case 1:
               _loc3_ = _loc1_.params[0];
               return _loc3_;
            case 2:
               _loc4_ = _loc1_.params[0];
               if(_loc4_ == null)
               {
                  return "null";
               }
               return "\"" + _loc4_ + "\"";
         }
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as String;
         var _loc6_:* = null as Bytes;
         _loc2_ = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:Const = c;
         switch(_loc3_.index)
         {
            case 0:
               _loc2_ = _loc3_.params[0];
               param1.output.writeByte(_loc3_.index);
               param1.output.writeInt32(_loc2_);
               break;
            case 1:
               _loc4_ = _loc3_.params[0];
               param1.output.writeByte(_loc3_.index);
               param1.output.writeDouble(_loc4_);
               break;
            case 2:
               _loc5_ = _loc3_.params[0];
               param1.output.writeByte(_loc3_.index);
               if(_loc5_ != null)
               {
                  _loc6_ = Bytes.ofString(_loc5_);
                  param1.output.writeUInt16(_loc6_.length);
                  param1.output.write(_loc6_);
                  break;
               }
               param1.output.writeUInt16(0);
               break;
         }
      }
   }
}
