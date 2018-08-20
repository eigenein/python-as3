package feathers.display
{
   import feathers.core.IValidating;
   import feathers.core.ValidationQueue;
   import feathers.utils.display.getDisplayObjectDepthFromStage;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   import starling.utils.MathUtil;
   import starling.utils.MatrixUtil;
   
   [Exclude(kind="property",name="numChildren")]
   [Exclude(kind="property",name="isFlattened")]
   [Exclude(kind="method",name="addChild")]
   [Exclude(kind="method",name="addChildAt")]
   [Exclude(kind="method",name="broadcastEvent")]
   [Exclude(kind="method",name="broadcastEventWith")]
   [Exclude(kind="method",name="contains")]
   [Exclude(kind="method",name="getChildAt")]
   [Exclude(kind="method",name="getChildByName")]
   [Exclude(kind="method",name="getChildIndex")]
   [Exclude(kind="method",name="removeChild")]
   [Exclude(kind="method",name="removeChildAt")]
   [Exclude(kind="method",name="removeChildren")]
   [Exclude(kind="method",name="setChildIndex")]
   [Exclude(kind="method",name="sortChildren")]
   [Exclude(kind="method",name="swapChildren")]
   [Exclude(kind="method",name="swapChildrenAt")]
   [Exclude(kind="method",name="flatten")]
   [Exclude(kind="method",name="unflatten")]
   public class TiledImage extends Sprite implements IValidating
   {
      
      private static const HELPER_POINT:Point = new Point();
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
       
      
      private var _propertiesChanged:Boolean = true;
      
      private var _layoutChanged:Boolean = true;
      
      private var _hitArea:Rectangle;
      
      private var _batch:QuadBatch;
      
      private var _image:Image;
      
      private var _originalImageWidth:Number;
      
      private var _originalImageHeight:Number;
      
      private var _width:Number = NaN;
      
      private var _height:Number = NaN;
      
      private var _texture:Texture;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _useSeparateBatch:Boolean = true;
      
      private var _textureScale:Number = 1;
      
      private var _isValidating:Boolean = false;
      
      private var _isInvalid:Boolean = false;
      
      private var _validationQueue:ValidationQueue;
      
      private var _depth:int = -1;
      
      public function TiledImage(param1:Texture, param2:Number = 1)
      {
         super();
         this._hitArea = new Rectangle();
         this._textureScale = param2;
         this.texture = param1;
         this.initializeWidthAndHeight();
         this._batch = new QuadBatch();
         this._batch.touchable = false;
         this.addChild(this._batch);
         this.addEventListener("flatten",flattenHandler);
         this.addEventListener("addedToStage",addedToStageHandler);
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width == param1)
         {
            return;
         }
         var _loc2_:* = param1;
         this._hitArea.width = _loc2_;
         this._width = _loc2_;
         this._layoutChanged = true;
         this.invalidate();
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._height == param1)
         {
            return;
         }
         var _loc2_:* = param1;
         this._hitArea.height = _loc2_;
         this._height = _loc2_;
         this._layoutChanged = true;
         this.invalidate();
      }
      
      override public function set transformationMatrix(param1:Matrix) : void
      {
         var _loc4_:Matrix = MathUtil.matrix;
         var _loc3_:Number = Math.sqrt(param1.a * param1.a + param1.b * param1.b);
         var _loc2_:Number = Math.sqrt(param1.c * param1.c + param1.d * param1.d);
         _loc4_.a = param1.a / _loc3_;
         _loc4_.b = param1.b / _loc3_;
         _loc4_.c = param1.c / _loc2_;
         _loc4_.d = param1.d / _loc2_;
         _loc4_.tx = param1.tx;
         _loc4_.ty = param1.ty;
         this.width = this._texture.width * _loc3_;
         this.height = this._texture.height * _loc2_;
         .super.transformationMatrix = _loc4_;
         this._layoutChanged = true;
         this.invalidate();
      }
      
      public function get texture() : Texture
      {
         return this._texture;
      }
      
      public function set texture(param1:Texture) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         if(this._texture == param1)
         {
            return;
         }
         this._texture = param1;
         if(!this._image)
         {
            this._image = new Image(param1);
            this._image.touchable = false;
         }
         else
         {
            this._image.texture = param1;
            this._image.readjustSize();
         }
         var _loc2_:Rectangle = param1.frame;
         if(!_loc2_)
         {
            this._originalImageWidth = param1.width;
            this._originalImageHeight = param1.height;
         }
         else
         {
            this._originalImageWidth = _loc2_.width;
            this._originalImageHeight = _loc2_.height;
         }
         this._layoutChanged = true;
         this.invalidate();
      }
      
      public function get smoothing() : String
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(TextureSmoothing.isValid(param1))
         {
            this._smoothing = param1;
            this._propertiesChanged = true;
            this.invalidate();
            return;
         }
         throw new ArgumentError("Invalid smoothing mode: " + param1);
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
         this._propertiesChanged = true;
         this.invalidate();
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
         this._propertiesChanged = true;
         this.invalidate();
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
         this._layoutChanged = true;
         this.invalidate();
      }
      
      public function get depth() : int
      {
         return this._depth;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         if(!param2)
         {
            param2 = new Rectangle();
         }
         var _loc4_:* = 1.79769313486232e308;
         var _loc6_:* = -1.79769313486232e308;
         var _loc3_:* = 1.79769313486232e308;
         var _loc5_:* = -1.79769313486232e308;
         if(param1 == this)
         {
            _loc4_ = Number(this._hitArea.x);
            _loc3_ = Number(this._hitArea.y);
            _loc6_ = Number(this._hitArea.x + this._hitArea.width);
            _loc5_ = Number(this._hitArea.y + this._hitArea.height);
         }
         else
         {
            this.getTransformationMatrix(param1,HELPER_MATRIX);
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x,this._hitArea.y,HELPER_POINT);
            _loc4_ = Number(_loc4_ < HELPER_POINT.x?_loc4_:Number(HELPER_POINT.x));
            _loc6_ = Number(_loc6_ > HELPER_POINT.x?_loc6_:Number(HELPER_POINT.x));
            _loc3_ = Number(_loc3_ < HELPER_POINT.y?_loc3_:Number(HELPER_POINT.y));
            _loc5_ = Number(_loc5_ > HELPER_POINT.y?_loc5_:Number(HELPER_POINT.y));
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x,this._hitArea.y + this._hitArea.height,HELPER_POINT);
            _loc4_ = Number(_loc4_ < HELPER_POINT.x?_loc4_:Number(HELPER_POINT.x));
            _loc6_ = Number(_loc6_ > HELPER_POINT.x?_loc6_:Number(HELPER_POINT.x));
            _loc3_ = Number(_loc3_ < HELPER_POINT.y?_loc3_:Number(HELPER_POINT.y));
            _loc5_ = Number(_loc5_ > HELPER_POINT.y?_loc5_:Number(HELPER_POINT.y));
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x + this._hitArea.width,this._hitArea.y,HELPER_POINT);
            _loc4_ = Number(_loc4_ < HELPER_POINT.x?_loc4_:Number(HELPER_POINT.x));
            _loc6_ = Number(_loc6_ > HELPER_POINT.x?_loc6_:Number(HELPER_POINT.x));
            _loc3_ = Number(_loc3_ < HELPER_POINT.y?_loc3_:Number(HELPER_POINT.y));
            _loc5_ = Number(_loc5_ > HELPER_POINT.y?_loc5_:Number(HELPER_POINT.y));
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x + this._hitArea.width,this._hitArea.y + this._hitArea.height,HELPER_POINT);
            _loc4_ = Number(_loc4_ < HELPER_POINT.x?_loc4_:Number(HELPER_POINT.x));
            _loc6_ = Number(_loc6_ > HELPER_POINT.x?_loc6_:Number(HELPER_POINT.x));
            _loc3_ = Number(_loc3_ < HELPER_POINT.y?_loc3_:Number(HELPER_POINT.y));
            _loc5_ = Number(_loc5_ > HELPER_POINT.y?_loc5_:Number(HELPER_POINT.y));
         }
         param2.x = _loc4_;
         param2.y = _loc3_;
         param2.width = _loc6_ - _loc4_;
         param2.height = _loc5_ - _loc3_;
         return param2;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!this.visible || !this.touchable))
         {
            return null;
         }
         return !!this._hitArea.containsPoint(param1)?this:null;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this.width = param1;
         this.height = param2;
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(this._isInvalid)
         {
            this.validate();
         }
         super.render(param1,param2);
      }
      
      public function validate() : void
      {
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = NaN;
         var _loc5_:* = NaN;
         var _loc14_:* = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:int = 0;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!this._isInvalid)
         {
            return;
         }
         if(this._isValidating)
         {
            if(this._validationQueue)
            {
               this._validationQueue.addControl(this,true);
            }
            return;
         }
         this._isValidating = true;
         if(this._propertiesChanged)
         {
            this._image.smoothing = this._smoothing;
            this._image.color = this._color;
         }
         if(this._propertiesChanged || this._layoutChanged)
         {
            this._batch.batchable = !this._useSeparateBatch;
            this._batch.reset();
            var _loc15_:* = this._textureScale;
            this._image.scaleY = _loc15_;
            this._image.scaleX = _loc15_;
            _loc8_ = this._originalImageWidth * this._textureScale;
            _loc11_ = this._originalImageHeight * this._textureScale;
            _loc12_ = Math.ceil(this._width / _loc8_);
            _loc9_ = Math.ceil(this._height / _loc11_);
            _loc1_ = _loc12_ * _loc9_;
            _loc2_ = 0;
            _loc5_ = 0;
            _loc14_ = Number(_loc2_ + _loc8_);
            _loc13_ = _loc5_ + _loc11_;
            _loc6_ = 0;
            while(_loc6_ < _loc1_)
            {
               this._image.x = _loc2_;
               this._image.y = _loc5_;
               _loc3_ = _loc14_ >= this._width?this._width - _loc2_:Number(_loc8_);
               _loc7_ = _loc13_ >= this._height?this._height - _loc5_:Number(_loc11_);
               this._image.width = _loc3_;
               this._image.height = _loc7_;
               _loc10_ = _loc3_ / _loc8_;
               _loc4_ = _loc7_ / _loc11_;
               HELPER_POINT.x = _loc10_;
               HELPER_POINT.y = 0;
               this._image.setTexCoords(1,HELPER_POINT);
               HELPER_POINT.y = _loc4_;
               this._image.setTexCoords(3,HELPER_POINT);
               HELPER_POINT.x = 0;
               this._image.setTexCoords(2,HELPER_POINT);
               this._batch.addImage(this._image);
               if(_loc14_ >= this._width)
               {
                  _loc2_ = 0;
                  _loc14_ = _loc8_;
                  _loc5_ = _loc13_;
                  _loc13_ = _loc13_ + _loc11_;
               }
               else
               {
                  _loc2_ = _loc14_;
                  _loc14_ = Number(_loc14_ + _loc8_);
               }
               _loc6_++;
            }
         }
         this._layoutChanged = false;
         this._propertiesChanged = false;
         this._isInvalid = false;
         this._isValidating = false;
      }
      
      protected function invalidate() : void
      {
         if(this._isInvalid)
         {
            return;
         }
         this._isInvalid = true;
         if(!this._validationQueue)
         {
            return;
         }
         this._validationQueue.addControl(this,false);
      }
      
      private function initializeWidthAndHeight() : void
      {
         this.width = this._originalImageWidth * this._textureScale;
         this.height = this._originalImageHeight * this._textureScale;
      }
      
      private function flattenHandler(param1:Event) : void
      {
         this.validate();
      }
      
      private function addedToStageHandler(param1:Event) : void
      {
         this._depth = getDisplayObjectDepthFromStage(this);
         this._validationQueue = ValidationQueue.forStarling(Starling.current);
         if(this._isInvalid)
         {
            this._validationQueue.addControl(this,false);
         }
      }
   }
}
