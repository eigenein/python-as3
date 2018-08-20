package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.skins.IStyleProvider;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.errors.IllegalOperationError;
   import flash.events.ErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.utils.RectangleUtil;
   import starling.utils.SystemUtil;
   
   [Event(name="complete",type="starling.events.Event")]
   [Event(name="error",type="starling.events.Event")]
   public class ImageLoader extends FeathersControl
   {
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_RECTANGLE:Rectangle = new Rectangle();
      
      private static const HELPER_RECTANGLE2:Rectangle = new Rectangle();
      
      private static const CONTEXT_LOST_WARNING:String = "ImageLoader: Context lost while processing loaded image, retrying...";
      
      protected static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);
      
      protected static const ATF_FILE_EXTENSION:String = "atf";
      
      protected static var textureQueueHead:ImageLoader;
      
      protected static var textureQueueTail:ImageLoader;
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var image:Image;
      
      protected var loader:Loader;
      
      protected var urlLoader:URLLoader;
      
      protected var _lastURL:String;
      
      protected var _currentTextureWidth:Number = NaN;
      
      protected var _currentTextureHeight:Number = NaN;
      
      protected var _currentTexture:Texture;
      
      protected var _texture:Texture;
      
      protected var _textureBitmapData:BitmapData;
      
      protected var _textureRawData:ByteArray;
      
      protected var _isTextureOwner:Boolean = false;
      
      protected var _source:Object;
      
      protected var _loadingTexture:Texture;
      
      protected var _errorTexture:Texture;
      
      protected var _isLoaded:Boolean = false;
      
      private var _textureScale:Number = 1;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _textureFormat:String = "bgra";
      
      private var _snapToPixels:Boolean = false;
      
      private var _maintainAspectRatio:Boolean = true;
      
      protected var _pendingBitmapDataTexture:BitmapData;
      
      protected var _pendingRawTextureData:ByteArray;
      
      protected var _delayTextureCreation:Boolean = false;
      
      protected var _isInTextureQueue:Boolean = false;
      
      protected var _textureQueuePrevious:ImageLoader;
      
      protected var _textureQueueNext:ImageLoader;
      
      protected var _accumulatedPrepareTextureTime:Number;
      
      protected var _textureQueueDuration:Number = Infinity;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      public function ImageLoader()
      {
         super();
         this.isQuickHitAreaEnabled = true;
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return ImageLoader.globalStyleProvider;
      }
      
      public function get source() : Object
      {
         return this._source;
      }
      
      public function set source(param1:Object) : void
      {
         if(this._source == param1)
         {
            return;
         }
         if(this._isInTextureQueue)
         {
            this.removeFromTextureQueue();
         }
         this._source = param1;
         this.cleanupTexture();
         if(this.image)
         {
            this.image.visible = false;
         }
         this._lastURL = null;
         if(this._source is Texture)
         {
            this._isLoaded = true;
         }
         else
         {
            this._isLoaded = false;
         }
         this.invalidate("data");
      }
      
      public function get loadingTexture() : Texture
      {
         return this._loadingTexture;
      }
      
      public function set loadingTexture(param1:Texture) : void
      {
         if(this._loadingTexture == param1)
         {
            return;
         }
         this._loadingTexture = param1;
         this.invalidate("styles");
      }
      
      public function get errorTexture() : Texture
      {
         return this._errorTexture;
      }
      
      public function set errorTexture(param1:Texture) : void
      {
         if(this._errorTexture == param1)
         {
            return;
         }
         this._errorTexture = param1;
         this.invalidate("styles");
      }
      
      public function get isLoaded() : Boolean
      {
         return this._isLoaded;
      }
      
      public function get textureScale() : Number
      {
         return this._textureScale;
      }
      
      public function set textureScale(param1:Number) : void
      {
         if(this._textureScale == param1)
         {
            return;
         }
         this._textureScale = param1;
         this.invalidate("size");
      }
      
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
      
      public function get textureFormat() : String
      {
         return this._textureFormat;
      }
      
      public function set textureFormat(param1:String) : void
      {
         if(this._textureFormat == param1)
         {
            return;
         }
         this._textureFormat = param1;
         this._lastURL = null;
         this.invalidate("data");
      }
      
      public function get snapToPixels() : Boolean
      {
         return this._snapToPixels;
      }
      
      public function set snapToPixels(param1:Boolean) : void
      {
         if(this._snapToPixels == param1)
         {
            return;
         }
         this._snapToPixels = param1;
      }
      
      public function get maintainAspectRatio() : Boolean
      {
         return this._maintainAspectRatio;
      }
      
      public function set maintainAspectRatio(param1:Boolean) : void
      {
         if(this._maintainAspectRatio == param1)
         {
            return;
         }
         this._maintainAspectRatio = param1;
         this.invalidate("layout");
      }
      
      public function get originalSourceWidth() : Number
      {
         if(this._currentTextureWidth === this._currentTextureWidth)
         {
            return this._currentTextureWidth;
         }
         return 0;
      }
      
      public function get originalSourceHeight() : Number
      {
         if(this._currentTextureHeight === this._currentTextureHeight)
         {
            return this._currentTextureHeight;
         }
         return 0;
      }
      
      public function get delayTextureCreation() : Boolean
      {
         return this._delayTextureCreation;
      }
      
      public function set delayTextureCreation(param1:Boolean) : void
      {
         if(this._delayTextureCreation == param1)
         {
            return;
         }
         this._delayTextureCreation = param1;
         if(!this._delayTextureCreation)
         {
            this.processPendingTexture();
         }
      }
      
      public function get textureQueueDuration() : Number
      {
         return this._textureQueueDuration;
      }
      
      public function set textureQueueDuration(param1:Number) : void
      {
         if(this._textureQueueDuration == param1)
         {
            return;
         }
         var _loc2_:Number = this._textureQueueDuration;
         this._textureQueueDuration = param1;
         if(this._delayTextureCreation)
         {
            if((this._pendingBitmapDataTexture || this._pendingRawTextureData) && _loc2_ == Infinity && this._textureQueueDuration < Infinity)
            {
               this.addToTextureQueue();
            }
            else if(this._isInTextureQueue && this._textureQueueDuration == Infinity)
            {
               this.removeFromTextureQueue();
            }
         }
      }
      
      public function get padding() : Number
      {
         return this._paddingTop;
      }
      
      public function set padding(param1:Number) : void
      {
         this.paddingTop = param1;
         this.paddingRight = param1;
         this.paddingBottom = param1;
         this.paddingLeft = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         if(this._paddingTop == param1)
         {
            return;
         }
         this._paddingTop = param1;
         this.invalidate("styles");
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         if(this._paddingRight == param1)
         {
            return;
         }
         this._paddingRight = param1;
         this.invalidate("styles");
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         if(this._paddingBottom == param1)
         {
            return;
         }
         this._paddingBottom = param1;
         this.invalidate("styles");
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         if(this._paddingLeft == param1)
         {
            return;
         }
         this._paddingLeft = param1;
         this.invalidate("styles");
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(this._snapToPixels)
         {
            this.getTransformationMatrix(this.stage,HELPER_MATRIX);
            param1.translateMatrix(Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx,Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty);
         }
         super.render(param1,param2);
         if(this._snapToPixels)
         {
            param1.translateMatrix(-(Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx),-(Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty));
         }
      }
      
      override public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
            this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
            this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
            try
            {
               this.loader.close();
            }
            catch(error:Error)
            {
            }
            this.loader = null;
         }
         this.cleanupTexture();
         super.dispose();
      }
      
      override protected function draw() : void
      {
         var _loc3_:Boolean = this.isInvalid("data");
         var _loc2_:Boolean = this.isInvalid("layout");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         if(_loc3_)
         {
            this.commitData();
         }
         if(_loc3_ || _loc4_)
         {
            this.commitStyles();
         }
         _loc1_ = this.autoSizeIfNeeded() || _loc1_;
         if(_loc3_ || _loc2_ || _loc1_ || _loc4_)
         {
            this.layout();
         }
      }
      
      protected function autoSizeIfNeeded() : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc4_:* = this.explicitWidth !== this.explicitWidth;
         var _loc6_:* = this.explicitHeight !== this.explicitHeight;
         if(!_loc4_ && !_loc6_)
         {
            return false;
         }
         var _loc2_:* = Number(this.explicitWidth);
         if(_loc4_)
         {
            if(this._currentTextureWidth === this._currentTextureWidth)
            {
               _loc2_ = Number(this._currentTextureWidth * this._textureScale);
               if(this._maintainAspectRatio && !_loc6_)
               {
                  _loc3_ = this.explicitHeight / (this._currentTextureHeight * this._textureScale);
                  _loc2_ = Number(_loc2_ * _loc3_);
               }
            }
            else
            {
               _loc2_ = 0;
            }
            _loc2_ = Number(_loc2_ + (this._paddingLeft + this._paddingRight));
         }
         var _loc5_:* = Number(this.explicitHeight);
         if(_loc6_)
         {
            if(this._currentTextureHeight === this._currentTextureHeight)
            {
               _loc5_ = Number(this._currentTextureHeight * this._textureScale);
               if(this._maintainAspectRatio && !_loc4_)
               {
                  _loc1_ = this.explicitWidth / (this._currentTextureWidth * this._textureScale);
                  _loc5_ = Number(_loc5_ * _loc1_);
               }
            }
            else
            {
               _loc5_ = 0;
            }
            _loc5_ = Number(_loc5_ + (this._paddingTop + this._paddingBottom));
         }
         return this.setSizeInternal(_loc2_,_loc5_,false);
      }
      
      protected function commitData() : void
      {
         var _loc1_:* = null;
         if(this._source is Texture)
         {
            this._lastURL = null;
            this._texture = Texture(this._source);
            this.refreshCurrentTexture();
         }
         else
         {
            _loc1_ = this._source as String;
            if(!_loc1_)
            {
               this._lastURL = null;
            }
            else if(_loc1_ != this._lastURL)
            {
               this._lastURL = _loc1_;
               if(this.urlLoader)
               {
                  this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
                  this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
                  this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
                  try
                  {
                     this.urlLoader.close();
                  }
                  catch(error:Error)
                  {
                  }
               }
               if(this.loader)
               {
                  this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
                  this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
                  this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
                  try
                  {
                     this.loader.close();
                  }
                  catch(error:Error)
                  {
                  }
               }
               if(_loc1_.toLowerCase().lastIndexOf("atf") == _loc1_.length - 3)
               {
                  if(this.loader)
                  {
                     this.loader = null;
                  }
                  if(!this.urlLoader)
                  {
                     this.urlLoader = new URLLoader();
                     this.urlLoader.dataFormat = "binary";
                  }
                  this.urlLoader.addEventListener("complete",rawDataLoader_completeHandler);
                  this.urlLoader.addEventListener("ioError",rawDataLoader_errorHandler);
                  this.urlLoader.addEventListener("securityError",rawDataLoader_errorHandler);
                  this.urlLoader.load(new URLRequest(_loc1_));
                  return;
               }
               if(this.urlLoader)
               {
                  this.urlLoader = null;
               }
               if(!this.loader)
               {
                  this.loader = new Loader();
               }
               this.loader.contentLoaderInfo.addEventListener("complete",loader_completeHandler);
               this.loader.contentLoaderInfo.addEventListener("ioError",loader_errorHandler);
               this.loader.contentLoaderInfo.addEventListener("securityError",loader_errorHandler);
               LOADER_CONTEXT.imageDecodingPolicy = "onLoad";
               this.loader.load(new URLRequest(_loc1_),LOADER_CONTEXT);
            }
            this.refreshCurrentTexture();
         }
      }
      
      protected function commitStyles() : void
      {
         if(!this.image)
         {
            return;
         }
         this.image.smoothing = this._smoothing;
         this.image.color = this._color;
      }
      
      protected function layout() : void
      {
         if(!this.image || !this._currentTexture)
         {
            return;
         }
         if(this._maintainAspectRatio)
         {
            HELPER_RECTANGLE.x = 0;
            HELPER_RECTANGLE.y = 0;
            HELPER_RECTANGLE.width = this._currentTextureWidth * this._textureScale;
            HELPER_RECTANGLE.height = this._currentTextureHeight * this._textureScale;
            HELPER_RECTANGLE2.x = 0;
            HELPER_RECTANGLE2.y = 0;
            HELPER_RECTANGLE2.width = this.actualWidth - this._paddingLeft - this._paddingRight;
            HELPER_RECTANGLE2.height = this.actualHeight - this._paddingTop - this._paddingBottom;
            RectangleUtil.fit(HELPER_RECTANGLE,HELPER_RECTANGLE2,"showAll",false,HELPER_RECTANGLE);
            this.image.x = HELPER_RECTANGLE.x + this._paddingLeft;
            this.image.y = HELPER_RECTANGLE.y + this._paddingTop;
            this.image.width = HELPER_RECTANGLE.width;
            this.image.height = HELPER_RECTANGLE.height;
         }
         else
         {
            this.image.x = this._paddingLeft;
            this.image.y = this._paddingTop;
            this.image.width = this.actualWidth - this._paddingLeft - this._paddingRight;
            this.image.height = this.actualHeight - this._paddingTop - this._paddingBottom;
         }
      }
      
      protected function refreshCurrentTexture() : void
      {
         var _loc1_:Texture = this._texture;
         if(!_loc1_)
         {
            if(this.loader)
            {
               _loc1_ = this._loadingTexture;
            }
            else
            {
               _loc1_ = this._errorTexture;
            }
         }
         if(this._currentTexture == _loc1_)
         {
            return;
         }
         this._currentTexture = _loc1_;
         if(!this._currentTexture)
         {
            if(this.image)
            {
               this.removeChild(this.image,true);
               this.image = null;
            }
            return;
         }
         var _loc2_:Rectangle = this._currentTexture.frame;
         if(_loc2_)
         {
            this._currentTextureWidth = _loc2_.width;
            this._currentTextureHeight = _loc2_.height;
         }
         else
         {
            this._currentTextureWidth = this._currentTexture.width;
            this._currentTextureHeight = this._currentTexture.height;
         }
         if(!this.image)
         {
            this.image = new Image(this._currentTexture);
            this.addChild(this.image);
         }
         else
         {
            this.image.texture = this._currentTexture;
            this.image.readjustSize();
         }
         this.image.visible = true;
      }
      
      protected function cleanupTexture() : void
      {
         if(this._isTextureOwner)
         {
            if(this._textureBitmapData)
            {
               this._textureBitmapData.dispose();
            }
            if(this._textureRawData)
            {
               this._textureRawData.clear();
            }
            if(this._texture)
            {
               this._texture.dispose();
            }
         }
         if(this._pendingBitmapDataTexture)
         {
            this._pendingBitmapDataTexture.dispose();
         }
         if(this._pendingRawTextureData)
         {
            this._pendingRawTextureData.clear();
         }
         this._currentTexture = null;
         this._currentTextureWidth = NaN;
         this._currentTextureHeight = NaN;
         this._pendingBitmapDataTexture = null;
         this._pendingRawTextureData = null;
         this._textureBitmapData = null;
         this._textureRawData = null;
         this._texture = null;
         this._isTextureOwner = false;
      }
      
      protected function verifyCurrentStarling() : void
      {
         if(!this.stage || Starling.current.stage === this.stage)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = Starling.all;
         for each(var _loc1_ in Starling.all)
         {
            if(_loc1_.stage === this.stage)
            {
               _loc1_.makeCurrent();
               break;
            }
         }
      }
      
      protected function replaceBitmapDataTexture(param1:BitmapData) : void
      {
         if(Starling.handleLostContext && !Starling.current.contextValid)
         {
            trace("ImageLoader: Context lost while processing loaded image, retrying...");
            return;
            §§push(setTimeout(replaceBitmapDataTexture,1,param1));
         }
         else
         {
            if(!SystemUtil.isDesktop && !SystemUtil.isApplicationActive)
            {
               SystemUtil.executeWhenApplicationIsActive(replaceBitmapDataTexture,param1);
               return;
            }
            this.verifyCurrentStarling();
            this._texture = Texture.fromBitmapData(param1,false,false,1,this._textureFormat);
            if(Starling.handleLostContext)
            {
               this._textureBitmapData = param1;
            }
            else
            {
               param1.dispose();
            }
            this._isTextureOwner = true;
            this._isLoaded = true;
            this.invalidate("data");
            this.dispatchEventWith("complete");
            return;
         }
      }
      
      protected function replaceRawTextureData(param1:ByteArray) : void
      {
         if(Starling.handleLostContext && !Starling.current.contextValid)
         {
            trace("ImageLoader: Context lost while processing loaded image, retrying...");
            return;
            §§push(setTimeout(replaceRawTextureData,1,param1));
         }
         else
         {
            if(!SystemUtil.isDesktop && !SystemUtil.isApplicationActive)
            {
               SystemUtil.executeWhenApplicationIsActive(replaceRawTextureData,param1);
               return;
            }
            this.verifyCurrentStarling();
            this._texture = Texture.fromAtfData(param1);
            if(Starling.handleLostContext)
            {
               this._textureRawData = param1;
            }
            else
            {
               param1.clear();
            }
            this._isTextureOwner = true;
            this._isLoaded = true;
            this.invalidate("data");
            this.dispatchEventWith("complete");
            return;
         }
      }
      
      protected function addToTextureQueue() : void
      {
         if(!this._delayTextureCreation)
         {
            throw new IllegalOperationError("Cannot add loader to delayed texture queue if delayTextureCreation is false.");
         }
         if(this._textureQueueDuration == Infinity)
         {
            throw new IllegalOperationError("Cannot add loader to delayed texture queue if textureQueueDuration is Number.POSITIVE_INFINITY.");
         }
         if(this._isInTextureQueue)
         {
            throw new IllegalOperationError("Cannot add loader to delayed texture queue more than once.");
         }
         this.addEventListener("removedFromStage",imageLoader_removedFromStageHandler);
         this._isInTextureQueue = true;
         if(textureQueueTail)
         {
            textureQueueTail._textureQueueNext = this;
            this._textureQueuePrevious = textureQueueTail;
            textureQueueTail = this;
         }
         else
         {
            textureQueueHead = this;
            textureQueueTail = this;
            this.preparePendingTexture();
         }
      }
      
      protected function removeFromTextureQueue() : void
      {
         if(!this._isInTextureQueue)
         {
            return;
         }
         var _loc2_:ImageLoader = this._textureQueuePrevious;
         var _loc1_:ImageLoader = this._textureQueueNext;
         this._textureQueuePrevious = null;
         this._textureQueueNext = null;
         this._isInTextureQueue = false;
         this.removeEventListener("removedFromStage",imageLoader_removedFromStageHandler);
         this.removeEventListener("enterFrame",processTextureQueue_enterFrameHandler);
         if(_loc2_)
         {
            _loc2_._textureQueueNext = _loc1_;
         }
         if(_loc1_)
         {
            _loc1_._textureQueuePrevious = _loc2_;
         }
         var _loc3_:* = textureQueueHead == this;
         var _loc4_:* = textureQueueTail == this;
         if(_loc4_)
         {
            textureQueueTail = _loc2_;
            if(_loc3_)
            {
               textureQueueHead = _loc2_;
            }
         }
         if(_loc3_)
         {
            textureQueueHead = _loc1_;
            if(_loc4_)
            {
               textureQueueTail = _loc1_;
            }
         }
         if(_loc3_ && textureQueueHead)
         {
            textureQueueHead.preparePendingTexture();
         }
      }
      
      protected function preparePendingTexture() : void
      {
         if(this._textureQueueDuration > 0)
         {
            this._accumulatedPrepareTextureTime = 0;
            this.addEventListener("enterFrame",processTextureQueue_enterFrameHandler);
         }
         else
         {
            this.processPendingTexture();
         }
      }
      
      protected function processPendingTexture() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this._pendingBitmapDataTexture)
         {
            _loc1_ = this._pendingBitmapDataTexture;
            this._pendingBitmapDataTexture = null;
            this.replaceBitmapDataTexture(_loc1_);
         }
         if(this._pendingRawTextureData)
         {
            _loc2_ = this._pendingRawTextureData;
            this._pendingRawTextureData = null;
            this.replaceRawTextureData(_loc2_);
         }
         if(this._isInTextureQueue)
         {
            this.removeFromTextureQueue();
         }
      }
      
      protected function processTextureQueue_enterFrameHandler(param1:EnterFrameEvent) : void
      {
         this._accumulatedPrepareTextureTime = this._accumulatedPrepareTextureTime + param1.passedTime;
         if(this._accumulatedPrepareTextureTime >= this._textureQueueDuration)
         {
            this.removeEventListener("enterFrame",processTextureQueue_enterFrameHandler);
            this.processPendingTexture();
         }
      }
      
      protected function imageLoader_removedFromStageHandler(param1:starling.events.Event) : void
      {
         if(this._isInTextureQueue)
         {
            this.removeFromTextureQueue();
         }
      }
      
      protected function loader_completeHandler(param1:flash.events.Event) : void
      {
         var _loc3_:Bitmap = Bitmap(this.loader.content);
         this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
         this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
         this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
         this.loader = null;
         this.cleanupTexture();
         var _loc2_:BitmapData = _loc3_.bitmapData;
         if(this._delayTextureCreation)
         {
            this._pendingBitmapDataTexture = _loc2_;
            if(this._textureQueueDuration < Infinity)
            {
               this.addToTextureQueue();
            }
         }
         else
         {
            this.replaceBitmapDataTexture(_loc2_);
         }
      }
      
      protected function loader_errorHandler(param1:ErrorEvent) : void
      {
         this.loader.contentLoaderInfo.removeEventListener("complete",loader_completeHandler);
         this.loader.contentLoaderInfo.removeEventListener("ioError",loader_errorHandler);
         this.loader.contentLoaderInfo.removeEventListener("securityError",loader_errorHandler);
         this.loader = null;
         this.cleanupTexture();
         this.invalidate("data");
         this.dispatchEventWith("error",false,param1);
      }
      
      protected function rawDataLoader_completeHandler(param1:flash.events.Event) : void
      {
         var _loc2_:ByteArray = ByteArray(this.urlLoader.data);
         this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
         this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
         this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
         this.urlLoader = null;
         this.cleanupTexture();
         if(this._delayTextureCreation)
         {
            this._pendingRawTextureData = _loc2_;
            if(this._textureQueueDuration < Infinity)
            {
               this.addToTextureQueue();
            }
         }
         else
         {
            this.replaceRawTextureData(_loc2_);
         }
      }
      
      protected function rawDataLoader_errorHandler(param1:ErrorEvent) : void
      {
         this.urlLoader.removeEventListener("complete",rawDataLoader_completeHandler);
         this.urlLoader.removeEventListener("ioError",rawDataLoader_errorHandler);
         this.urlLoader.removeEventListener("securityError",rawDataLoader_errorHandler);
         this.urlLoader = null;
         this.cleanupTexture();
         this.invalidate("data");
         this.dispatchEventWith("error",false,param1);
      }
   }
}
