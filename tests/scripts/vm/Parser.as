package vm
{
   import flash.Boot;
   import haxe.IMap;
   import haxe.ds.GenericCell_vm_Token;
   import haxe.ds.GenericStack_vm_Token;
   import haxe.ds.StringMap;
   import haxe.io.Bytes;
   import haxe.io.BytesInput;
   import haxe.io.BytesOutput;
   import haxe.io.Input;
   import vm.expr.Const;
   import vm.expr.EArray;
   import vm.expr.EArrayDecl;
   import vm.expr.EBinop;
   import vm.expr.EBlock;
   import vm.expr.EBreak;
   import vm.expr.ECall;
   import vm.expr.EClass;
   import vm.expr.EClassIdent;
   import vm.expr.EClassLevel;
   import vm.expr.EConst;
   import vm.expr.EContinue;
   import vm.expr.EField;
   import vm.expr.EFieldCall;
   import vm.expr.EFor;
   import vm.expr.EFunction;
   import vm.expr.EIdent;
   import vm.expr.EIf;
   import vm.expr.EImport;
   import vm.expr.ELine;
   import vm.expr.ENew;
   import vm.expr.EObject;
   import vm.expr.EPackage;
   import vm.expr.EParameter;
   import vm.expr.EParent;
   import vm.expr.EReturn;
   import vm.expr.ESuperCall;
   import vm.expr.ETernary;
   import vm.expr.EThrow;
   import vm.expr.ETry;
   import vm.expr.EUnop;
   import vm.expr.EVar;
   import vm.expr.EWhile;
   import vm.expr.Expr;
   
   public class Parser
   {
       
      
      public var unops:IMap;
      
      public var tokens:GenericStack_vm_Token;
      
      public var pre:PreParser;
      
      public var paths:Array;
      
      public var packageName:String;
      
      public var ops:Array;
      
      public var opRightAssoc:IMap;
      
      public var opPriority:IMap;
      
      public var opChars:String;
      
      public var localCls:IMap;
      
      public var line:int;
      
      public var input:Input;
      
      public var ignoredKeywords:Array;
      
      public var idents:Array;
      
      public var identChars:String;
      
      public var globalCls:IMap;
      
      public var fileName:String;
      
      public var fileCls:IMap;
      
      public var char:int;
      
      public var blockLine:int;
      
      public var allCls:IMap;
      
      public function Parser()
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as Array;
         var _loc7_:* = null as String;
         var _loc8_:* = null as StringMap;
         var _loc9_:Boolean = false;
         if(Boot.skip_constructor)
         {
            return;
         }
         paths = [];
         allCls = new StringMap();
         globalCls = new StringMap();
         fileCls = new StringMap();
         opChars = "+*/-=!><&|^%~";
         identChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
         ignoredKeywords = ["untyped","cast"];
         var _loc1_:Array = [["%"],["*","/"],["+","-"],["<<",">>",">>>"],["|","&","^"],["==","!=",">","<",">=","<="],["..."],["&&"],["||"],["=","+=","-=","*=","/=","%=","<<=",">>=",">>>=","|=","&=","^="]];
         opPriority = new StringMap();
         opRightAssoc = new StringMap();
         unops = new StringMap();
         var _loc2_:int = 0;
         var _loc3_:int = _loc1_.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            _loc5_ = 0;
            _loc6_ = _loc1_[_loc4_];
            while(_loc5_ < int(_loc6_.length))
            {
               _loc7_ = _loc6_[_loc5_];
               _loc5_++;
               _loc8_ = opPriority;
               if(_loc7_ in StringMap.reserved)
               {
                  _loc8_.setReserved(_loc7_,_loc4_);
               }
               else
               {
                  _loc8_.h[_loc7_] = _loc4_;
               }
               if(_loc4_ == 9)
               {
                  _loc8_ = opRightAssoc;
                  if(_loc7_ in StringMap.reserved)
                  {
                     _loc8_.setReserved(_loc7_,true);
                  }
                  else
                  {
                     _loc8_.h[_loc7_] = true;
                  }
               }
            }
         }
         _loc2_ = 0;
         _loc6_ = ["!","++","--","-","~"];
         while(_loc2_ < int(_loc6_.length))
         {
            _loc7_ = _loc6_[_loc2_];
            _loc2_++;
            _loc8_ = unops;
            _loc9_ = _loc7_ == "++" || _loc7_ == "--";
            if(_loc7_ in StringMap.reserved)
            {
               _loc8_.setReserved(_loc7_,_loc9_);
            }
            else
            {
               _loc8_.h[_loc7_] = _loc9_;
            }
         }
         ops = [];
         idents = [];
         _loc2_ = 0;
         _loc3_ = opChars.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            ops[opChars.charCodeAt(_loc4_)] = true;
         }
         _loc2_ = 0;
         _loc3_ = identChars.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            idents[identChars.charCodeAt(_loc4_)] = true;
         }
         pre = new PreParser();
      }
      
      public function tokenString(param1:Token) : String
      {
         var _loc2_:* = null as Const;
         var _loc3_:* = null as String;
         switch(param1.index)
         {
            case 0:
               return "<eof>";
            case 1:
               _loc2_ = param1.params[0];
               return constString(_loc2_);
            case 2:
               _loc3_ = param1.params[0];
               return _loc3_;
            case 3:
               _loc3_ = param1.params[0];
               return _loc3_;
            case 4:
               return "(";
            case 5:
               return ")";
            case 6:
               return "{";
            case 7:
               return "}";
            case 8:
               return ".";
            case 9:
               return ",";
            case 10:
               return ";";
            case 11:
               return "[";
            case 12:
               return "]";
            case 13:
               return "?";
            case 14:
               return ":";
         }
      }
      
      public function tokenComment(param1:String, param2:int) : Token
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function token() : Token
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function startWithUpperCase(param1:String) : Boolean
      {
         return param1.substr(0,1).toUpperCase() == param1.substr(0,1);
      }
      
      public function readString(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:BytesOutput = new BytesOutput();
         var _loc5_:Boolean = false;
         var _loc6_:int = line;
         var _loc7_:Input = input;
         try
         {
            _loc3_ = _loc7_.readByte();
         }
         catch(_loc8_:*)
         {
            line = _loc6_;
            error(Error.EUnterminatedString);
         }
         if(_loc5_)
         {
            _loc5_ = false;
            switch(_loc3_)
            {
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
                  error(Error.EInvalidChar(_loc3_));
                  addr73:
                  _loc3_ = _loc7_.readByte();
               case 34:
               default:
               default:
               default:
               default:
               case 39:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               case 92:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
               default:
                  _loc4_.writeByte(_loc3_);
                  §§goto(addr73);
               case 110:
               default:
               default:
               default:
                  _loc4_.writeByte(_loc3_);
                  §§goto(addr73);
               case 114:
               default:
                  _loc4_.writeByte(13);
                  §§goto(addr73);
               case 116:
                  _loc4_.writeByte(9);
                  §§goto(addr73);
            }
            _loc4_.writeByte(10);
            §§goto(addr73);
         }
         else
         {
            if(_loc3_ == 92)
            {
               _loc5_ = true;
               §§goto(addr73);
            }
            addr85:
            if(_loc3_ == 10)
            {
               line = line + 1;
            }
            _loc4_.writeByte(_loc3_);
            §§goto(addr73);
         }
         if(_loc3_ != param1)
         {
            §§goto(addr85);
         }
         return _loc4_.getBytes().toString();
      }
      
      public function readChar() : int
      {
         try
         {
            return int(input.readByte());
         }
         catch(_loc2_:*)
         {
            return 0;
         }
      }
      
      public function parseType() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function parseStructure(param1:String) : Expr
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function parseString(param1:String, param2:String, param3:Array) : Array
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function parseObject(param1:int) : Expr
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function parseFullExpr() : Expr
      {
         var _loc3_:* = null as GenericStack_vm_Token;
         var _loc1_:Expr = parseExpr();
         var _loc2_:Token = token();
         if(_loc2_ != Token.TSemicolon && _loc2_ != Token.TEof)
         {
            if(_loc1_.isBlock())
            {
               _loc3_ = tokens;
               _loc3_.head = new GenericCell_vm_Token(_loc2_,_loc3_.head);
            }
            else
            {
               error(Error.EUnexpected(tokenString(_loc2_)));
            }
         }
         return _loc1_;
      }
      
      public function parseExprNext(param1:Expr) : Expr
      {
         var _loc2_:* = null as GenericStack_vm_Token;
         var _loc4_:* = null as String;
         var _loc5_:* = null as StringMap;
         var _loc6_:* = null as String;
         var _loc7_:* = null as Array;
         var _loc8_:* = null as Array;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as String;
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc13_:* = null as EField;
         var _loc14_:* = null as Expr;
         var _loc15_:* = null as Expr;
         if(param1 is EClass)
         {
            _loc2_ = tokens;
            _loc2_.head = new GenericCell_vm_Token(Token.TSemicolon,_loc2_.head);
            return param1;
         }
         var _loc3_:Token = token();
         switch(_loc3_.index)
         {
            default:
            default:
            default:
               _loc2_ = tokens;
               _loc2_.head = new GenericCell_vm_Token(_loc3_,_loc2_.head);
               return param1;
            case 3:
               _loc4_ = _loc3_.params[0];
               _loc5_ = unops;
               if(_loc4_ in StringMap.reserved?_loc5_.getReserved(_loc4_):_loc5_.h[_loc4_])
               {
                  if(param1.isBlock() || param1 is EParent)
                  {
                     _loc2_ = tokens;
                     _loc2_.head = new GenericCell_vm_Token(_loc3_,_loc2_.head);
                     return param1;
                  }
                  return parseExprNext(EUnop.create(_loc4_,false,param1));
               }
               return makeBinop(_loc4_,param1,parseExpr());
            case 4:
            default:
            default:
            default:
               if(param1 is EIdent && param1.id == "super")
               {
                  return parseExprNext(new ESuperCall(parseExprList(Token.TPClose)));
               }
               if(param1 is EField)
               {
                  _loc13_ = param1;
                  return parseExprNext(new EFieldCall(_loc13_.e,_loc13_.f,parseExprList(Token.TPClose)));
               }
               return parseExprNext(new ECall(param1,parseExprList(Token.TPClose)));
            case 8:
            default:
            default:
               _loc3_ = token();
               _loc4_ = null;
               switch(_loc3_.index)
               {
                  default:
                  default:
                     error(Error.EUnexpected(tokenString(_loc3_)));
                     break;
                  case 2:
                     _loc6_ = _loc3_.params[0];
                     _loc4_ = _loc6_;
               }
               if(param1 is EIdent)
               {
                  _loc7_ = [];
                  _loc7_.push(param1.id);
                  _loc7_.push(_loc4_);
                  _loc6_ = _loc7_.join(".");
                  _loc5_ = allCls;
                  if(_loc6_ in StringMap.reserved?Boolean(_loc5_.existsReserved(_loc6_)):_loc6_ in _loc5_.h)
                  {
                     return parseExprNext(new EClassIdent(_loc7_.join(".")));
                  }
                  _loc8_ = [];
                  _loc9_ = true;
                  while(_loc9_)
                  {
                     _loc3_ = token();
                     _loc8_.push(_loc3_);
                     switch(_loc3_.index)
                     {
                        default:
                        default:
                        default:
                        default:
                        default:
                        default:
                        default:
                        default:
                           _loc9_ = false;
                           continue;
                        case 8:
                           _loc3_ = token();
                           _loc8_.push(_loc3_);
                           switch(_loc3_.index)
                           {
                              default:
                              default:
                                 error(Error.EUnexpected(tokenString(_loc3_)));
                                 continue;
                              case 2:
                                 _loc6_ = _loc3_.params[0];
                                 _loc7_.push(_loc6_);
                                 _loc10_ = _loc7_.join(".");
                                 _loc5_ = allCls;
                                 if(_loc10_ in StringMap.reserved?Boolean(_loc5_.existsReserved(_loc10_)):_loc10_ in _loc5_.h)
                                 {
                                    return parseExprNext(new EClassIdent(_loc7_.join(".")));
                                 }
                                 continue;
                           }
                     }
                  }
                  _loc11_ = _loc8_.length;
                  _loc12_ = _loc11_ - 1;
                  while(_loc12_ > -1)
                  {
                     _loc2_ = tokens;
                     _loc2_.head = new GenericCell_vm_Token(_loc8_[_loc12_],_loc2_.head);
                     _loc12_--;
                  }
                  return parseExprNext(new EField(param1,_loc4_));
               }
               return parseExprNext(new EField(param1,_loc4_));
            case 11:
            default:
               _loc14_ = parseExpr();
               ensure(Token.TBkClose);
               return parseExprNext(new EArray(param1,_loc14_));
            case 13:
               _loc14_ = parseExpr();
               ensure(Token.TDoubleDot);
               _loc15_ = parseExpr();
               return new ETernary(param1,_loc14_,_loc15_);
         }
      }
      
      public function parseExprList(param1:Token) : Array
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function parseExpr() : Expr
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function makeUnop(param1:String, param2:Expr) : Expr
      {
         var _loc3_:* = null as EBinop;
         var _loc4_:* = null as ETernary;
         if(param2 is EBinop)
         {
            _loc3_ = param2;
            return EBinop.create(_loc3_.op(),makeUnop(param1,_loc3_.a),_loc3_.b);
         }
         if(param2 is ETernary)
         {
            _loc4_ = param2;
            return new ETernary(makeUnop(param1,_loc4_.cond),_loc4_.e1,_loc4_.e2);
         }
         return EUnop.create(param1,true,param2);
      }
      
      public function makeBinop(param1:String, param2:Expr, param3:Expr) : Expr
      {
         var _loc4_:* = null as EBinop;
         var _loc5_:* = null as StringMap;
         var _loc6_:* = null as String;
         var _loc7_:* = null as ETernary;
         if(param3 is EBinop)
         {
            _loc4_ = param3;
            _loc5_ = opPriority;
            _loc6_ = _loc4_.op();
            _loc5_ = opPriority;
            if((param1 in StringMap.reserved?_loc5_.getReserved(param1):_loc5_.h[param1]) <= (_loc6_ in StringMap.reserved?_loc5_.getReserved(_loc6_):_loc5_.h[_loc6_]) && !(param1 in StringMap.reserved?Boolean(_loc5_.existsReserved(param1)):param1 in _loc5_.h))
            {
               return EBinop.create(_loc4_.op(),makeBinop(param1,param2,_loc4_.a),_loc4_.b);
            }
            return EBinop.create(param1,param2,param3);
         }
         if(param3 is ETernary)
         {
            _loc7_ = param3;
            _loc5_ = opRightAssoc;
            if(param1 in StringMap.reserved?Boolean(_loc5_.existsReserved(param1)):param1 in _loc5_.h)
            {
               return EBinop.create(param1,param2,param3);
            }
            return new ETernary(makeBinop(param1,param2,_loc7_.cond),_loc7_.e1,_loc7_.e2);
         }
         return EBinop.create(param1,param2,param3);
      }
      
      public function isLowerCase(param1:String) : Boolean
      {
         return param1.toLowerCase() == param1;
      }
      
      public function error(param1:Error) : void
      {
         throw "File " + fileName + " Line " + line + " : " + Std.string(param1);
      }
      
      public function ensure(param1:Token) : void
      {
         var _loc2_:Token = token();
         if(_loc2_ != param1)
         {
            error(Error.EUnexpected(tokenString(_loc2_)));
         }
      }
      
      public function constString(param1:Const) : String
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as String;
         switch(param1.index)
         {
            case 0:
               _loc2_ = param1.params[0];
               return "" + _loc2_;
            case 1:
               _loc3_ = param1.params[0];
               return "" + _loc3_;
            case 2:
               _loc4_ = param1.params[0];
               return _loc4_;
         }
      }
      
      public function addImports(param1:String, param2:String) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as Array;
         var _loc8_:* = null as String;
         param1 = param1.substring(0,int(param1.lastIndexOf("/")));
         var _loc3_:int = Lambda.indexOf(paths,param1);
         var _loc4_:* = int(Lambda.indexOf(paths,param1)) != -1;
         var _loc5_:String = "";
         if(_loc3_ == -1)
         {
            _loc6_ = 0;
            _loc7_ = paths;
            while(_loc6_ < int(_loc7_.length))
            {
               _loc8_ = _loc7_[_loc6_];
               _loc6_++;
               if(int(param1.indexOf(_loc8_)) != -1)
               {
                  _loc5_ = param1.split(_loc8_ + "/").join("");
                  _loc5_ = _loc5_.split("/").join(".");
                  break;
               }
            }
            addImport(_loc5_ + "." + param2);
         }
      }
      
      public function addImport(param1:String) : void
      {
         var _loc3_:* = null as String;
         var _loc4_:* = null as StringMap;
         var _loc5_:* = null as Array;
         var _loc6_:int = 0;
         var _loc7_:* = null as String;
         var _loc8_:* = null as String;
         var _loc9_:* = null as Class;
         if(Expr.context == null)
         {
            Expr.context = new InterpreterCore();
         }
         var _loc2_:Array = param1.split(".");
         if(int(_loc2_.length) > 1 && _loc3_.substr(0,1).toUpperCase() == _loc3_.substr(0,1))
         {
            _loc2_.pop();
         }
         param1 = _loc2_.join(".");
         _loc4_ = fileCls;
         if(param1 in StringMap.reserved?Boolean(_loc4_.existsReserved(param1)):param1 in _loc4_.h)
         {
            _loc2_.pop();
            _loc3_ = _loc2_.join(".");
            _loc4_ = fileCls;
            _loc5_ = param1 in StringMap.reserved?_loc4_.getReserved(param1):_loc4_.h[param1];
            _loc6_ = 0;
            while(_loc6_ < int(_loc5_.length))
            {
               _loc7_ = _loc5_[_loc6_];
               _loc6_++;
               _loc4_ = localCls;
               _loc8_ = _loc3_ + (_loc3_ == ""?"":".") + _loc7_;
               if(_loc7_ in StringMap.reserved)
               {
                  _loc4_.setReserved(_loc7_,_loc8_);
               }
               else
               {
                  _loc4_.h[_loc7_] = _loc8_;
               }
            }
         }
         else
         {
            _loc9_ = Type.resolveClass(param1);
            if(_loc9_ != null)
            {
               Expr.context.env.h[_loc2_[int(_loc2_.length) - 1]] = _loc9_;
            }
         }
      }
   }
}
