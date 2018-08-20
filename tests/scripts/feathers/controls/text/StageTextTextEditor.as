package feathers.controls.text
{
   import feathers.core.FeathersControl;
   import feathers.core.IMultilineTextEditor;
   import feathers.text.StageTextField;
   import feathers.utils.geom.matrixToScaleX;
   import feathers.utils.geom.matrixToScaleY;
   import flash.display.BitmapData;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.SoftKeyboardEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.events.Event;
   import starling.textures.ConcreteTexture;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   import starling.utils.MatrixUtil;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="enter",type="starling.events.Event")]
   [Event(name="focusIn",type="starling.events.Event")]
   [Event(name="focusOut",type="starling.events.Event")]
   [Event(name="softKeyboardActivate",type="starling.events.Event")]
   [Event(name="softKeyboardDeactivate",type="starling.events.Event")]
   public class StageTextTextEditor extends FeathersControl implements IMultilineTextEditor
   {
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      protected static const INVALIDATION_FLAG_POSITION:String = "position";
       
      
      protected var stageText:Object;
      
      protected var textSnapshot:Image;
      
      protected var _needsNewTexture:Boolean = false;
      
      protected var _ignoreStageTextChanges:Boolean = false;
      
      protected var _text:String = "";
      
      protected var _measureTextField:TextField;
      
      protected var _stageTextIsTextField:Boolean = false;
      
      protected var _stageTextHasFocus:Boolean = false;
      
      protected var _isWaitingToSetFocus:Boolean = false;
      
      protected var _pendingSelectionBeginIndex:int = -1;
      
      protected var _pendingSelectionEndIndex:int = -1;
      
      protected var _stageTextIsComplete:Boolean = false;
      
      protected var _autoCapitalize:String = "none";
      
      protected var _autoCorrect:Boolean = false;
      
      protected var _color:uint = 0;
      
      protected var _disabledColor:uint = 10066329;
      
      protected var _displayAsPassword:Boolean = false;
      
      protected var _isEditable:Boolean = true;
      
      protected var _fontFamily:String = null;
      
      protected var _fontPosture:String = "normal";
      
      protected var _fontSize:int = 12;
      
      protected var _fontWeight:String = "normal";
      
      protected var _locale:String = "en";
      
      protected var _maxChars:int = 0;
      
      protected var _multiline:Boolean = false;
      
      protected var _restrict:String;
      
      protected var _returnKeyLabel:String = "default";
      
      protected var _softKeyboardType:String = "default";
      
      protected var _textAlign:String = "start";
      
      public function StageTextTextEditor()
      {
         super();
         this._stageTextIsTextField = /^(Windows|Mac OS|Linux) .*/.exec(Capabilities.os) != null;
         this.isQuickHitAreaEnabled = true;
         this.addEventListener("removedFromStage",textEditor_removedFromStageHandler);
      }
      
      override public function set x(param1:Number) : void
      {
         if(super.x == param1)
         {
            return;
         }
         .super.x = param1;
         this.invalidate("position");
      }
      
      override public function set y(param1:Number) : void
      {
         if(super.y == param1)
         {
            return;
         }
         .super.y = param1;
         this.invalidate("position");
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(!param1)
         {
            param1 = "";
         }
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.invalidate("data");
         this.dispatchEventWith("change");
      }
      
      public function get selectionBeginIndex() : int
      {
         if(this._pendingSelectionBeginIndex >= 0)
         {
            return this._pendingSelectionBeginIndex;
         }
         if(this.stageText)
         {
            return this.stageText.selectionAnchorIndex;
         }
         return 0;
      }
      
      public function get selectionEndIndex() : int
      {
         if(this._pendingSelectionEndIndex >= 0)
         {
            return this._pendingSelectionEndIndex;
         }
         if(this.stageText)
         {
            return this.stageText.selectionActiveIndex;
         }
         return 0;
      }
      
      public function get baseline() : Number
      {
         if(!this._measureTextField)
         {
            return 0;
         }
         return this._measureTextField.getLineMetrics(0).ascent;
      }
      
      public function get autoCapitalize() : String
      {
         return this._autoCapitalize;
      }
      
      public function set autoCapitalize(param1:String) : void
      {
         if(this._autoCapitalize == param1)
         {
            return;
         }
         this._autoCapitalize = param1;
         this.invalidate("styles");
      }
      
      public function get autoCorrect() : Boolean
      {
         return this._autoCorrect;
      }
      
      public function set autoCorrect(param1:Boolean) : void
      {
         if(this._autoCorrect == param1)
         {
            return;
         }
         this._autoCorrect = param1;
         this.invalidate("styles");
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this.invalidate("styles");
      }
      
      public function get disabledColor() : uint
      {
         return this._disabledColor;
      }
      
      public function set disabledColor(param1:uint) : void
      {
         if(this._disabledColor == param1)
         {
            return;
         }
         this._disabledColor = param1;
         this.invalidate("styles");
      }
      
      public function get displayAsPassword() : Boolean
      {
         return this._displayAsPassword;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         if(this._displayAsPassword == param1)
         {
            return;
         }
         this._displayAsPassword = param1;
         this.invalidate("styles");
      }
      
      public function get isEditable() : Boolean
      {
         return this._isEditable;
      }
      
      public function set isEditable(param1:Boolean) : void
      {
         if(this._isEditable == param1)
         {
            return;
         }
         this._isEditable = param1;
         this.invalidate("styles");
      }
      
      public function get setTouchFocusOnEndedPhase() : Boolean
      {
         return true;
      }
      
      public function get fontFamily() : String
      {
         return this._fontFamily;
      }
      
      public function set fontFamily(param1:String) : void
      {
         if(this._fontFamily == param1)
         {
            return;
         }
         this._fontFamily = param1;
         this.invalidate("styles");
      }
      
      public function get fontPosture() : String
      {
         return this._fontPosture;
      }
      
      public function set fontPosture(param1:String) : void
      {
         if(this._fontPosture == param1)
         {
            return;
         }
         this._fontPosture = param1;
         this.invalidate("styles");
      }
      
      public function get fontSize() : int
      {
         return this._fontSize;
      }
      
      public function set fontSize(param1:int) : void
      {
         if(this._fontSize == param1)
         {
            return;
         }
         this._fontSize = param1;
         this.invalidate("styles");
      }
      
      public function get fontWeight() : String
      {
         return this._fontWeight;
      }
      
      public function set fontWeight(param1:String) : void
      {
         if(this._fontWeight == param1)
         {
            return;
         }
         this._fontWeight = param1;
         this.invalidate("styles");
      }
      
      public function get locale() : String
      {
         return this._locale;
      }
      
      public function set locale(param1:String) : void
      {
         if(this._locale == param1)
         {
            return;
         }
         this._locale = param1;
         this.invalidate("styles");
      }
      
      public function get maxChars() : int
      {
         return this._maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         if(this._maxChars == param1)
         {
            return;
         }
         this._maxChars = param1;
         this.invalidate("styles");
      }
      
      public function get multiline() : Boolean
      {
         return this._multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         if(this._multiline == param1)
         {
            return;
         }
         this._multiline = param1;
         this.invalidate("styles");
      }
      
      public function get restrict() : String
      {
         return this._restrict;
      }
      
      public function set restrict(param1:String) : void
      {
         if(this._restrict == param1)
         {
            return;
         }
         this._restrict = param1;
         this.invalidate("styles");
      }
      
      public function get returnKeyLabel() : String
      {
         return this._returnKeyLabel;
      }
      
      public function set returnKeyLabel(param1:String) : void
      {
         if(this._returnKeyLabel == param1)
         {
            return;
         }
         this._returnKeyLabel = param1;
         this.invalidate("styles");
      }
      
      public function get softKeyboardType() : String
      {
         return this._softKeyboardType;
      }
      
      public function set softKeyboardType(param1:String) : void
      {
         if(this._softKeyboardType == param1)
         {
            return;
         }
         this._softKeyboardType = param1;
         this.invalidate("styles");
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         this.invalidate("styles");
      }
      
      override public function dispose() : void
      {
         if(this._measureTextField)
         {
            Starling.current.nativeStage.removeChild(this._measureTextField);
            this._measureTextField = null;
         }
         if(this.stageText)
         {
            this.disposeStageText();
         }
         if(this.textSnapshot)
         {
            this.textSnapshot.texture.dispose();
            this.removeChild(this.textSnapshot,true);
            this.textSnapshot = null;
         }
         super.dispose();
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc14_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc12_:* = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:* = 0;
         var _loc8_:* = 0;
         if(this._stageTextIsTextField)
         {
            _loc6_ = 2;
            _loc8_ = 4;
         }
         var _loc16_:int = 0;
         HELPER_POINT.y = _loc16_;
         HELPER_POINT.x = _loc16_;
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         MatrixUtil.transformCoords(HELPER_MATRIX,-_loc6_,-_loc6_,HELPER_POINT);
         var _loc7_:Rectangle = Starling.current.viewPort;
         var _loc15_:Rectangle = this.stageText.viewPort;
         if(!_loc15_)
         {
            _loc15_ = new Rectangle();
         }
         var _loc11_:* = 1;
         if(Starling.current.supportHighResolutions)
         {
            _loc11_ = Number(Starling.current.nativeStage.contentsScaleFactor);
         }
         var _loc13_:Number = Starling.contentScaleFactor;
         var _loc9_:Number = Starling.contentScaleFactor;
         if(Starling.current.nativeStage.displayState == "fullScreen" || Starling.current.nativeStage.displayState == "fullScreenInteractive")
         {
            _loc14_ = Starling.current.nativeStage.fullScreenWidth / Starling.current.stage.stageWidth;
            _loc3_ = Starling.current.nativeStage.fullScreenHeight / Starling.current.stage.stageHeight;
            _loc13_ = _loc14_ / _loc11_;
            _loc9_ = _loc3_ / _loc11_;
         }
         _loc15_.x = Math.round(_loc7_.x + HELPER_POINT.x * _loc13_);
         _loc15_.y = Math.round(_loc7_.y + HELPER_POINT.y * _loc9_);
         this.stageText.viewPort = _loc15_;
         if(this.stageText.visible)
         {
            this.getTransformationMatrix(this.stage,HELPER_MATRIX);
            _loc5_ = matrixToScaleX(HELPER_MATRIX);
            _loc10_ = matrixToScaleY(HELPER_MATRIX);
            _loc12_ = _loc5_;
            if(_loc10_ < _loc5_)
            {
               _loc12_ = _loc10_;
            }
            _loc13_ = Starling.contentScaleFactor;
            _loc4_ = this._fontSize * _loc13_ * _loc12_;
            if(this.stageText.fontSize != _loc4_)
            {
               this.stageText.fontSize = _loc4_;
            }
         }
         if(this.textSnapshot)
         {
            this.textSnapshot.x = Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx - _loc6_;
            this.textSnapshot.y = Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty - _loc6_;
         }
         super.render(param1,param2);
      }
      
      public function setFocus(param1:Point = null) : void
      {
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Number = NaN;
         if(this.stage && !this.stageText.stage)
         {
            this.stageText.stage = Starling.current.nativeStage;
         }
         if(this.stageText && this._stageTextIsComplete)
         {
            if(param1)
            {
               _loc6_ = param1.x + 2;
               _loc2_ = param1.y + 2;
               if(_loc6_ < 0)
               {
                  var _loc7_:int = 0;
                  this._pendingSelectionEndIndex = _loc7_;
                  this._pendingSelectionBeginIndex = _loc7_;
               }
               else
               {
                  this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(_loc6_,_loc2_);
                  if(this._pendingSelectionBeginIndex < 0)
                  {
                     if(this._multiline)
                     {
                        _loc4_ = _loc2_ / this._measureTextField.getLineMetrics(0).height;
                        try
                        {
                           this._pendingSelectionBeginIndex = this._measureTextField.getLineOffset(_loc4_) + this._measureTextField.getLineLength(_loc4_);
                           if(this._pendingSelectionBeginIndex != this._text.length)
                           {
                              this._pendingSelectionBeginIndex--;
                           }
                        }
                        catch(error:Error)
                        {
                           this._pendingSelectionBeginIndex = this._text.length;
                        }
                     }
                     else
                     {
                        this._pendingSelectionBeginIndex = this._measureTextField.getCharIndexAtPoint(_loc6_,this._measureTextField.getLineMetrics(0).ascent / 2);
                        if(this._pendingSelectionBeginIndex < 0)
                        {
                           this._pendingSelectionBeginIndex = this._text.length;
                        }
                     }
                  }
                  else
                  {
                     _loc5_ = this._measureTextField.getCharBoundaries(this._pendingSelectionBeginIndex);
                     _loc3_ = _loc5_.x;
                     if(_loc5_ && _loc3_ + _loc5_.width - _loc6_ < _loc6_ - _loc3_)
                     {
                        this._pendingSelectionBeginIndex++;
                     }
                  }
                  this._pendingSelectionEndIndex = this._pendingSelectionBeginIndex;
               }
            }
            else
            {
               var _loc9_:int = -1;
               this._pendingSelectionEndIndex = _loc9_;
               this._pendingSelectionBeginIndex = _loc9_;
            }
            this.stageText.visible = true;
            this.stageText.assignFocus();
         }
         else
         {
            this._isWaitingToSetFocus = true;
         }
      }
      
      public function clearFocus() : void
      {
         if(!this._stageTextHasFocus)
         {
            return;
         }
         Starling.current.nativeStage.focus = Starling.current.nativeStage;
      }
      
      public function selectRange(param1:int, param2:int) : void
      {
         if(this._stageTextIsComplete && this.stageText)
         {
            this._pendingSelectionBeginIndex = -1;
            this._pendingSelectionEndIndex = -1;
            this.stageText.selectRange(param1,param2);
         }
         else
         {
            this._pendingSelectionBeginIndex = param1;
            this._pendingSelectionEndIndex = param2;
         }
      }
      
      public function measureText(param1:Point = null) : Point
      {
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc2_:* = this.explicitWidth !== this.explicitWidth;
         var _loc3_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc2_ && !_loc3_)
         {
            param1.x = this.explicitWidth;
            param1.y = this.explicitHeight;
            return param1;
         }
         if(!this._isInitialized)
         {
            this.initializeInternal();
         }
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc5_:Boolean = this.isInvalid("data");
         if(_loc4_ || _loc5_)
         {
            this.refreshMeasureProperties();
         }
         param1 = this.measure(param1);
         return param1;
      }
      
      override protected function initialize() : void
      {
         if(this._measureTextField && !this._measureTextField.parent)
         {
            Starling.current.nativeStage.addChild(this._measureTextField);
         }
         else if(!this._measureTextField)
         {
            this._measureTextField = new TextField();
            this._measureTextField.visible = false;
            var _loc1_:Boolean = false;
            this._measureTextField.mouseWheelEnabled = _loc1_;
            this._measureTextField.mouseEnabled = _loc1_;
            this._measureTextField.autoSize = "left";
            this._measureTextField.multiline = false;
            this._measureTextField.wordWrap = false;
            this._measureTextField.embedFonts = false;
            this._measureTextField.defaultTextFormat = new TextFormat(null,11,0,false,false,false);
            Starling.current.nativeStage.addChild(this._measureTextField);
         }
         this.createStageText();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = this.isInvalid("size");
         this.commit();
         _loc1_ = this.autoSizeIfNeeded() || _loc1_;
         this.layout(_loc1_);
      }
      
      protected function commit() : void
      {
         var _loc1_:Boolean = this.isInvalid("state");
         var _loc2_:Boolean = this.isInvalid("styles");
         var _loc3_:Boolean = this.isInvalid("data");
         if(_loc2_ || _loc3_)
         {
            this.refreshMeasureProperties();
         }
         var _loc4_:Boolean = this._ignoreStageTextChanges;
         this._ignoreStageTextChanges = true;
         if(_loc2_)
         {
            this.refreshStageTextProperties();
         }
         if(_loc3_)
         {
            if(this.stageText.text != this._text)
            {
               if(this._pendingSelectionBeginIndex < 0)
               {
                  this._pendingSelectionBeginIndex = this.stageText.selectionActiveIndex;
                  this._pendingSelectionEndIndex = this.stageText.selectionAnchorIndex;
               }
               this.stageText.text = this._text;
            }
         }
         this._ignoreStageTextChanges = _loc4_;
         if(_loc2_ || _loc1_)
         {
            this.stageText.editable = this._isEditable && this._isEnabled;
         }
      }
      
      protected function measure(param1:Point = null) : Point
      {
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc3_:* = this.explicitWidth !== this.explicitWidth;
         var _loc5_:* = this.explicitHeight !== this.explicitHeight;
         this._measureTextField.autoSize = "left";
         var _loc2_:Number = this.explicitWidth;
         if(_loc3_)
         {
            _loc2_ = this._measureTextField.textWidth;
            if(_loc2_ < this._minWidth)
            {
               _loc2_ = this._minWidth;
            }
            else if(_loc2_ > this._maxWidth)
            {
               _loc2_ = this._maxWidth;
            }
         }
         this._measureTextField.width = _loc2_ + 4;
         var _loc4_:Number = this.explicitHeight;
         if(_loc5_)
         {
            _loc4_ = this._measureTextField.height;
            if(_loc4_ < this._minHeight)
            {
               _loc4_ = this._minHeight;
            }
            else if(_loc4_ > this._maxHeight)
            {
               _loc4_ = this._maxHeight;
            }
         }
         this._measureTextField.autoSize = "none";
         this._measureTextField.width = this.actualWidth + 4;
         this._measureTextField.height = this.actualHeight;
         param1.x = _loc2_;
         param1.y = _loc4_;
         return param1;
      }
      
      protected function layout(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc9_:* = false;
         var _loc5_:Boolean = this.isInvalid("state");
         var _loc7_:Boolean = this.isInvalid("styles");
         var _loc8_:Boolean = this.isInvalid("data");
         var _loc6_:Boolean = this.isInvalid("position");
         var _loc2_:Boolean = this.isInvalid("skin");
         if(_loc6_ || param1 || _loc7_ || _loc2_ || _loc5_)
         {
            this.refreshViewPort();
            _loc3_ = this.stageText.viewPort;
            _loc4_ = !!this.textSnapshot?this.textSnapshot.texture.root:null;
            this._needsNewTexture = this._needsNewTexture || !this.textSnapshot || _loc3_.width != _loc4_.width || _loc3_.height != _loc4_.height;
         }
         if(!this._stageTextHasFocus && (_loc7_ || _loc8_ || param1 || this._needsNewTexture))
         {
            _loc9_ = this._text.length > 0;
            if(_loc9_)
            {
               this.refreshSnapshot();
            }
            if(this.textSnapshot)
            {
               this.textSnapshot.visible = !this._stageTextHasFocus;
               this.textSnapshot.alpha = !!_loc9_?1:0;
            }
            this.stageText.visible = false;
         }
         this.doPendingActions();
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         var _loc1_:* = this.explicitWidth !== this.explicitWidth;
         var _loc2_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc1_ && !_loc2_)
         {
            return false;
         }
         this.measure(HELPER_POINT);
         return this.setSizeInternal(HELPER_POINT.x,HELPER_POINT.y,false);
      }
      
      protected function refreshMeasureProperties() : void
      {
         var _loc3_:* = 1;
         if(Starling.current.supportHighResolutions)
         {
            _loc3_ = Number(Starling.current.nativeStage.contentsScaleFactor);
         }
         this._measureTextField.displayAsPassword = this._displayAsPassword;
         this._measureTextField.maxChars = this._maxChars;
         this._measureTextField.restrict = this._restrict;
         var _loc4_:* = this._multiline;
         this._measureTextField.wordWrap = _loc4_;
         this._measureTextField.multiline = _loc4_;
         var _loc2_:TextFormat = this._measureTextField.defaultTextFormat;
         _loc2_.color = this._color;
         _loc2_.font = this._fontFamily;
         _loc2_.italic = this._fontPosture == "italic";
         _loc2_.size = this._fontSize * _loc3_;
         _loc2_.bold = this._fontWeight == "bold";
         var _loc1_:String = this._textAlign;
         if(_loc1_ == "start")
         {
            _loc1_ = "left";
         }
         else if(_loc1_ == "end")
         {
            _loc1_ = "right";
         }
         _loc2_.align = _loc1_;
         this._measureTextField.defaultTextFormat = _loc2_;
         this._measureTextField.setTextFormat(_loc2_);
         if(this._text.length == 0)
         {
            this._measureTextField.text = " ";
         }
         else
         {
            this._measureTextField.text = this._text;
         }
      }
      
      protected function refreshStageTextProperties() : void
      {
         if(this.stageText.multiline != this._multiline)
         {
            if(this.stageText)
            {
               this.disposeStageText();
            }
            this.createStageText();
         }
         this.stageText.autoCapitalize = this._autoCapitalize;
         this.stageText.autoCorrect = this._autoCorrect;
         if(this._isEnabled)
         {
            this.stageText.color = this._color;
         }
         else
         {
            this.stageText.color = this._disabledColor;
         }
         this.stageText.displayAsPassword = this._displayAsPassword;
         this.stageText.fontFamily = this._fontFamily;
         this.stageText.fontPosture = this._fontPosture;
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         var _loc2_:Number = matrixToScaleX(HELPER_MATRIX);
         var _loc3_:Number = matrixToScaleY(HELPER_MATRIX);
         var _loc1_:* = _loc2_;
         if(_loc3_ < _loc2_)
         {
            _loc1_ = _loc3_;
         }
         var _loc4_:Number = Starling.contentScaleFactor;
         this.stageText.fontSize = this._fontSize * _loc4_ * _loc1_;
         this.stageText.fontWeight = this._fontWeight;
         this.stageText.locale = this._locale;
         this.stageText.maxChars = this._maxChars;
         this.stageText.restrict = this._restrict;
         this.stageText.returnKeyLabel = this._returnKeyLabel;
         this.stageText.softKeyboardType = this._softKeyboardType;
         this.stageText.textAlign = this._textAlign;
      }
      
      protected function doPendingActions() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._isWaitingToSetFocus)
         {
            this._isWaitingToSetFocus = false;
            this.setFocus();
         }
         if(this._pendingSelectionBeginIndex >= 0)
         {
            _loc1_ = this._pendingSelectionBeginIndex;
            _loc2_ = this._pendingSelectionEndIndex < 0?this._pendingSelectionBeginIndex:int(this._pendingSelectionEndIndex);
            this._pendingSelectionBeginIndex = -1;
            this._pendingSelectionEndIndex = -1;
            if(this.stageText.selectionAnchorIndex != _loc1_ || this.stageText.selectionActiveIndex != _loc2_)
            {
               this.selectRange(_loc1_,_loc2_);
            }
         }
      }
      
      protected function texture_onRestore() : void
      {
         this.refreshSnapshot();
         if(this.textSnapshot)
         {
            this.textSnapshot.visible = !this._stageTextHasFocus;
            this.textSnapshot.alpha = this._text.length > 0?1:0;
         }
         if(!this._stageTextHasFocus)
         {
            this.stageText.visible = false;
         }
      }
      
      protected function refreshSnapshot() : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(this.stage && !this.stageText.stage)
         {
            this.stageText.stage = Starling.current.nativeStage;
         }
         if(!this.stageText.stage)
         {
            this.invalidate("data");
            return;
         }
         var _loc1_:Rectangle = this.stageText.viewPort;
         if(_loc1_.width == 0 || _loc1_.height == 0)
         {
            return;
         }
         var _loc4_:* = 1;
         if(Starling.current.supportHighResolutions)
         {
            _loc4_ = Number(Starling.current.nativeStage.contentsScaleFactor);
         }
         try
         {
            _loc2_ = new BitmapData(_loc1_.width * _loc4_,_loc1_.height * _loc4_,true,16711935);
            this.stageText.drawViewPortToBitmapData(_loc2_);
         }
         catch(error:Error)
         {
            _loc2_.dispose();
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,16711935);
            this.stageText.drawViewPortToBitmapData(_loc2_);
         }
         var _loc5_:Texture = null;
         if(!this.textSnapshot || this._needsNewTexture)
         {
            _loc5_ = Texture.fromBitmapData(_loc2_,false,false,Starling.contentScaleFactor);
            TextureMemoryManager.add(_loc5_,"StageTextTextEditor");
            _loc5_.root.onRestore = texture_onRestore;
         }
         if(!this.textSnapshot)
         {
            this.textSnapshot = new Image(_loc5_);
            this.addChild(this.textSnapshot);
         }
         else if(this._needsNewTexture)
         {
            this.textSnapshot.texture.dispose();
            this.textSnapshot.texture = _loc5_;
            this.textSnapshot.readjustSize();
         }
         else
         {
            _loc3_ = this.textSnapshot.texture;
            _loc3_.root.uploadBitmapData(_loc2_);
         }
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         this.textSnapshot.scaleX = 1 / matrixToScaleX(HELPER_MATRIX);
         this.textSnapshot.scaleY = 1 / matrixToScaleY(HELPER_MATRIX);
         if(_loc4_ > 1 && _loc2_.width == _loc1_.width)
         {
            this.textSnapshot.scaleX = this.textSnapshot.scaleX * _loc4_;
            this.textSnapshot.scaleY = this.textSnapshot.scaleY * _loc4_;
         }
         _loc2_.dispose();
         this._needsNewTexture = false;
      }
      
      protected function refreshViewPort() : void
      {
         var _loc2_:Rectangle = Starling.current.viewPort;
         var _loc9_:Rectangle = this.stageText.viewPort;
         if(!_loc9_)
         {
            _loc9_ = new Rectangle();
         }
         var _loc11_:int = 0;
         HELPER_POINT.y = _loc11_;
         HELPER_POINT.x = _loc11_;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(this._stageTextIsTextField)
         {
            _loc3_ = 2;
            _loc4_ = 4;
         }
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         var _loc1_:Number = matrixToScaleX(HELPER_MATRIX);
         var _loc5_:Number = matrixToScaleY(HELPER_MATRIX);
         MatrixUtil.transformCoords(HELPER_MATRIX,-_loc3_,-_loc3_,HELPER_POINT);
         var _loc8_:* = 1;
         if(Starling.current.supportHighResolutions)
         {
            _loc8_ = Number(Starling.current.nativeStage.contentsScaleFactor);
         }
         var _loc6_:Number = Starling.contentScaleFactor / _loc8_;
         _loc9_.x = Math.round(_loc2_.x + HELPER_POINT.x * _loc6_);
         _loc9_.y = Math.round(_loc2_.y + HELPER_POINT.y * _loc6_);
         var _loc7_:* = Number(Math.round((this.actualWidth + _loc4_) * _loc6_ * _loc1_));
         if(_loc7_ < 1 || _loc7_ !== _loc7_)
         {
            _loc7_ = 1;
         }
         var _loc10_:* = Number(Math.round((this.actualHeight + _loc4_) * _loc6_ * _loc5_));
         if(_loc10_ < 1 || _loc10_ !== _loc10_)
         {
            _loc10_ = 1;
         }
         _loc9_.width = _loc7_;
         _loc9_.height = _loc10_;
         this.stageText.viewPort = _loc9_;
         this._measureTextField.width = this.actualWidth + 4;
         this._measureTextField.height = this.actualHeight;
      }
      
      protected function disposeStageText() : void
      {
         if(!this.stageText)
         {
            return;
         }
         this.stageText.removeEventListener("change",stageText_changeHandler);
         this.stageText.removeEventListener("keyDown",stageText_keyDownHandler);
         this.stageText.removeEventListener("keyUp",stageText_keyUpHandler);
         this.stageText.removeEventListener("focusIn",stageText_focusInHandler);
         this.stageText.removeEventListener("focusOut",stageText_focusOutHandler);
         this.stageText.removeEventListener("complete",stageText_completeHandler);
         this.stageText.removeEventListener("softKeyboardActivate",stageText_softKeyboardActivateHandler);
         this.stageText.removeEventListener("softKeyboardDeactivate",stageText_softKeyboardDeactivateHandler);
         this.stageText.stage = null;
         this.stageText.dispose();
         this.stageText = null;
      }
      
      protected function createStageText() : void
      {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         this._stageTextIsComplete = false;
         try
         {
            _loc1_ = getDefinitionByName("flash.text.StageText") as Class;
            _loc2_ = getDefinitionByName("flash.text.StageTextInitOptions") as Class;
            _loc3_ = new _loc2_(this._multiline);
         }
         catch(error:Error)
         {
            _loc1_ = StageTextField;
            _loc3_ = {"multiline":this._multiline};
         }
         this.stageText = new _loc1_(_loc3_);
         this.stageText.addEventListener("softKeyboardActivate",stageText_softKeyboardActivateHandler);
         this.stageText.addEventListener("softKeyboardDeactivate",stageText_softKeyboardDeactivateHandler);
         this.stageText.visible = false;
         this.stageText.addEventListener("change",stageText_changeHandler);
         this.stageText.addEventListener("keyDown",stageText_keyDownHandler);
         this.stageText.addEventListener("keyUp",stageText_keyUpHandler);
         this.stageText.addEventListener("focusIn",stageText_focusInHandler);
         this.stageText.addEventListener("focusOut",stageText_focusOutHandler);
         this.stageText.addEventListener("complete",stageText_completeHandler);
         this.invalidate();
      }
      
      protected function textEditor_removedFromStageHandler(param1:starling.events.Event) : void
      {
         this.stageText.stage = null;
      }
      
      protected function stageText_changeHandler(param1:flash.events.Event) : void
      {
         if(this._ignoreStageTextChanges)
         {
            return;
         }
         this.text = this.stageText.text;
      }
      
      protected function stageText_completeHandler(param1:flash.events.Event) : void
      {
         this.stageText.removeEventListener("complete",stageText_completeHandler);
         this.invalidate();
         this._stageTextIsComplete = true;
      }
      
      protected function stageText_focusInHandler(param1:FocusEvent) : void
      {
         this._stageTextHasFocus = true;
         if(this.textSnapshot)
         {
            this.textSnapshot.visible = false;
         }
         this.invalidate("skin");
         this.dispatchEventWith("focusIn");
      }
      
      protected function stageText_focusOutHandler(param1:FocusEvent) : void
      {
         this._stageTextHasFocus = false;
         this.stageText.selectRange(1,1);
         this.invalidate("data");
         this.invalidate("skin");
         this.dispatchEventWith("focusOut");
      }
      
      protected function stageText_keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:* = Boolean(!this._multiline && param1.keyCode == 13);
         if(!_loc2_)
         {
            _loc2_ = !this._multiline && param1.keyCode == 16777230;
         }
         if(_loc2_)
         {
            param1.preventDefault();
            this.dispatchEventWith("enter");
         }
         else if(param1.keyCode == 16777238)
         {
            param1.preventDefault();
            Starling.current.nativeStage.focus = Starling.current.nativeStage;
         }
      }
      
      protected function stageText_keyUpHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:* = Boolean(!this._multiline && param1.keyCode == 13);
         if(!_loc2_)
         {
            _loc2_ = !this._multiline && param1.keyCode == 16777230;
         }
         if(_loc2_)
         {
            param1.preventDefault();
         }
      }
      
      protected function stageText_softKeyboardActivateHandler(param1:SoftKeyboardEvent) : void
      {
         this.dispatchEventWith("softKeyboardActivate",true);
      }
      
      protected function stageText_softKeyboardDeactivateHandler(param1:SoftKeyboardEvent) : void
      {
         this.dispatchEventWith("softKeyboardDeactivate",true);
      }
   }
}
