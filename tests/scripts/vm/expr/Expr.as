package vm.expr
{
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class Expr
   {
      
      public static var context:InterpreterCore;
       
      
      public function Expr()
      {
      }
      
      public static function creationError(param1:vm.Error) : void
      {
         Expr.context.error(param1);
      }
      
      public function get s() : String
      {
         return print();
      }
      
      public function set(param1:*, param2:String, param3:*) : *
      {
         if(param1 == null)
         {
            error(vm.Error.EInvalidAccess(param2));
         }
         if(param1.hasOwnProperty(param2))
         {
            param1[param2] = param3;
         }
         else if(param1.hasOwnProperty("__super__"))
         {
            param1.__super__[param2] = param3;
         }
         return param3;
      }
      
      public function reverseAssign(param1:AOp) : *
      {
         error(vm.Error.EInvalidOp("reverseAssign"));
         return null;
      }
      
      public function resolve() : *
      {
         return null;
      }
      
      public function print() : String
      {
         return "#";
      }
      
      public function isBlock() : Boolean
      {
         return false;
      }
      
      public function get(param1:*, param2:String) : *
      {
         var _loc3_:* = param1[param2];
         if(_loc3_ != null || param1.hasOwnProperty(param2))
         {
            return _loc3_;
         }
         if(param1.hasOwnProperty("__super__"))
         {
            return param1.__super__[param2];
         }
         return null;
      }
      
      public function error(param1:vm.Error) : void
      {
         Expr.context.error(param1);
      }
      
      public function encodeType(param1:ByteCode) : void
      {
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
      }
      
      public function encode(param1:ByteCode) : void
      {
      }
      
      public function decode(param1:ByteCode) : void
      {
      }
      
      public function assign(param1:*) : *
      {
         error(vm.Error.EInvalidOp("="));
         return null;
      }
   }
}
