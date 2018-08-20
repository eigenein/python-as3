package haxe.io
{
   import flash.Boot;
   
   public final class Error
   {
      
      public static var Blocked:Error = new Error("Blocked",0,null);
      
      public static var OutsideBounds:Error = new Error("OutsideBounds",2,null);
      
      public static var Overflow:Error = new Error("Overflow",1,null);
      
      public static var __constructs__:Array = ["Blocked","Overflow","OutsideBounds","Custom"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function Error(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function Custom(param1:*) : Error
      {
         return new Error("Custom",3,[param1]);
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
