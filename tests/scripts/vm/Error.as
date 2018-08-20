package vm
{
   import flash.Boot;
   
   public final class Error
   {
      
      public static var EInvalidParam:Error = new Error("EInvalidParam",14,null);
      
      public static var EUnterminatedComment:Error = new Error("EUnterminatedComment",5,null);
      
      public static var EUnterminatedString:Error = new Error("EUnterminatedString",4,null);
      
      public static var __constructs__:Array = ["EInvalidChar","EUnexpected","EExpected","EInvalidAssignment","EUnterminatedString","EUnterminatedComment","EUnknownVariable","EInvalidIterator","EInvalidOp","EInvalidAccess","EUpperCasePackage","ELowerCaseClass","EClassRedefined","EVarRedefined","EInvalidParam","EInvalid","EScriptThrow","EStop","EInvalidImport"];
      
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
      
      public static function EClassRedefined(param1:String) : Error
      {
         return new Error("EClassRedefined",12,[param1]);
      }
      
      public static function EExpected(param1:String) : Error
      {
         return new Error("EExpected",2,[param1]);
      }
      
      public static function EInvalid(param1:String) : Error
      {
         return new Error("EInvalid",15,[param1]);
      }
      
      public static function EInvalidAccess(param1:String) : Error
      {
         return new Error("EInvalidAccess",9,[param1]);
      }
      
      public static function EInvalidAssignment(param1:String) : Error
      {
         return new Error("EInvalidAssignment",3,[param1]);
      }
      
      public static function EInvalidChar(param1:int) : Error
      {
         return new Error("EInvalidChar",0,[param1]);
      }
      
      public static function EInvalidImport(param1:String) : Error
      {
         return new Error("EInvalidImport",18,[param1]);
      }
      
      public static function EInvalidIterator(param1:String) : Error
      {
         return new Error("EInvalidIterator",7,[param1]);
      }
      
      public static function EInvalidOp(param1:String) : Error
      {
         return new Error("EInvalidOp",8,[param1]);
      }
      
      public static function ELowerCaseClass(param1:String) : Error
      {
         return new Error("ELowerCaseClass",11,[param1]);
      }
      
      public static function EScriptThrow(param1:*) : Error
      {
         return new Error("EScriptThrow",16,[param1]);
      }
      
      public static function EStop(param1:String) : Error
      {
         return new Error("EStop",17,[param1]);
      }
      
      public static function EUnexpected(param1:String) : Error
      {
         return new Error("EUnexpected",1,[param1]);
      }
      
      public static function EUnknownVariable(param1:String) : Error
      {
         return new Error("EUnknownVariable",6,[param1]);
      }
      
      public static function EUpperCasePackage(param1:String) : Error
      {
         return new Error("EUpperCasePackage",10,[param1]);
      }
      
      public static function EVarRedefined(param1:String) : Error
      {
         return new Error("EVarRedefined",13,[param1]);
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
