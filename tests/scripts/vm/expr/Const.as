package vm.expr
{
   import flash.Boot;
   
   public final class Const
   {
      
      public static var __constructs__:Array = ["CInt","CFloat","CString"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function Const(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function CFloat(param1:Number) : Const
      {
         return new Const("CFloat",1,[param1]);
      }
      
      public static function CInt(param1:int) : Const
      {
         return new Const("CInt",0,[param1]);
      }
      
      public static function CString(param1:String) : Const
      {
         return new Const("CString",2,[param1]);
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
