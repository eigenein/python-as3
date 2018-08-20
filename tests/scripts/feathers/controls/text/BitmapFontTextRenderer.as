package feathers.controls.text
{
   import feathers.core.FeathersControl;
   import feathers.core.ITextRenderer;
   import feathers.skins.IStyleProvider;
   import feathers.text.BitmapFontTextFormat;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.core.RenderSupport;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.text.BitmapChar;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   
   public class BitmapFontTextRenderer extends FeathersControl implements ITextRenderer
   {
      
      private static var HELPER_IMAGE:Image;
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private static const CHARACTER_ID_SPACE:int = 32;
      
      private static const CHARACTER_ID_TAB:int = 9;
      
      private static const CHARACTER_ID_LINE_FEED:int = 10;
      
      private static const CHARACTER_ID_CARRIAGE_RETURN:int = 13;
      
      private static var CHARACTER_BUFFER:Vector.<CharLocation#3993>;
      
      private static var CHAR_LOCATION_POOL:Vector.<CharLocation#3993>;
      
      private static const FUZZY_MAX_WIDTH_PADDING:Number = 1.0E-6;
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var _characterBatch:QuadBatch;
      
      protected var _batchX:Number = 0;
      
      protected var currentTextFormat:BitmapFontTextFormat;
      
      protected var _textFormat:BitmapFontTextFormat;
      
      protected var _disabledTextFormat:BitmapFontTextFormat;
      
      protected var _text:String = null;
      
      protected var _smoothing:String = "bilinear";
      
      protected var _wordWrap:Boolean = false;
      
      protected var _snapToPixels:Boolean = true;
      
      protected var _truncateToFit:Boolean = true;
      
      protected var _truncationText:String = "...";
      
      protected var _useSeparateBatch:Boolean = true;
      
      public function BitmapFontTextRenderer()
      {
         super();
         if(!CHAR_LOCATION_POOL)
         {
            CHAR_LOCATION_POOL = new Vector.<CharLocation#3993>(0);
         }
         if(!CHARACTER_BUFFER)
         {
            CHARACTER_BUFFER = new Vector.<CharLocation#3993>(0);
         }
         this.isQuickHitAreaEnabled = true;
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return BitmapFontTextRenderer.globalStyleProvider;
      }
      
      public function get textFormat() : BitmapFontTextFormat
      {
         return this._textFormat;
      }
      
      public function set textFormat(param1:BitmapFontTextFormat) : void
      {
         if(this._textFormat == param1)
         {
            return;
         }
         this._textFormat = param1;
         this.invalidate("styles");
      }
      
      public function get disabledTextFormat() : BitmapFontTextFormat
      {
         return this._disabledTextFormat;
      }
      
      public function set disabledTextFormat(param1:BitmapFontTextFormat) : void
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
      
      public function get truncateToFit() : Boolean
      {
         return _truncateToFit;
      }
      
      public function set truncateToFit(param1:Boolean) : void
      {
         if(this._truncateToFit == param1)
         {
            return;
         }
         this._truncateToFit = param1;
         this.invalidate("data");
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
         var _loc4_:BitmapFont = this._textFormat.font;
         var _loc1_:Number = this._textFormat.size;
         var _loc3_:* = Number(_loc1_ / _loc4_.size);
         if(_loc3_ !== _loc3_)
         {
            _loc3_ = 1;
         }
         var _loc2_:Number = _loc4_.baseline;
         if(_loc2_ !== _loc2_)
         {
            return _loc4_.lineHeight * _loc3_;
         }
         return _loc2_ * _loc3_;
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
         this._characterBatch.x = this._batchX + _loc3_;
         this._characterBatch.y = _loc4_;
         super.render(param1,param2);
      }
      
      public function measureText(param1:Point = null) : Point
      {
         var _loc15_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:* = null;
         var _loc9_:Number = NaN;
         var _loc23_:Boolean = false;
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc13_:* = this.explicitWidth !== this.explicitWidth;
         var _loc10_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc13_ && !_loc10_)
         {
            param1.x = this.explicitWidth;
            param1.y = this.explicitHeight;
            return param1;
         }
         if(this.isInvalid("styles") || this.isInvalid("state"))
         {
            this.refreshTextFormat();
         }
         if(!this.currentTextFormat || this._text === null)
         {
            param1.setTo(0,0);
            return param1;
         }
         var _loc25_:BitmapFont = this.currentTextFormat.font;
         var _loc17_:Number = this.currentTextFormat.size;
         var _loc19_:Number = this.currentTextFormat.letterSpacing;
         var _loc3_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc7_:* = Number(_loc17_ / _loc25_.size);
         if(_loc7_ !== _loc7_)
         {
            _loc7_ = 1;
         }
         var _loc22_:Number = _loc25_.lineHeight * _loc7_;
         var _loc6_:Number = this.explicitWidth;
         if(_loc6_ !== _loc6_)
         {
            _loc6_ = this._maxWidth;
         }
         var _loc5_:* = 0;
         var _loc20_:* = 0;
         var _loc8_:* = 0;
         var _loc21_:Number = NaN;
         var _loc2_:int = this._text.length;
         var _loc12_:* = 0;
         var _loc11_:* = 0;
         var _loc18_:int = 0;
         var _loc4_:String = "";
         var _loc24_:String = "";
         _loc15_ = 0;
         while(_loc15_ < _loc2_)
         {
            _loc14_ = this._text.charCodeAt(_loc15_);
            if(_loc14_ == 10 || _loc14_ == 13)
            {
               _loc20_ = Number(_loc20_ - _loc19_);
               if(_loc20_ < 0)
               {
                  _loc20_ = 0;
               }
               if(_loc5_ < _loc20_)
               {
                  _loc5_ = _loc20_;
               }
               _loc21_ = NaN;
               _loc20_ = 0;
               _loc8_ = Number(_loc8_ + _loc22_);
               _loc12_ = 0;
               _loc18_ = 0;
               _loc11_ = 0;
            }
            else
            {
               _loc16_ = _loc25_.getChar(_loc14_);
               if(_loc16_)
               {
                  if(_loc3_ && _loc21_ === _loc21_)
                  {
                     _loc20_ = Number(_loc20_ + _loc16_.getKerning(_loc21_) * _loc7_);
                  }
                  _loc9_ = _loc16_.xAdvance * _loc7_;
                  if(this._wordWrap)
                  {
                     _loc23_ = _loc21_ == 32 || _loc21_ == 9;
                     if(_loc14_ == 32 || _loc14_ == 9)
                     {
                        if(!_loc23_)
                        {
                           _loc11_ = 0;
                        }
                        _loc11_ = Number(_loc11_ + _loc9_);
                     }
                     else if(_loc23_)
                     {
                        _loc12_ = _loc20_;
                        _loc18_++;
                        _loc4_ = _loc4_ + _loc24_;
                        _loc24_ = "";
                     }
                     if(_loc18_ > 0 && _loc20_ + _loc9_ > _loc6_)
                     {
                        _loc11_ = Number(_loc12_ - _loc11_);
                        if(_loc5_ < _loc11_)
                        {
                           _loc5_ = _loc11_;
                        }
                        _loc21_ = NaN;
                        _loc20_ = Number(_loc20_ - _loc12_);
                        _loc8_ = Number(_loc8_ + _loc22_);
                        _loc12_ = 0;
                        _loc11_ = 0;
                        _loc18_ = 0;
                        _loc4_ = "";
                     }
                  }
                  _loc20_ = Number(_loc20_ + (_loc9_ + _loc19_));
                  _loc21_ = _loc14_;
                  _loc24_ = _loc24_ + String.fromCharCode(_loc14_);
               }
            }
            _loc15_++;
         }
         _loc20_ = Number(_loc20_ - _loc19_);
         if(_loc20_ < 0)
         {
            _loc20_ = 0;
         }
         if(_loc5_ < _loc20_)
         {
            _loc5_ = _loc20_;
         }
         param1.x = _loc5_;
         param1.y = _loc8_ + _loc25_.lineHeight * _loc7_;
         return param1;
      }
      
      override protected function initialize() : void
      {
         if(!this._characterBatch)
         {
            this._characterBatch = new QuadBatch();
            this._characterBatch.touchable = false;
            this.addChild(this._characterBatch);
         }
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = this.isInvalid("data");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc2_:Boolean = this.isInvalid("state");
         if(_loc4_ || _loc2_)
         {
            this.refreshTextFormat();
         }
         if(_loc3_ || _loc4_ || _loc1_ || _loc2_)
         {
            this._characterBatch.batchable = !this._useSeparateBatch;
            this._characterBatch.reset();
            if(!this.currentTextFormat || this._text === null)
            {
               this.setSizeInternal(0,0,false);
               return;
            }
            this.layoutCharacters(HELPER_POINT);
            this.setSizeInternal(HELPER_POINT.x,HELPER_POINT.y,false);
         }
      }
      
      protected function layoutCharacters(param1:Point = null) : Point
      {
         var _loc17_:int = 0;
         var _loc15_:int = 0;
         var _loc18_:* = null;
         var _loc11_:Number = NaN;
         var _loc27_:Boolean = false;
         var _loc25_:* = null;
         var _loc9_:* = null;
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc28_:BitmapFont = this.currentTextFormat.font;
         var _loc19_:Number = this.currentTextFormat.size;
         var _loc22_:Number = this.currentTextFormat.letterSpacing;
         var _loc3_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc7_:* = Number(_loc19_ / _loc28_.size);
         if(_loc7_ !== _loc7_)
         {
            _loc7_ = 1;
         }
         var _loc26_:Number = _loc28_.lineHeight * _loc7_;
         var _loc10_:* = this.explicitWidth === this.explicitWidth;
         var _loc20_:* = this.currentTextFormat.align != "left";
         var _loc6_:Number = !!_loc10_?this.explicitWidth:Number(this._maxWidth);
         if(_loc20_ && _loc6_ == Infinity)
         {
            this.measureText(HELPER_POINT);
            _loc6_ = HELPER_POINT.x;
         }
         var _loc12_:String = this._text;
         if(this._truncateToFit)
         {
            _loc12_ = this.getTruncatedText(_loc6_);
         }
         CHARACTER_BUFFER.length = 0;
         var _loc5_:* = 0;
         var _loc23_:* = 0;
         var _loc8_:* = 0;
         var _loc24_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc14_:* = 0;
         var _loc13_:* = 0;
         var _loc16_:int = 0;
         var _loc21_:int = 0;
         var _loc2_:int = !!_loc12_?_loc12_.length:0;
         _loc17_ = 0;
         while(_loc17_ < _loc2_)
         {
            _loc4_ = false;
            _loc15_ = _loc12_.charCodeAt(_loc17_);
            if(_loc15_ == 10 || _loc15_ == 13)
            {
               _loc23_ = Number(_loc23_ - _loc22_);
               if(_loc23_ < 0)
               {
                  _loc23_ = 0;
               }
               if(this._wordWrap || _loc20_)
               {
                  this.alignBuffer(_loc6_,_loc23_,0);
                  this.addBufferToBatch(0);
               }
               if(_loc5_ < _loc23_)
               {
                  _loc5_ = _loc23_;
               }
               _loc24_ = NaN;
               _loc23_ = 0;
               _loc8_ = Number(_loc8_ + _loc26_);
               _loc14_ = 0;
               _loc13_ = 0;
               _loc16_ = 0;
               _loc21_ = 0;
            }
            else
            {
               _loc18_ = _loc28_.getChar(_loc15_);
               if(!_loc18_)
               {
                  trace("Missing character " + String.fromCharCode(_loc15_) + " in font " + _loc28_.name + ".");
               }
               else
               {
                  if(_loc3_ && _loc24_ === _loc24_)
                  {
                     _loc23_ = Number(_loc23_ + _loc18_.getKerning(_loc24_) * _loc7_);
                  }
                  _loc11_ = _loc18_.xAdvance * _loc7_;
                  if(this._wordWrap)
                  {
                     _loc27_ = _loc24_ == 32 || _loc24_ == 9;
                     if(_loc15_ == 32 || _loc15_ == 9)
                     {
                        if(!_loc27_)
                        {
                           _loc13_ = 0;
                        }
                        _loc13_ = Number(_loc13_ + _loc11_);
                     }
                     else if(_loc27_)
                     {
                        _loc14_ = _loc23_;
                        _loc16_ = 0;
                        _loc21_++;
                        _loc4_ = true;
                     }
                     if(_loc4_ && !_loc20_)
                     {
                        this.addBufferToBatch(0);
                     }
                     if(_loc21_ > 0 && _loc23_ + _loc11_ > _loc6_)
                     {
                        if(_loc20_)
                        {
                           this.trimBuffer(_loc16_);
                           this.alignBuffer(_loc6_,_loc14_ - _loc13_,_loc16_);
                           this.addBufferToBatch(_loc16_);
                        }
                        this.moveBufferedCharacters(-_loc14_,_loc26_,0);
                        _loc13_ = Number(_loc14_ - _loc13_);
                        if(_loc5_ < _loc13_)
                        {
                           _loc5_ = _loc13_;
                        }
                        _loc24_ = NaN;
                        _loc23_ = Number(_loc23_ - _loc14_);
                        _loc8_ = Number(_loc8_ + _loc26_);
                        _loc14_ = 0;
                        _loc13_ = 0;
                        _loc16_ = 0;
                        _loc4_ = false;
                        _loc21_ = 0;
                     }
                  }
                  if(this._wordWrap || _loc20_)
                  {
                     _loc25_ = CHAR_LOCATION_POOL.length > 0?CHAR_LOCATION_POOL.shift():new CharLocation#3993();
                     _loc25_.char = _loc18_;
                     _loc25_.x = _loc23_ + _loc18_.xOffset * _loc7_;
                     _loc25_.y = _loc8_ + _loc18_.yOffset * _loc7_;
                     _loc25_.scale = _loc7_;
                     CHARACTER_BUFFER[CHARACTER_BUFFER.length] = _loc25_;
                     _loc16_++;
                  }
                  else
                  {
                     this.addCharacterToBatch(_loc18_,_loc23_ + _loc18_.xOffset * _loc7_,_loc8_ + _loc18_.yOffset * _loc7_,_loc7_);
                  }
                  _loc23_ = Number(_loc23_ + (_loc11_ + _loc22_));
                  _loc24_ = _loc15_;
               }
            }
            _loc17_++;
         }
         _loc23_ = Number(_loc23_ - _loc22_);
         if(_loc23_ < 0)
         {
            _loc23_ = 0;
         }
         if(this._wordWrap || _loc20_)
         {
            this.alignBuffer(_loc6_,_loc23_,0);
            this.addBufferToBatch(0);
         }
         if(_loc5_ < _loc23_)
         {
            _loc5_ = _loc23_;
         }
         if(_loc20_ && !_loc10_)
         {
            _loc9_ = this._textFormat.align;
            if(_loc9_ == "center")
            {
               this._batchX = (_loc5_ - _loc6_) / 2;
            }
            else if(_loc9_ == "right")
            {
               this._batchX = _loc5_ - _loc6_;
            }
         }
         else
         {
            this._batchX = 0;
         }
         this._characterBatch.x = this._batchX;
         param1.x = _loc5_;
         param1.y = _loc8_ + _loc28_.lineHeight * _loc7_;
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
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = CHARACTER_BUFFER.length - param1;
         var _loc5_:int = CHAR_LOCATION_POOL.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = CHARACTER_BUFFER.shift();
            this.addCharacterToBatch(_loc4_.char,_loc4_.x,_loc4_.y,_loc4_.scale);
            _loc4_.char = null;
            CHAR_LOCATION_POOL[_loc5_] = _loc4_;
            _loc5_++;
            _loc3_++;
         }
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
      
      protected function addCharacterToBatch(param1:BitmapChar, param2:Number, param3:Number, param4:Number, param5:RenderSupport = null, param6:Number = 1) : void
      {
         if(!HELPER_IMAGE)
         {
            HELPER_IMAGE = new Image(param1.texture);
         }
         else
         {
            HELPER_IMAGE.texture = param1.texture;
            HELPER_IMAGE.readjustSize();
         }
         var _loc7_:* = param4;
         HELPER_IMAGE.scaleY = _loc7_;
         HELPER_IMAGE.scaleX = _loc7_;
         HELPER_IMAGE.x = param2;
         HELPER_IMAGE.y = param3;
         HELPER_IMAGE.color = this.currentTextFormat.color;
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
            this._characterBatch.addImage(HELPER_IMAGE);
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
            if(!this._textFormat)
            {
               if(TextField.getBitmapFont("mini") == null)
               {
                  TextField.registerBitmapFont(new BitmapFont());
               }
               this._textFormat = new BitmapFontTextFormat("mini",NaN,0);
            }
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
         if(!this._text)
         {
            return "";
         }
         if(param1 == Infinity || this._wordWrap || this._text.indexOf(String.fromCharCode(10)) >= 0 || this._text.indexOf(String.fromCharCode(13)) >= 0)
         {
            return this._text;
         }
         var _loc15_:BitmapFont = this.currentTextFormat.font;
         var _loc9_:Number = this.currentTextFormat.size;
         var _loc10_:Number = this.currentTextFormat.letterSpacing;
         var _loc4_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc6_:* = Number(_loc9_ / _loc15_.size);
         if(_loc6_ !== _loc6_)
         {
            _loc6_ = 1;
         }
         var _loc11_:* = 0;
         var _loc12_:Number = NaN;
         var _loc2_:int = this._text.length;
         var _loc3_:* = -1;
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc5_ = this._text.charCodeAt(_loc7_);
            _loc8_ = _loc15_.getChar(_loc5_);
            if(_loc8_)
            {
               _loc13_ = 0;
               if(_loc4_ && _loc12_ === _loc12_)
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
                  if(_loc4_ && _loc12_ === _loc12_)
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
               _loc5_ = this._text.charCodeAt(_loc7_);
               _loc12_ = _loc7_ > 0?this._text.charCodeAt(_loc7_ - 1):NaN;
               _loc8_ = _loc15_.getChar(_loc5_);
               if(_loc8_)
               {
                  _loc13_ = 0;
                  if(_loc4_ && _loc12_ === _loc12_)
                  {
                     _loc13_ = Number(_loc8_.getKerning(_loc12_) * _loc6_);
                  }
                  _loc11_ = Number(_loc11_ - (_loc13_ + _loc8_.xAdvance * _loc6_ + _loc10_));
                  if(_loc11_ <= param1)
                  {
                     return this._text.substr(0,_loc7_) + this._truncationText;
                  }
               }
               _loc7_--;
            }
            return this._truncationText;
         }
         return this._text;
      }
   }
}

import starling.text.BitmapChar;

class CharLocation#3993
{
    
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   function CharLocation#3993()
   {
      super();
   }
}
