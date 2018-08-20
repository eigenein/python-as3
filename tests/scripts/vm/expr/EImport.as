package vm.expr
{
   import flash.Boot;
   import haxe.io.BytesOutput;
   
   public class EImport extends EClassLevel
   {
       
      
      public var v:String;
      
      public function EImport(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         v = param1;
      }
      
      override public function writeHeader(param1:BytesOutput) : void
      {
         param1.writeByte(v.length);
         param1.writeString(v);
      }
      
      override public function resolve() : *
      {
         var _loc1_:Array = v.split(".");
         var _loc2_:Class = Type.resolveClass(v);
         if(_loc2_ != null)
         {
            Expr.context.env.h[_loc1_[int(_loc1_.length) - 1]] = _loc2_;
         }
         return null;
      }
      
      override public function importCounter() : int
      {
         return 1;
      }
   }
}
