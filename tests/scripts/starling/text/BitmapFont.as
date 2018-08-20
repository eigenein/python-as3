package starling.text
{
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.textures.Texture;
   import starling.utils.cleanMasterString;
   
   public class BitmapFont
   {
      
      public static const NATIVE_SIZE:int = -1;
      
      public static const MINI:String = "mini";
      
      private static const CHAR_SPACE:int = 32;
      
      private static const CHAR_TAB:int = 9;
      
      private static const CHAR_NEWLINE:int = 10;
      
      private static const CHAR_CARRIAGE_RETURN:int = 13;
      
      private static var sLines:Array = [];
       
      
      private var mTexture:Texture;
      
      private var mChars:Dictionary;
      
      private var mName:String;
      
      private var mSize:Number;
      
      private var mLineHeight:Number;
      
      private var mBaseline:Number;
      
      private var mOffsetX:Number;
      
      private var mOffsetY:Number;
      
      private var mHelperImage:Image;
      
      public function BitmapFont(param1:Texture = null, param2:XML = null)
      {
         super();
         if(param1 == null && param2 == null)
         {
            param1 = MiniBitmapFont.texture;
            param2 = MiniBitmapFont.xml;
         }
         mName = "unknown";
         mBaseline = 14;
         mSize = 14;
         mLineHeight = 14;
         mOffsetY = 0;
         mOffsetX = 0;
         mTexture = param1;
         mChars = new Dictionary();
         mHelperImage = new Image(param1);
         if(param2)
         {
            parseFontXml(param2);
         }
      }
      
      public function dispose() : void
      {
         if(mTexture)
         {
            mTexture.dispose();
         }
      }
      
      private function parseFontXml(param1:XML) : void
      {
         var _loc14_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc15_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc16_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:Number = mTexture.scale;
         var _loc17_:Rectangle = mTexture.frame;
         var _loc7_:Number = !!_loc17_?_loc17_.x:0;
         var _loc9_:Number = !!_loc17_?_loc17_.y:0;
         mName = cleanMasterString(param1.info.@face);
         mSize = parseFloat(param1.info.@size) / _loc6_;
         mLineHeight = parseFloat(param1.common.@lineHeight) / _loc6_;
         mBaseline = parseFloat(param1.common.@base) / _loc6_;
         if(param1.info.@smooth.toString() == "0")
         {
            smoothing = "none";
         }
         if(mSize <= 0)
         {
            mSize = mSize == 0?16:Number(mSize * -1);
         }
         var _loc19_:int = 0;
         var _loc18_:* = param1.chars.char;
         for each(var _loc11_ in param1.chars.char)
         {
            _loc14_ = parseInt(_loc11_.@id);
            _loc4_ = parseFloat(_loc11_.@xoffset) / _loc6_;
            _loc2_ = parseFloat(_loc11_.@yoffset) / _loc6_;
            _loc13_ = parseFloat(_loc11_.@xadvance) / _loc6_;
            _loc15_ = new Rectangle();
            _loc15_.x = parseFloat(_loc11_.@x) / _loc6_ + _loc7_;
            _loc15_.y = parseFloat(_loc11_.@y) / _loc6_ + _loc9_;
            _loc15_.width = parseFloat(_loc11_.@width) / _loc6_;
            _loc15_.height = parseFloat(_loc11_.@height) / _loc6_;
            _loc5_ = Texture.fromTexture(mTexture,_loc15_);
            _loc8_ = new BitmapChar(_loc14_,_loc5_,_loc4_,_loc2_,_loc13_);
            addChar(_loc14_,_loc8_);
         }
         var _loc21_:int = 0;
         var _loc20_:* = param1.kernings.kerning;
         for each(var _loc12_ in param1.kernings.kerning)
         {
            _loc16_ = parseInt(_loc12_.@first);
            _loc10_ = parseInt(_loc12_.@second);
            _loc3_ = parseFloat(_loc12_.@amount) / _loc6_;
            if(_loc10_ in mChars)
            {
               getChar(_loc10_).addKerning(_loc16_,_loc3_);
            }
         }
      }
      
      public function getChar(param1:int) : BitmapChar
      {
         return mChars[param1];
      }
      
      public function addChar(param1:int, param2:BitmapChar) : void
      {
         mChars[param1] = param2;
      }
      
      public function getCharIDs(param1:Vector.<int> = null) : Vector.<int>
      {
         if(param1 == null)
         {
            param1 = new Vector.<int>(0);
         }
         var _loc4_:int = 0;
         var _loc3_:* = mChars;
         for(param1[param1.length] in mChars)
         {
         }
         return param1;
      }
      
      public function hasChars(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         var _loc4_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.charCodeAt(_loc3_);
            if(_loc2_ != 32 && _loc2_ != 9 && _loc2_ != 10 && _loc2_ != 13 && mChars[_loc2_] == undefined)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function createSprite(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:uint = 16777215, param6:String = "center", param7:String = "center", param8:Boolean = true, param9:Boolean = true) : Sprite
      {
         var _loc11_:int = 0;
         var _loc15_:* = null;
         var _loc14_:* = null;
         var _loc10_:Vector.<CharLocation> = arrangeChars(param1,param2,param3,param4,param6,param7,param8,param9);
         var _loc12_:int = _loc10_.length;
         var _loc13_:Sprite = new Sprite();
         _loc11_ = 0;
         while(_loc11_ < _loc12_)
         {
            _loc15_ = _loc10_[_loc11_];
            _loc14_ = _loc15_.char.createImage();
            _loc14_.x = _loc15_.x;
            _loc14_.y = _loc15_.y;
            var _loc16_:* = _loc15_.scale;
            _loc14_.scaleY = _loc16_;
            _loc14_.scaleX = _loc16_;
            _loc14_.color = param5;
            _loc13_.addChild(_loc14_);
            _loc11_++;
         }
         CharLocation#1612.rechargePool();
         return _loc13_;
      }
      
      public function fillQuadBatch(param1:QuadBatch, param2:Number, param3:Number, param4:String, param5:Number = -1, param6:uint = 16777215, param7:String = "center", param8:String = "center", param9:Boolean = true, param10:Boolean = true) : void
      {
         var _loc12_:int = 0;
         var _loc14_:* = null;
         var _loc11_:Vector.<CharLocation> = arrangeChars(param2,param3,param4,param5,param7,param8,param9,param10);
         var _loc13_:int = _loc11_.length;
         mHelperImage.color = param6;
         _loc12_ = 0;
         while(_loc12_ < _loc13_)
         {
            _loc14_ = _loc11_[_loc12_];
            mHelperImage.texture = _loc14_.char.texture;
            mHelperImage.readjustSize();
            mHelperImage.x = _loc14_.x;
            mHelperImage.y = _loc14_.y;
            var _loc15_:* = _loc14_.scale;
            mHelperImage.scaleY = _loc15_;
            mHelperImage.scaleX = _loc15_;
            param1.addImage(mHelperImage);
            _loc12_++;
         }
         CharLocation#1612.rechargePool();
      }
      
      private function arrangeChars(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:String = "center", param6:String = "center", param7:Boolean = true, param8:Boolean = true) : Vector.<CharLocation#1612>
      {
         var _loc35_:* = null;
         var _loc28_:int = 0;
         var _loc20_:* = 0;
         var _loc33_:* = 0;
         var _loc32_:* = NaN;
         var _loc14_:* = NaN;
         var _loc16_:* = undefined;
         var _loc24_:int = 0;
         var _loc30_:Boolean = false;
         var _loc21_:int = 0;
         var _loc34_:* = null;
         var _loc29_:int = 0;
         var _loc25_:int = 0;
         var _loc13_:int = 0;
         var _loc11_:* = undefined;
         var _loc18_:int = 0;
         var _loc23_:* = null;
         var _loc27_:Number = NaN;
         var _loc19_:int = 0;
         if(param3 == null || param3.length == 0)
         {
            return CharLocation#1612.vectorFromPool();
         }
         if(param4 < 0)
         {
            param4 = param4 * -mSize;
         }
         var _loc26_:Boolean = false;
         var _loc15_:* = 0;
         var _loc31_:* = 0;
         var _loc12_:* = 0;
         while(!_loc26_)
         {
            sLines.length = 0;
            _loc12_ = Number(param4 / mSize);
            _loc15_ = Number(param1 / _loc12_);
            _loc31_ = Number(param2 / _loc12_);
            if(mLineHeight <= _loc31_)
            {
               _loc20_ = -1;
               _loc33_ = -1;
               _loc32_ = 0;
               _loc14_ = 0;
               _loc16_ = CharLocation#1612.vectorFromPool();
               _loc28_ = param3.length;
               _loc24_ = 0;
               for(; _loc24_ < _loc28_; _loc24_++)
               {
                  _loc30_ = false;
                  _loc21_ = param3.charCodeAt(_loc24_);
                  _loc34_ = getChar(_loc21_);
                  if(_loc21_ == 10 || _loc21_ == 13)
                  {
                     _loc30_ = true;
                  }
                  else if(_loc34_ == null)
                  {
                     trace("[Starling] Missing character: " + _loc21_ + " : " + String.fromCharCode(_loc21_) + " in font " + name + " from string `" + param3 + "`.");
                  }
                  else
                  {
                     if(_loc21_ == 32 || _loc21_ == 9)
                     {
                        _loc20_ = _loc24_;
                     }
                     if(param8)
                     {
                        _loc32_ = Number(_loc32_ + _loc34_.getKerning(_loc33_));
                     }
                     _loc35_ = CharLocation#1612.instanceFromPool(_loc34_);
                     _loc35_.x = _loc32_ + _loc34_.xOffset;
                     _loc35_.y = _loc14_ + _loc34_.yOffset;
                     _loc16_[_loc16_.length] = _loc35_;
                     _loc32_ = Number(_loc32_ + _loc34_.xAdvance);
                     _loc33_ = _loc21_;
                     if(_loc35_.x + _loc34_.width > _loc15_)
                     {
                        if(!(param7 && _loc20_ == -1))
                        {
                           _loc29_ = _loc20_ == -1?1:Number(_loc24_ - _loc20_);
                           _loc25_ = _loc16_.length - _loc29_;
                           _loc16_.splice(_loc25_,_loc29_);
                           if(_loc16_.length != 0)
                           {
                              _loc24_ = _loc24_ - _loc29_;
                              _loc30_ = true;
                           }
                           break;
                        }
                        break;
                     }
                  }
                  if(_loc24_ == _loc28_ - 1)
                  {
                     sLines[sLines.length] = _loc16_;
                     _loc26_ = true;
                  }
                  else if(_loc30_)
                  {
                     sLines[sLines.length] = _loc16_;
                     if(_loc20_ == _loc24_)
                     {
                        _loc16_.pop();
                     }
                     if(_loc14_ + 2 * mLineHeight <= _loc31_)
                     {
                        _loc16_ = CharLocation#1612.vectorFromPool();
                        _loc32_ = 0;
                        _loc14_ = Number(_loc14_ + mLineHeight);
                        _loc20_ = -1;
                        _loc33_ = -1;
                        continue;
                     }
                     break;
                  }
               }
            }
            if(param7 && !_loc26_ && param4 > 3)
            {
               param4 = param4 - 1;
            }
            else
            {
               _loc26_ = true;
            }
         }
         var _loc17_:Vector.<CharLocation> = CharLocation#1612.vectorFromPool();
         var _loc10_:int = sLines.length;
         var _loc22_:Number = _loc14_ + mLineHeight;
         var _loc9_:int = 0;
         if(param6 == "bottom")
         {
            _loc9_ = _loc31_ - _loc22_;
         }
         else if(param6 == "center")
         {
            _loc9_ = (_loc31_ - _loc22_) / 2;
         }
         _loc13_ = 0;
         while(_loc13_ < _loc10_)
         {
            _loc11_ = sLines[_loc13_];
            _loc28_ = _loc11_.length;
            if(_loc28_ != 0)
            {
               _loc18_ = 0;
               _loc23_ = _loc11_[_loc11_.length - 1];
               _loc27_ = _loc23_.x - _loc23_.char.xOffset + _loc23_.char.xAdvance;
               if(param5 == "right")
               {
                  _loc18_ = _loc15_ - _loc27_;
               }
               else if(param5 == "center")
               {
                  _loc18_ = (_loc15_ - _loc27_) / 2;
               }
               _loc19_ = 0;
               while(_loc19_ < _loc28_)
               {
                  _loc35_ = _loc11_[_loc19_];
                  _loc35_.x = _loc12_ * (_loc35_.x + _loc18_ + mOffsetX);
                  _loc35_.y = _loc12_ * (_loc35_.y + _loc9_ + mOffsetY);
                  _loc35_.scale = _loc12_;
                  if(_loc35_.char.width > 0 && _loc35_.char.height > 0)
                  {
                     _loc17_[_loc17_.length] = _loc35_;
                  }
                  _loc19_++;
               }
            }
            _loc13_++;
         }
         return _loc17_;
      }
      
      public function get name() : String
      {
         return mName;
      }
      
      public function get size() : Number
      {
         return mSize;
      }
      
      public function get lineHeight() : Number
      {
         return mLineHeight;
      }
      
      public function set lineHeight(param1:Number) : void
      {
         mLineHeight = param1;
      }
      
      public function get smoothing() : String
      {
         return mHelperImage.smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         mHelperImage.smoothing = param1;
      }
      
      public function get baseline() : Number
      {
         return mBaseline;
      }
      
      public function set baseline(param1:Number) : void
      {
         mBaseline = param1;
      }
      
      public function get offsetX() : Number
      {
         return mOffsetX;
      }
      
      public function set offsetX(param1:Number) : void
      {
         mOffsetX = param1;
      }
      
      public function get offsetY() : Number
      {
         return mOffsetY;
      }
      
      public function set offsetY(param1:Number) : void
      {
         mOffsetY = param1;
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
   }
}

import starling.text.BitmapChar;

class CharLocation#1612
{
   
   private static var sInstancePool:Vector.<CharLocation#1612> = new Vector.<CharLocation#1612>(0);
   
   private static var sVectorPool:Array = [];
   
   private static var sInstanceLoan:Vector.<CharLocation#1612> = new Vector.<CharLocation#1612>(0);
   
   private static var sVectorLoan:Array = [];
    
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   function CharLocation#1612(param1:BitmapChar)
   {
      super();
      reset(param1);
   }
   
   public static function instanceFromPool(param1:BitmapChar) : CharLocation#1612
   {
      var _loc2_:CharLocation = sInstancePool.length > 0?sInstancePool.pop():new CharLocation#1612(param1);
      _loc2_.reset(param1);
      sInstanceLoan[sInstanceLoan.length] = _loc2_;
      return _loc2_;
   }
   
   public static function vectorFromPool() : Vector.<CharLocation#1612>
   {
      var _loc1_:Vector.<CharLocation> = sVectorPool.length > 0?sVectorPool.pop():new Vector.<CharLocation#1612>(0);
      _loc1_.length = 0;
      sVectorLoan[sVectorLoan.length] = _loc1_;
      return _loc1_;
   }
   
   public static function rechargePool() : void
   {
      var _loc1_:* = null;
      var _loc2_:* = undefined;
      while(sInstanceLoan.length > 0)
      {
         _loc1_ = sInstanceLoan.pop();
         _loc1_.char = null;
         sInstancePool[sInstancePool.length] = _loc1_;
      }
      while(sVectorLoan.length > 0)
      {
         _loc2_ = sVectorLoan.pop();
         _loc2_.length = 0;
         sVectorPool[sVectorPool.length] = _loc2_;
      }
   }
   
   private function reset(param1:BitmapChar) : CharLocation#1612
   {
      this.char = param1;
      return this;
   }
}
