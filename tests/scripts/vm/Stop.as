package vm
{
   import flash.Boot;
   
   public final class Stop
   {
      
      public static var SBreak:Stop = new Stop("SBreak",0,null);
      
      public static var SContinue:Stop = new Stop("SContinue",1,null);
      
      public static var __constructs__:Array = ["SBreak","SContinue","SReturn"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function Stop(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function SReturn(param1:*) : Stop
      {
         return new Stop("SReturn",2,[param1]);
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
