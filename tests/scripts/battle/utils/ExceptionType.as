package battle.utils
{
   import flash.Boot;
   
   public final class ExceptionType
   {
      
      public static var ArgumentError:ExceptionType = new ExceptionType("ArgumentError",0,null);
      
      public static var LogicalError:ExceptionType = new ExceptionType("LogicalError",1,null);
      
      public static var __constructs__:Array = ["ArgumentError","LogicalError"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function ExceptionType(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
