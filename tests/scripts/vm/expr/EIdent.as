package vm.expr
{
   import flash.Boot;
   import haxe.IMap;
   import haxe.ds.StringMap;
   import haxe.io.Bytes;
   import vm.ByteCode;
   import vm.InterpreterCore;
   
   public class EIdent extends Assignable
   {
      
      public static var idents:IMap = new StringMap();
      
      public static var s:String = "";
      
      public static var v:String = "";
      
      public static var count:int = 0;
       
      
      public var id:String;
      
      public function EIdent(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         id = param1;
      }
      
      public static function create(param1:String) : EIdent
      {
         var _loc2_:* = null as StringMap;
         _loc2_ = EIdent.idents;
         if(param1 in StringMap.reserved?Boolean(_loc2_.existsReserved(param1)):param1 in _loc2_.h)
         {
            _loc2_ = EIdent.idents;
            return param1 in StringMap.reserved?_loc2_.getReserved(param1):_loc2_.h[param1];
         }
         var _loc3_:EIdent = new EIdent(param1);
         _loc2_ = EIdent.idents;
         if(param1 in StringMap.reserved)
         {
            _loc2_.setReserved(param1,_loc3_);
         }
         else
         {
            _loc2_.h[param1] = _loc3_;
         }
         EIdent.count = EIdent.count + 1;
         if(param1.charAt(0) == param1.charAt(0).toUpperCase())
         {
            EIdent.s = EIdent.s + (param1 + " ");
         }
         else
         {
            EIdent.v = EIdent.v + (param1 + " ");
         }
         return _loc3_;
      }
      
      override public function reverseAssign(param1:AOp) : *
      {
         return Expr.context.assignIdent(id,param1.resolveAssignment(Expr.context.resolve(id)));
      }
      
      override public function resolve() : *
      {
         return Expr.context.resolve(id);
      }
      
      override public function print() : String
      {
         return id;
      }
      
      override public function increment(param1:Boolean, param2:int) : *
      {
         var _loc3_:* = null;
         if(param1)
         {
            return Expr.context.assignIdent(id,Expr.context.resolve(id) + param2);
         }
         _loc3_ = Expr.context.resolve(id);
         Expr.context.assignIdent(id,_loc3_ + param2);
         return _loc3_;
      }
      
      override public function encode(param1:ByteCode) : void
      {
         var _loc4_:* = null as Bytes;
         var _loc2_:int = InterpreterCore.typeIndex(this);
         param1.output.writeByte(_loc2_);
         var _loc3_:String = id;
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
         return Expr.context.assignIdent(id,param1.resolve());
      }
   }
}
