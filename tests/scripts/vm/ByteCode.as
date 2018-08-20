package vm
{
   import haxe.io.Bytes;
   import haxe.io.BytesInput;
   import haxe.io.BytesOutput;
   import vm.expr.Const;
   import vm.expr.EArray;
   import vm.expr.EArrayDecl;
   import vm.expr.EBinop;
   import vm.expr.EBlock;
   import vm.expr.EBreak;
   import vm.expr.ECall;
   import vm.expr.EClass;
   import vm.expr.EClassIdent;
   import vm.expr.EConst;
   import vm.expr.EContinue;
   import vm.expr.EField;
   import vm.expr.EFieldCall;
   import vm.expr.EFor;
   import vm.expr.EFunction;
   import vm.expr.EIdent;
   import vm.expr.EIf;
   import vm.expr.ELine;
   import vm.expr.ENew;
   import vm.expr.EObject;
   import vm.expr.EParent;
   import vm.expr.EReturn;
   import vm.expr.ETernary;
   import vm.expr.EThrow;
   import vm.expr.ETry;
   import vm.expr.EUnop;
   import vm.expr.EVar;
   import vm.expr.EWhile;
   import vm.expr.Expr;
   
   public class ByteCode
   {
       
      
      public var output:BytesOutput;
      
      public var input:BytesInput;
      
      public function ByteCode()
      {
      }
      
      public static function encode(param1:EClass) : Bytes
      {
         var _loc2_:ByteCode = new ByteCode();
         _loc2_.encodeClass(param1);
         return _loc2_.output.getBytes();
      }
      
      public static function decode(param1:Bytes) : EClass
      {
         var _loc2_:ByteCode = new ByteCode();
         return _loc2_.decodeClass(param1);
      }
      
      public function writeUInt16(param1:int) : void
      {
         output.writeUInt16(param1);
      }
      
      public function writeString(param1:String) : void
      {
         var _loc2_:* = null as Bytes;
         if(param1 != null)
         {
            _loc2_ = Bytes.ofString(param1);
            output.writeUInt16(_loc2_.length);
            output.write(_loc2_);
         }
         else
         {
            output.writeUInt16(0);
         }
      }
      
      public function writeConst(param1:Const) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as String;
         var _loc5_:* = null as Bytes;
         switch(param1.index)
         {
            case 0:
               _loc2_ = param1.params[0];
               output.writeByte(param1.index);
               output.writeInt32(_loc2_);
               break;
            case 1:
               _loc3_ = param1.params[0];
               output.writeByte(param1.index);
               output.writeDouble(_loc3_);
               break;
            case 2:
               _loc4_ = param1.params[0];
               output.writeByte(param1.index);
               if(_loc4_ != null)
               {
                  _loc5_ = Bytes.ofString(_loc4_);
                  output.writeUInt16(_loc5_.length);
                  output.write(_loc5_);
                  break;
               }
               output.writeUInt16(0);
               break;
         }
      }
      
      public function writeByte(param1:int) : void
      {
         output.writeByte(param1);
      }
      
      public function encodeClass(param1:EClass) : void
      {
         output = new BytesOutput();
         output.set_bigEndian(true);
         param1.encode(this);
      }
      
      public function doDecodeString() : String
      {
         var _loc1_:int = input.readUInt16();
         if(_loc1_ == 0)
         {
            return "";
         }
         return input.readString(_loc1_);
      }
      
      public function doDecodeConst() : Const
      {
         var _loc1_:int = input.readByte();
         switch(_loc1_)
         {
            case 0:
               return Const.CInt(int(input.readInt32()));
            case 1:
               return Const.CFloat(Number(input.readDouble()));
            case 2:
               return Const.CString(doDecodeString());
         }
      }
      
      public function doDecode() : Expr
      {
         var _loc2_:* = null as String;
         var _loc3_:* = null as Array;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null as Expr;
         var _loc8_:* = false;
         var _loc9_:* = null as Expr;
         var _loc1_:int = input.readByte();
         switch(_loc1_)
         {
            default:
            default:
            default:
               throw "Invalid code " + _loc1_;
            case 3:
               _loc2_ = doDecodeString();
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc3_.push(doDecodeString());
               }
               _loc7_ = doDecode();
               return new EFunction(_loc2_ == ""?null:_loc2_,_loc3_,_loc7_);
            case 4:
               return new EReturn(doDecode());
            case 5:
               _loc7_ = doDecode();
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc3_.push(doDecode());
               }
               return new ECall(_loc7_,_loc3_);
            case 6:
               return new EConst(doDecodeConst());
            case 7:
               _loc2_ = doDecodeString();
               return new EVar(_loc2_,doDecode());
            case 8:
               return EIdent.create(doDecodeString());
            case 9:
               return new EClassIdent(doDecodeString());
            case 10:
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc2_ = doDecodeString();
                  _loc7_ = doDecode();
                  _loc3_.push({
                     "name":_loc2_,
                     "e":_loc7_
                  });
               }
               return new EObject(_loc3_);
            case 11:
               return new EParent(doDecode());
            case 12:
               _loc7_ = doDecode();
               return new EField(_loc7_,doDecodeString());
            case 13:
               _loc4_ = input.readUInt16();
               _loc3_ = [];
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc5_++;
                  _loc6_ = _loc5_;
                  _loc3_.push(doDecode());
               }
               return new EBlock(_loc3_);
            case 14:
               _loc2_ = doDecodeString();
               _loc7_ = doDecode();
               return EBinop.create(_loc2_,_loc7_,doDecode());
            case 15:
               _loc2_ = doDecodeString();
               _loc8_ = int(input.readByte()) != 0;
               return EUnop.create(_loc2_,_loc8_,doDecode());
            case 16:
               _loc7_ = doDecode();
               _loc9_ = doDecode();
               return new EIf(_loc7_,_loc9_,doDecode());
            case 17:
               _loc7_ = doDecode();
               _loc9_ = doDecode();
               return new ETernary(_loc7_,_loc9_,doDecode());
            case 18:
               _loc7_ = doDecode();
               return new EWhile(_loc7_,doDecode());
            case 19:
               _loc2_ = doDecodeString();
               _loc7_ = doDecode();
               return new EFor(_loc2_,_loc7_,doDecode());
            case 20:
               return new EBreak();
            case 21:
               return new EContinue();
            case 22:
               _loc7_ = doDecode();
               return new EArray(_loc7_,doDecode());
            case 23:
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc3_.push(doDecode());
               }
               return new EArrayDecl(_loc3_);
            case 24:
               _loc2_ = doDecodeString();
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc3_.push(doDecode());
               }
               return new ENew(_loc2_,_loc3_);
            case 25:
               return new EThrow(doDecode());
            case 26:
               _loc7_ = doDecode();
               _loc2_ = doDecodeString();
               return new ETry(_loc7_,_loc2_,doDecode());
            case 27:
               return new ELine(Type.enumParameters(doDecodeConst())[0]);
            case 28:
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
               _loc7_ = doDecode();
               _loc2_ = doDecodeString();
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = input.readByte();
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc3_.push(doDecode());
               }
               return new EFieldCall(_loc7_,_loc2_,_loc3_);
            case 255:
               return null;
         }
      }
      
      public function decodeClass(param1:Bytes) : EClass
      {
         var _loc8_:int = 0;
         input = new BytesInput(param1);
         input.set_bigEndian(true);
         var _loc2_:String = doDecodeString();
         var _loc3_:String = doDecodeString();
         var _loc4_:String = doDecodeString();
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         var _loc7_:int = input.readUInt16();
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc5_.push(doDecode());
         }
         var _loc9_:Array = [];
         _loc6_ = 0;
         _loc7_ = input.readUInt16();
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc9_.push(doDecode());
         }
         var _loc10_:Array = [];
         _loc6_ = 0;
         _loc7_ = input.readUInt16();
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc10_.push(doDecode());
         }
         var _loc11_:Array = [];
         _loc6_ = 0;
         _loc7_ = input.readUInt16();
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc11_.push(doDecode());
         }
         return new EClass(_loc2_,_loc3_,_loc4_,_loc5_,_loc9_,_loc10_,_loc11_);
      }
   }
}
