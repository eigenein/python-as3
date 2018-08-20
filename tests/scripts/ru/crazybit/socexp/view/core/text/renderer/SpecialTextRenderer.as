package ru.crazybit.socexp.view.core.text.renderer
{
   import feathers.core.FeathersControl;
   import feathers.core.ITextRenderer;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import ru.crazybit.socexp.view.core.text.ColorChar;
   import ru.crazybit.socexp.view.core.text.FormatChar;
   import ru.crazybit.socexp.view.core.text.IFormatterChar;
   import ru.crazybit.socexp.view.core.text.NoColorChar;
   import ru.crazybit.socexp.view.core.text.ShiftChar;
   import ru.crazybit.socexp.view.core.text.SpecialBitmapFontTextFormat;
   import ru.crazybit.socexp.view.core.text.SpecialCharData;
   import ru.crazybit.socexp.view.core.text.TextureChar;
   import starling.core.RenderSupport;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.text.BitmapChar;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   
   public class SpecialTextRenderer extends FeathersControl implements ITextRenderer
   {
      
      private static var HELPER_IMAGE:Image;
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private static const CHARACTER_ID_SPACE:int = 32;
      
      private static const CHARACTER_ID_TAB:int = 9;
      
      private static const CHARACTER_ID_LINE_FEED:int = 10;
      
      private static const CHARACTER_ID_CARRIAGE_RETURN:int = 13;
      
      private static var CHARACTER_BUFFER:Vector.<CharLocation#3233>;
      
      private static var CHAR_LOCATION_POOL:Vector.<CharLocation#3233>;
      
      private static var COLOR_CHAR_BUFFER:Vector.<ColorChar>;
      
      private static const FUZZY_MAX_WIDTH_PADDING:Number = 1.0E-6;
       
      
      private const _delimiter:String = "^";
      
      private var _specialCharacterData:SpecialCharData;
      
      private var _parsedText:String;
      
      protected var customTextFormat:SpecialBitmapFontTextFormat;
      
      protected const _hash:Dictionary = new Dictionary();
      
      protected var _batchX:Number = 0;
      
      protected var currentTextFormat:SpecialBitmapFontTextFormat;
      
      protected var _textFormat:SpecialBitmapFontTextFormat;
      
      protected var _disabledTextFormat:SpecialBitmapFontTextFormat;
      
      protected var _text:String = null;
      
      protected var _smoothing:String = "bilinear";
      
      protected var _wordWrap:Boolean = false;
      
      private var _lineHeight:Number = NaN;
      
      protected var _snapToPixels:Boolean = true;
      
      protected var _truncationText:String = "...";
      
      private var _useTruncation:Boolean = true;
      
      protected var _useSeparateBatch:Boolean = true;
      
      public function SpecialTextRenderer()
      {
         super();
         if(!CHAR_LOCATION_POOL)
         {
            CHAR_LOCATION_POOL = new Vector.<CharLocation#3233>(0);
         }
         if(!CHARACTER_BUFFER)
         {
            CHARACTER_BUFFER = new Vector.<CharLocation#3233>(0);
         }
         if(!COLOR_CHAR_BUFFER)
         {
            COLOR_CHAR_BUFFER = new Vector.<ColorChar>();
         }
         this.isQuickHitAreaEnabled = true;
      }
      
      private function parse() : void
      {
         var _loc4_:* = 0;
         var _loc6_:* = null;
         if(!_text)
         {
            return;
         }
         var _loc2_:Array = _text.split("^");
         _parsedText = "";
         _specialCharacterData = new SpecialCharData();
         var _loc1_:Boolean = true;
         var _loc5_:uint = 0;
         var _loc3_:uint = _loc2_.length;
         _loc4_ = uint(0);
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc4_];
            if(SpecialCharData.isSpecialFormat(_loc6_))
            {
               _specialCharacterData.addSpecialChar(_loc6_,_loc5_);
               _loc1_ = true;
            }
            else
            {
               if(_loc1_)
               {
                  _loc1_ = false;
               }
               else
               {
                  _parsedText = _parsedText + "^";
               }
               _parsedText = _parsedText + _loc6_;
               _loc5_ = _loc5_ + _loc6_.length;
            }
            _loc4_++;
         }
         if(!_parsedText.length)
         {
            _parsedText = null;
         }
      }
      
      private function addFormat(param1:IFormatterChar) : void
      {
         if(!customTextFormat)
         {
            customTextFormat = new SpecialBitmapFontTextFormat(currentTextFormat.font,currentTextFormat.size,currentTextFormat.color,currentTextFormat.align);
         }
         customTextFormat.colorAdd = currentTextFormat.colorAdd;
         customTextFormat.addPriority = currentTextFormat.addPriority;
         customTextFormat.outline = currentTextFormat.outline;
         param1.processFormat(customTextFormat);
      }
      
      public function get labelBatch() : QuadBatch
      {
         return new QuadBatch();
      }
      
      public function get textFormat() : SpecialBitmapFontTextFormat
      {
         return this._textFormat;
      }
      
      public function set textFormat(param1:SpecialBitmapFontTextFormat) : void
      {
         if(this._textFormat == param1)
         {
            return;
         }
         this._textFormat = param1;
         this.invalidate("styles");
      }
      
      public function get disabledTextFormat() : SpecialBitmapFontTextFormat
      {
         return this._disabledTextFormat;
      }
      
      public function set disabledTextFormat(param1:SpecialBitmapFontTextFormat) : void
      {
         if(this._disabledTextFormat == param1)
         {
            return;
         }
         this._disabledTextFormat = param1;
         this.invalidate("styles");
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this._parsedText = null;
         this.invalidate("data");
      }
      
      [Inspectable(type="String",enumeration="bilinear,trilinear,none")]
      public function get smoothing() : String
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(this._smoothing == param1)
         {
            return;
         }
         this._smoothing = param1;
         this.invalidate("styles");
      }
      
      public function get wordWrap() : Boolean
      {
         return _wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         if(this._wordWrap == param1)
         {
            return;
         }
         this._wordWrap = param1;
         this.invalidate("styles");
      }
      
      public function get lineHeight() : Number
      {
         return _lineHeight;
      }
      
      public function set lineHeight(param1:Number) : void
      {
         if(_lineHeight == param1 || param1 != param1 && _lineHeight != _lineHeight)
         {
            return;
         }
         _lineHeight = param1;
         invalidate("styles");
      }
      
      public function get snapToPixels() : Boolean
      {
         return _snapToPixels;
      }
      
      public function set snapToPixels(param1:Boolean) : void
      {
         if(this._snapToPixels == param1)
         {
            return;
         }
         this._snapToPixels = param1;
         this.invalidate("styles");
      }
      
      public function get truncationText() : String
      {
         return _truncationText;
      }
      
      public function set truncationText(param1:String) : void
      {
         if(this._truncationText == param1)
         {
            return;
         }
         this._truncationText = param1;
         this.invalidate("data");
      }
      
      public function get useTruncation() : Boolean
      {
         return _useTruncation;
      }
      
      public function set useTruncation(param1:Boolean) : void
      {
         _useTruncation = param1;
         invalidate("data");
      }
      
      public function get useSeparateBatch() : Boolean
      {
         return this._useSeparateBatch;
      }
      
      public function set useSeparateBatch(param1:Boolean) : void
      {
         if(this._useSeparateBatch == param1)
         {
            return;
         }
         this._useSeparateBatch = param1;
         this.invalidate("styles");
      }
      
      public function get baseline() : Number
      {
         if(!this._textFormat)
         {
            return 0;
         }
         var _loc3_:BitmapFont = this._textFormat.font;
         var _loc1_:Number = this._textFormat.size;
         var _loc2_:Number = !!isNaN(_loc1_)?1:Number(_loc1_ / _loc3_.size);
         if(isNaN(_loc3_.baseline))
         {
            return (_lineHeight == _lineHeight?_lineHeight:Number(_loc3_.lineHeight)) * _loc2_;
         }
         return _loc3_.baseline * _loc2_;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(this._snapToPixels)
         {
            this.getTransformationMatrix(this.stage,HELPER_MATRIX);
            _loc3_ = Number(Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx);
            _loc4_ = Number(Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty);
         }
         moveBatches(_loc3_,_loc4_);
         super.render(param1,param2);
      }
      
      private function moveBatches(param1:Number, param2:Number) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _hash;
         for each(var _loc3_ in _hash)
         {
            while(_loc3_.nextFree)
            {
               _loc3_ = _loc3_.nextFree;
            }
            while(_loc3_)
            {
               _loc3_.x = this._batchX + param1;
               _loc3_.y = param2;
               _loc3_ = _loc3_.prevUsed;
            }
         }
      }
      
      public function measureText(param1:Point = null) : Point
      {
         var _loc16_:int = 0;
         var _loc10_:* = NaN;
         var _loc19_:* = 0;
         var _loc23_:* = null;
         var _loc11_:* = null;
         var _loc28_:Number = NaN;
         var _loc5_:* = null;
         var _loc15_:* = null;
         var _loc14_:int = 0;
         var _loc17_:* = null;
         var _loc26_:Boolean = false;
         if(this.isInvalid("styles") || this.isInvalid("state"))
         {
            this.refreshTextFormat();
         }
         if(!_parsedText)
         {
            parse();
         }
         if(!param1)
         {
            param1 = new Point();
         }
         else
         {
            var _loc30_:int = 0;
            param1.y = _loc30_;
            param1.x = _loc30_;
         }
         if(!this.currentTextFormat || !this._parsedText)
         {
            return param1;
         }
         var _loc29_:BitmapFont = this.currentTextFormat.font;
         var _loc18_:Number = this.currentTextFormat.size;
         var _loc21_:Number = this.currentTextFormat.letterSpacing;
         var _loc3_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc8_:Number = !!isNaN(_loc18_)?1:Number(_loc18_ / _loc29_.size);
         var _loc25_:Number = (!isNaN(_lineHeight)?_lineHeight:Number(_loc29_.lineHeight)) * _loc8_;
         var _loc7_:Number = !isNaN(this.explicitWidth)?this.explicitWidth:Number(this._maxWidth);
         var _loc6_:* = 0;
         var _loc22_:* = 0;
         var _loc9_:* = 0;
         var _loc24_:Number = NaN;
         var _loc2_:int = this._parsedText.length;
         var _loc13_:* = 0;
         var _loc12_:* = 0;
         var _loc20_:int = 0;
         var _loc4_:String = "";
         var _loc27_:String = "";
         _loc16_ = 0;
         while(_loc16_ <= _loc2_)
         {
            _loc23_ = _specialCharacterData.getSpecialChars(_loc16_);
            if(_loc23_)
            {
               _loc19_ = uint(0);
               while(_loc19_ < _loc23_.length)
               {
                  _loc11_ = _loc23_[_loc19_];
                  _loc28_ = _loc11_.scale * _loc8_;
                  if(_loc11_.texture && _loc11_.texture.frame)
                  {
                     _loc10_ = Number(_loc11_.texture.frame.width * _loc28_ + _loc11_.dx * _loc28_);
                  }
                  else
                  {
                     _loc10_ = 0;
                  }
                  _loc22_ = Number(_loc22_ + _loc10_);
                  _loc19_++;
               }
            }
            _loc5_ = _specialCharacterData.getFormatChars(_loc16_);
            if(_loc5_)
            {
               _loc19_ = uint(0);
               while(_loc19_ < _loc5_.length)
               {
                  _loc15_ = _loc5_[_loc19_];
                  if(_loc15_ is ShiftChar)
                  {
                     _loc22_ = Number(_loc22_ + (_loc15_ as ShiftChar).shift);
                  }
                  _loc19_++;
               }
            }
            if(_loc16_ != _loc2_)
            {
               _loc14_ = this._parsedText.charCodeAt(_loc16_);
               if(_loc14_ == 10 || _loc14_ == 13)
               {
                  _loc22_ = Number(Math.max(0,_loc22_ - _loc21_));
                  _loc6_ = Number(Math.max(_loc6_,_loc22_));
                  _loc24_ = NaN;
                  _loc22_ = 0;
                  _loc9_ = Number(_loc9_ + _loc25_);
                  _loc13_ = 0;
                  _loc20_ = 0;
                  _loc12_ = 0;
               }
               else
               {
                  _loc17_ = _loc29_.getChar(_loc14_);
                  if(!_loc17_)
                  {
                     trace("Missing character " + String.fromCharCode(_loc14_) + " in font " + _loc29_.name + ".");
                  }
                  else
                  {
                     if(_loc3_ && !isNaN(_loc24_))
                     {
                        _loc22_ = Number(_loc22_ + _loc17_.getKerning(_loc24_) * _loc8_);
                     }
                     _loc10_ = Number(_loc17_.xAdvance * _loc8_);
                     if(this._wordWrap)
                     {
                        _loc26_ = _loc24_ == 32 || _loc24_ == 9;
                        if(_loc14_ == 32 || _loc14_ == 9)
                        {
                           if(!_loc26_)
                           {
                              _loc12_ = 0;
                           }
                           _loc12_ = Number(_loc12_ + _loc10_);
                        }
                        else if(_loc26_)
                        {
                           _loc13_ = _loc22_;
                           _loc20_++;
                           _loc4_ = _loc4_ + _loc27_;
                           _loc27_ = "";
                        }
                        if(_loc20_ > 0 && _loc22_ + _loc10_ > _loc7_ + _loc12_)
                        {
                           _loc6_ = Number(Math.max(_loc6_,_loc13_ - _loc12_));
                           _loc24_ = NaN;
                           _loc22_ = Number(_loc22_ - _loc13_);
                           _loc9_ = Number(_loc9_ + _loc25_);
                           _loc13_ = 0;
                           _loc12_ = 0;
                           _loc20_ = 0;
                           _loc4_ = "";
                        }
                     }
                     _loc22_ = Number(_loc22_ + (_loc10_ + _loc21_));
                     _loc24_ = _loc14_;
                     _loc27_ = _loc27_ + String.fromCharCode(_loc14_);
                  }
               }
               _loc16_++;
               continue;
            }
            break;
         }
         _loc22_ = Number(Math.max(0,_loc22_ - _loc21_));
         _loc6_ = Number(Math.max(_loc6_,_loc22_));
         param1.x = _loc6_;
         param1.y = _loc9_ + _loc29_.lineHeight * _loc8_;
         return param1;
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = this.isInvalid("data");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc2_:Boolean = this.isInvalid("state");
         if(!_parsedText)
         {
            parse();
         }
         if(_loc4_ || _loc2_)
         {
            this.refreshTextFormat();
         }
         if(_loc3_ || _loc4_ || _loc1_)
         {
            updateBatches();
            if(!this.currentTextFormat || !_parsedText)
            {
               this.setSizeInternal(0,0,false);
               return;
            }
            this.layoutCharacters(HELPER_POINT);
            this.setSizeInternal(HELPER_POINT.x,HELPER_POINT.y,false);
         }
      }
      
      protected function updateBatches() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function layoutCharacters(param1:Point = null) : Point
      {
         var _loc34_:* = null;
         var _loc23_:int = 0;
         var _loc32_:* = null;
         var _loc16_:* = null;
         var _loc37_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc26_:* = 0;
         var _loc5_:* = null;
         var _loc10_:* = null;
         var _loc22_:* = null;
         var _loc19_:int = 0;
         var _loc24_:* = null;
         var _loc13_:Number = NaN;
         var _loc36_:Boolean = false;
         var _loc11_:* = null;
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc38_:BitmapFont = this.currentTextFormat.font;
         var _loc25_:Number = this.currentTextFormat.size;
         var _loc29_:Number = this.currentTextFormat.letterSpacing;
         var _loc3_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc8_:Number = !!isNaN(_loc25_)?1:Number(_loc25_ / _loc38_.size);
         var _loc35_:Number = (_lineHeight == _lineHeight?_lineHeight:Number(_loc38_.lineHeight)) * _loc8_;
         var _loc12_:* = !isNaN(this.explicitWidth);
         var _loc27_:* = this.currentTextFormat.align != "left";
         var _loc7_:Number = !!_loc12_?this.explicitWidth:Number(this._maxWidth);
         if(_loc27_ && _loc7_ == Infinity)
         {
            this.measureText(HELPER_POINT);
            _loc7_ = HELPER_POINT.x;
         }
         var _loc15_:String = this.getTruncatedText(_loc7_);
         CHARACTER_BUFFER.length = 0;
         var _loc6_:* = 0;
         var _loc31_:* = 0;
         var _loc9_:* = 0;
         var _loc33_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc18_:* = 0;
         var _loc17_:* = 0;
         var _loc20_:int = 0;
         var _loc28_:int = 0;
         var _loc2_:int = !!_loc15_?_loc15_.length:0;
         customTextFormat = null;
         var _loc30_:int = COLOR_CHAR_BUFFER.length;
         var _loc21_:* = _loc30_;
         _loc23_ = 0;
         while(_loc23_ <= _loc2_)
         {
            _loc32_ = _specialCharacterData.getSpecialChars(_loc23_);
            if(_loc32_)
            {
               _loc26_ = uint(0);
               while(_loc26_ < _loc32_.length)
               {
                  _loc16_ = _loc32_[_loc26_];
                  _loc37_ = _loc8_ * _loc16_.scale;
                  _loc13_ = _loc16_.textureFrameWidth * _loc37_ + _loc16_.dx * _loc37_;
                  if(this._wordWrap)
                  {
                     if(_loc31_ + _loc13_ > _loc7_)
                     {
                        this.alignBuffer(_loc7_,_loc31_,0);
                        this.addBufferToBatch(0);
                        _loc6_ = Number(Math.max(_loc6_,_loc31_));
                        _loc33_ = NaN;
                        _loc31_ = 0;
                        _loc9_ = Number(_loc9_ + _loc35_);
                        _loc18_ = 0;
                        _loc17_ = 0;
                        _loc20_ = 0;
                        _loc28_ = 0;
                     }
                  }
                  _loc14_ = Math.floor((_loc35_ - _loc16_.textureFrameHeight * _loc37_) * 0.5);
                  if(this._wordWrap || _loc27_)
                  {
                     _loc34_ = CHAR_LOCATION_POOL.length > 0?CHAR_LOCATION_POOL.shift():new CharLocation#3233();
                     _loc34_.char = null;
                     _loc34_.x = _loc31_ + _loc16_.dx;
                     _loc34_.scale = _loc37_;
                     _loc34_.y = _loc9_ + _loc14_ + _loc16_.dy;
                     _loc34_.currentColor = _loc10_;
                     _loc34_.textureChar = _loc16_;
                     CHARACTER_BUFFER[CHARACTER_BUFFER.length] = _loc34_;
                     _loc20_++;
                  }
                  else
                  {
                     addTextureToBatch(_loc16_.texture,_loc31_ + _loc16_.dx,_loc9_ + _loc14_ + _loc16_.dy,_loc16_.scale,null,1,Boolean(_loc16_));
                  }
                  _loc31_ = Number(_loc31_ + _loc13_);
                  _loc26_++;
               }
            }
            _loc5_ = _specialCharacterData.getFormatChars(_loc23_);
            if(_loc5_)
            {
               _loc26_ = uint(0);
               while(_loc26_ < _loc5_.length)
               {
                  _loc22_ = _loc5_[_loc26_];
                  addFormat(_loc22_);
                  if(_loc22_ is ShiftChar)
                  {
                     _loc31_ = Number(_loc31_ + customTextFormat.indent);
                  }
                  else if(_loc22_ is NoColorChar)
                  {
                     if(_loc21_ > _loc30_)
                     {
                        _loc21_--;
                        _loc10_ = COLOR_CHAR_BUFFER.pop();
                     }
                     else
                     {
                        _loc10_ = null;
                     }
                  }
                  else if(_loc22_ is ColorChar)
                  {
                     if(_loc10_ != null)
                     {
                        _loc21_++;
                        COLOR_CHAR_BUFFER.push(_loc10_);
                     }
                     _loc10_ = _loc22_ as ColorChar;
                  }
                  _loc26_++;
               }
            }
            if(_loc23_ != _loc2_)
            {
               _loc4_ = false;
               _loc19_ = _loc15_.charCodeAt(_loc23_);
               if(_loc19_ == 10 || _loc19_ == 13)
               {
                  _loc31_ = Number(Math.max(0,_loc31_ - _loc29_));
                  if(this._wordWrap || _loc27_)
                  {
                     this.alignBuffer(_loc7_,_loc31_,0);
                     this.addBufferToBatch(0);
                  }
                  _loc6_ = Number(Math.max(_loc6_,_loc31_));
                  _loc33_ = NaN;
                  _loc31_ = 0;
                  _loc9_ = Number(_loc9_ + _loc35_);
                  _loc18_ = 0;
                  _loc17_ = 0;
                  _loc20_ = 0;
                  _loc28_ = 0;
               }
               else
               {
                  _loc24_ = _loc38_.getChar(_loc19_);
                  if(!_loc24_)
                  {
                     trace("Missing character " + String.fromCharCode(_loc19_) + " in font " + _loc38_.name + ".");
                  }
                  else
                  {
                     if(_loc3_ && !isNaN(_loc33_))
                     {
                        _loc31_ = Number(_loc31_ + _loc24_.getKerning(_loc33_) * _loc8_);
                     }
                     _loc13_ = _loc24_.xAdvance * _loc8_;
                     if(this._wordWrap)
                     {
                        _loc36_ = _loc33_ == 32 || _loc33_ == 9;
                        if(_loc19_ == 32 || _loc19_ == 9)
                        {
                           if(!_loc36_)
                           {
                              _loc17_ = 0;
                           }
                           _loc17_ = Number(_loc17_ + _loc13_);
                        }
                        else if(_loc36_)
                        {
                           _loc18_ = _loc31_;
                           _loc20_ = 0;
                           _loc28_++;
                           _loc4_ = true;
                        }
                        if(_loc4_ && !_loc27_)
                        {
                           this.addBufferToBatch(0);
                        }
                        if(_loc28_ > 0 && _loc31_ + _loc13_ > _loc7_ + _loc17_)
                        {
                           if(_loc27_)
                           {
                              this.trimBuffer(_loc20_);
                              this.alignBuffer(_loc7_,_loc18_ - _loc17_,_loc20_);
                              this.addBufferToBatch(_loc20_);
                           }
                           this.moveBufferedCharacters(-_loc18_,_loc35_,0);
                           _loc6_ = Number(Math.max(_loc6_,_loc18_ - _loc17_));
                           _loc33_ = NaN;
                           _loc31_ = Number(_loc31_ - _loc18_);
                           _loc9_ = Number(_loc9_ + _loc35_);
                           _loc18_ = 0;
                           _loc17_ = 0;
                           _loc20_ = 0;
                           _loc4_ = false;
                           _loc28_ = 0;
                        }
                     }
                     if(this._wordWrap || _loc27_)
                     {
                        _loc34_ = CHAR_LOCATION_POOL.length > 0?CHAR_LOCATION_POOL.shift():new CharLocation#3233();
                        _loc34_.char = _loc24_;
                        _loc34_.x = _loc31_ + _loc24_.xOffset * _loc8_;
                        _loc34_.y = _loc9_ + _loc24_.yOffset * _loc8_;
                        _loc34_.currentColor = _loc10_;
                        _loc34_.scale = _loc8_;
                        CHARACTER_BUFFER[CHARACTER_BUFFER.length] = _loc34_;
                        _loc20_++;
                     }
                     else
                     {
                        this.addTextureToBatch(_loc24_.texture,_loc31_ + _loc24_.xOffset * _loc8_,_loc9_ + _loc24_.yOffset * _loc8_,_loc8_);
                     }
                     _loc31_ = Number(_loc31_ + (_loc13_ + _loc29_));
                     _loc33_ = _loc19_;
                  }
               }
               _loc23_++;
               continue;
            }
            break;
         }
         COLOR_CHAR_BUFFER.length = _loc30_;
         _loc31_ = Number(Math.max(0,_loc31_ - _loc29_));
         if(this._wordWrap || _loc27_)
         {
            this.alignBuffer(_loc7_,_loc31_,0);
            this.addBufferToBatch(0);
         }
         _loc6_ = Number(Math.max(_loc6_,_loc31_));
         if(_loc27_ && !_loc12_)
         {
            _loc11_ = this._textFormat.align;
            if(_loc11_ == "center")
            {
               this._batchX = (_loc6_ - _loc7_) / 2;
            }
            else if(_loc11_ == "right")
            {
               this._batchX = _loc6_ - _loc7_;
            }
         }
         else
         {
            this._batchX = 0;
         }
         moveBatches(0,0);
         param1.x = _loc6_;
         param1.y = _loc9_ + _loc38_.lineHeight * _loc8_;
         return param1;
      }
      
      protected function trimBuffer(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = CHARACTER_BUFFER.length - param1;
         _loc5_ = _loc3_ - 1;
         while(_loc5_ >= 0)
         {
            _loc6_ = CHARACTER_BUFFER[_loc5_];
            if(!_loc6_.textureChar)
            {
               _loc7_ = _loc6_.char;
               _loc4_ = _loc7_.charID;
               if(_loc4_ == 32 || _loc4_ == 9)
               {
                  _loc2_++;
                  _loc5_--;
                  continue;
               }
               break;
            }
            break;
         }
         if(_loc2_ > 0)
         {
            CHARACTER_BUFFER.splice(_loc5_ + 1,_loc2_);
         }
      }
      
      protected function alignBuffer(param1:Number, param2:Number, param3:int) : void
      {
         var _loc4_:String = this.currentTextFormat.align;
         if(_loc4_ == "center")
         {
            this.moveBufferedCharacters(Math.round((param1 - param2) / 2),0,param3);
         }
         else if(_loc4_ == "right")
         {
            this.moveBufferedCharacters(param1 - param2,0,param3);
         }
      }
      
      protected function addBufferToBatch(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = CHARACTER_BUFFER.length - param1;
         var _loc6_:int = CHAR_LOCATION_POOL.length;
         customTextFormat = null;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = CHARACTER_BUFFER.shift();
            if(_loc5_.currentColor)
            {
               addFormat(_loc5_.currentColor);
            }
            _loc3_ = !!_loc5_.char?_loc5_.char.texture:_loc5_.textureChar.texture;
            this.addTextureToBatch(_loc3_,_loc5_.x,_loc5_.y,_loc5_.scale,null,1,Boolean(_loc5_.textureChar));
            _loc5_.char = null;
            _loc5_.textureChar = null;
            CHAR_LOCATION_POOL[_loc6_] = _loc5_;
            _loc6_++;
            _loc4_++;
         }
      }
      
      private function findFormat(param1:int) : Array
      {
         var _loc5_:* = null;
         var _loc9_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = null;
         var _loc3_:Array = _specialCharacterData.getFormatChars(param1);
         var _loc2_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc6_:uint = !!_loc3_?_loc3_.length:0;
         _loc9_ = uint(0);
         while(_loc9_ < _loc6_)
         {
            _loc5_ = _loc3_[_loc9_];
            if(_loc5_ is ColorChar)
            {
               _loc4_ = true;
            }
            _loc9_++;
         }
         var _loc10_:Boolean = false;
         if(!_loc4_ || !_loc2_)
         {
            _loc7_ = param1;
            while(_loc7_ >= 0)
            {
               _loc8_ = _specialCharacterData.getFormatChars(_loc7_);
               _loc6_ = !!_loc8_?_loc8_.length:0;
               _loc9_ = uint(0);
               while(_loc9_ < _loc6_)
               {
                  _loc5_ = _loc8_[_loc9_];
                  if(_loc5_ is ColorChar)
                  {
                     _loc10_ = true;
                  }
                  if(!_loc4_ && _loc10_)
                  {
                     if(!_loc3_)
                     {
                        _loc3_ = [];
                     }
                     if(_loc10_)
                     {
                        _loc4_ = true;
                     }
                     _loc3_.push(_loc5_);
                  }
                  _loc9_++;
               }
               _loc7_--;
            }
         }
         return _loc3_;
      }
      
      protected function moveBufferedCharacters(param1:Number, param2:Number, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = CHARACTER_BUFFER.length - param3;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = CHARACTER_BUFFER[_loc5_];
            _loc6_.x = _loc6_.x + param1;
            _loc6_.y = _loc6_.y + param2;
            _loc5_++;
         }
      }
      
      protected function addTextureToBatch(param1:Texture, param2:Number, param3:Number, param4:Number, param5:RenderSupport = null, param6:Number = 1, param7:Boolean = false) : void
      {
         var _loc8_:* = null;
         if(!HELPER_IMAGE)
         {
            HELPER_IMAGE = new Image(param1);
         }
         else
         {
            HELPER_IMAGE.texture = param1;
            HELPER_IMAGE.readjustSize();
         }
         var _loc9_:* = param4;
         HELPER_IMAGE.scaleY = _loc9_;
         HELPER_IMAGE.scaleX = _loc9_;
         HELPER_IMAGE.x = param2;
         HELPER_IMAGE.y = param3;
         HELPER_IMAGE.color = !!param7?16777215:!!customTextFormat?customTextFormat.color:uint(this.currentTextFormat.color);
         HELPER_IMAGE.smoothing = this._smoothing;
         if(param5)
         {
            param5.pushMatrix();
            param5.transformMatrix(HELPER_IMAGE);
            param5.batchQuad(HELPER_IMAGE,param6,HELPER_IMAGE.texture,this._smoothing);
            param5.popMatrix();
         }
         else
         {
            _loc8_ = _hash[param1.root];
            if(_loc8_ == null || _loc8_.numQuads + 1 > 16383)
            {
               _loc8_ = getNewBatch(_loc8_);
               _hash[param1.root] = _loc8_;
            }
            _loc8_.addImage(HELPER_IMAGE);
         }
      }
      
      protected function refreshTextFormat() : void
      {
         if(!this._isEnabled && this._disabledTextFormat)
         {
            this.currentTextFormat = this._disabledTextFormat;
         }
         else
         {
            this.currentTextFormat = this._textFormat;
         }
      }
      
      protected function getTruncatedText(param1:Number) : String
      {
         var _loc7_:* = 0;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc13_:* = NaN;
         var _loc14_:Number = NaN;
         if(!this._parsedText)
         {
            return "";
         }
         if(param1 == Infinity || !_useTruncation || this._wordWrap || this._parsedText.indexOf(String.fromCharCode(10)) >= 0 || this._parsedText.indexOf(String.fromCharCode(13)) >= 0)
         {
            return this._parsedText;
         }
         var _loc15_:BitmapFont = this.currentTextFormat.font;
         var _loc9_:Number = this.currentTextFormat.size;
         var _loc10_:Number = this.currentTextFormat.letterSpacing;
         var _loc4_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc6_:Number = !!isNaN(_loc9_)?1:Number(_loc9_ / _loc15_.size);
         var _loc11_:* = 0;
         var _loc12_:Number = NaN;
         var _loc2_:int = this._parsedText.length;
         var _loc3_:* = -1;
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc5_ = this._parsedText.charCodeAt(_loc7_);
            _loc8_ = _loc15_.getChar(_loc5_);
            if(_loc8_)
            {
               _loc13_ = 0;
               if(_loc4_ && !isNaN(_loc12_))
               {
                  _loc13_ = Number(_loc8_.getKerning(_loc12_) * _loc6_);
               }
               _loc11_ = Number(_loc11_ + (_loc13_ + _loc8_.xAdvance * _loc6_));
               if(_loc11_ > param1)
               {
                  _loc14_ = Math.abs(_loc11_ - param1);
                  if(_loc14_ > 1.0e-6)
                  {
                     _loc3_ = _loc7_;
                     break;
                  }
               }
               _loc11_ = Number(_loc11_ + _loc10_);
               _loc12_ = _loc5_;
            }
            _loc7_++;
         }
         if(_loc3_ >= 0)
         {
            _loc2_ = this._truncationText.length;
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc5_ = this._truncationText.charCodeAt(_loc7_);
               _loc8_ = _loc15_.getChar(_loc5_);
               if(_loc8_)
               {
                  _loc13_ = 0;
                  if(_loc4_ && !isNaN(_loc12_))
                  {
                     _loc13_ = Number(_loc8_.getKerning(_loc12_) * _loc6_);
                  }
                  _loc11_ = Number(_loc11_ + (_loc13_ + _loc8_.xAdvance * _loc6_ + _loc10_));
                  _loc12_ = _loc5_;
               }
               _loc7_++;
            }
            _loc11_ = Number(_loc11_ - _loc10_);
            _loc7_ = _loc3_;
            while(_loc7_ >= 0)
            {
               _loc5_ = this._parsedText.charCodeAt(_loc7_);
               _loc12_ = _loc7_ > 0?this._parsedText.charCodeAt(_loc7_ - 1):NaN;
               _loc8_ = _loc15_.getChar(_loc5_);
               if(_loc8_)
               {
                  _loc13_ = 0;
                  if(_loc4_ && !isNaN(_loc12_))
                  {
                     _loc13_ = Number(_loc8_.getKerning(_loc12_) * _loc6_);
                  }
                  _loc11_ = Number(_loc11_ - (_loc13_ + _loc8_.xAdvance * _loc6_ + _loc10_));
                  if(_loc11_ <= param1)
                  {
                     return this._parsedText.substr(0,_loc7_) + this._truncationText;
                  }
               }
               _loc7_--;
            }
            return this._truncationText;
         }
         return this._parsedText;
      }
      
      protected function getNewBatch(param1:QuadBatchList) : QuadBatchList
      {
         var _loc2_:* = null;
         if(param1 != null && param1.nextFree != null)
         {
            _loc2_ = param1.nextFree;
         }
         else
         {
            _loc2_ = new QuadBatchList();
            _loc2_.touchable = false;
            addChild(_loc2_);
            if(param1 != null)
            {
               _loc2_.prevUsed = param1;
               param1.nextFree = _loc2_;
            }
         }
         return _loc2_;
      }
   }
}

import ru.crazybit.socexp.view.core.text.ColorChar;
import ru.crazybit.socexp.view.core.text.TextureChar;
import starling.text.BitmapChar;

class CharLocation#3233
{
    
   
   public var currentColor:ColorChar;
   
   public var outline:uint;
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   public var textureChar:TextureChar;
   
   function CharLocation#3233()
   {
      super();
   }
}
