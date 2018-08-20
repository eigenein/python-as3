package vm
{
   import flash.Boot;
   import vm.expr.Const;
   
   public final class Token
   {
      
      public static var TBkClose:Token = new Token("TBkClose",12,null);
      
      public static var TBkOpen:Token = new Token("TBkOpen",11,null);
      
      public static var TBrClose:Token = new Token("TBrClose",7,null);
      
      public static var TBrOpen:Token = new Token("TBrOpen",6,null);
      
      public static var TComma:Token = new Token("TComma",9,null);
      
      public static var TDot:Token = new Token("TDot",8,null);
      
      public static var TDoubleDot:Token = new Token("TDoubleDot",14,null);
      
      public static var TEof:Token = new Token("TEof",0,null);
      
      public static var TPClose:Token = new Token("TPClose",5,null);
      
      public static var TPOpen:Token = new Token("TPOpen",4,null);
      
      public static var TQuestion:Token = new Token("TQuestion",13,null);
      
      public static var TSemicolon:Token = new Token("TSemicolon",10,null);
      
      public static var __constructs__:Array = ["TEof","TConst","TId","TOp","TPOpen","TPClose","TBrOpen","TBrClose","TDot","TComma","TSemicolon","TBkOpen","TBkClose","TQuestion","TDoubleDot"];
      
      public static const __isenum:Boolean = true;
       
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function Token(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      public static function TConst(param1:Const) : Token
      {
         return new Token("TConst",1,[param1]);
      }
      
      public static function TId(param1:String) : Token
      {
         return new Token("TId",2,[param1]);
      }
      
      public static function TOp(param1:String) : Token
      {
         return new Token("TOp",3,[param1]);
      }
      
      public final function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}
