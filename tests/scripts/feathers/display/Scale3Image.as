package feathers.display
{
   import feathers.core.IValidating;
   import feathers.core.ValidationQueue;
   import feathers.textures.Scale3Textures;
   import feathers.utils.display.getDisplayObjectDepthFromStage;
   import flash.errors.IllegalOperationError;
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
   public class Scale3Image extends Sprite implements IValidating
   {
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private static var helperImage:Image;
       
      
      private var _propertiesChanged:Boolean = true;
      
      private var _renderingChanged:Boolean = true;
      
      private var _layoutChanged:Boolean = true;
      
      private var _frame:Rectangle;
      
      private var _textures:Scale3Textures;
      
      private var _width:Number = NaN;
      
      private var _height:Number = NaN;
      
      private var _textureScale:Number = 1;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _useSeparateBatch:Boolean = true;
      
      private var _hitArea:Rectangle;
      
      private var _batch:QuadBatch;
      
      private var _isValidating:Boolean = false;
      
      private var _isInvalid:Boolean = false;
      
      private var _validationQueue:ValidationQueue;
      
      private var _depth:int = -1;
      
      public function Scale3Image(param1:Scale3Textures, param2:Number = 1)
      {
         super();
         this.textures = param1;
         this._textureScale = param2;
         this._hitArea = new Rectangle();
         this.readjustSize();
         this._batch = new QuadBatch();
         this._batch.touchable = false;
         this.addChild(this._batch);
         this.addEventListener("flatten",flattenHandler);
         this.addEventListener("addedToStage",addedToStageHandler);
      }
      
      public function get textures() : Scale3Textures
      {
         return this._textures;
      }
      
      public function set textures(param1:Scale3Textures) : void
      {
         if(!param1)
         {
            throw new IllegalOperationError("Scale3Image textures cannot be null.");
         }
         if(this._textures == param1)
         {
            return;
         }
         this._textures = param1;
         var _loc2_:Texture = this._textures.texture;
         this._frame = _loc2_.frame;
         if(!this._frame)
         {
            this._frame = new Rectangle(0,0,_loc2_.width,_loc2_.height);
         }
         this._layoutChanged = true;
         this._renderingChanged = true;
         this.invalidate();
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
         this.width = this._frame.width * _loc3_;
         this.height = this._frame.height * _loc2_;
         .super.transformationMatrix = _loc4_;
         this._layoutChanged = true;
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
         this._propertiesChanged = true;
         this.invalidate();
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
         this._renderingChanged = true;
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
         var _loc4_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
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
         if(this._propertiesChanged || this._layoutChanged || this._renderingChanged)
         {
            this._batch.batchable = !this._useSeparateBatch;
            this._batch.reset();
            if(!helperImage)
            {
               helperImage = new Image(this._textures.second);
            }
            helperImage.smoothing = this._smoothing;
            helperImage.color = this._color;
            if(this._textures.direction == "vertical")
            {
               _loc4_ = this._width;
               _loc1_ = _loc4_ / this._frame.width;
               _loc6_ = this._textures.firstRegionSize * _loc1_;
               _loc5_ = (this._frame.height - this._textures.firstRegionSize - this._textures.secondRegionSize) * _loc1_;
               _loc2_ = _loc6_ + _loc5_;
               if(_loc2_ > this._width)
               {
                  _loc3_ = this._width / _loc2_;
                  _loc6_ = _loc6_ * _loc3_;
                  _loc5_ = _loc5_ * _loc3_;
                  _loc2_ = _loc6_ + _loc5_;
               }
               _loc7_ = this._height - _loc2_;
               if(_loc4_ > 0)
               {
                  if(_loc6_ > 0)
                  {
                     helperImage.texture = this._textures.first;
                     helperImage.readjustSize();
                     helperImage.x = 0;
                     helperImage.y = 0;
                     helperImage.width = _loc4_;
                     helperImage.height = _loc6_;
                     this._batch.addImage(helperImage);
                  }
                  if(_loc7_ > 0)
                  {
                     helperImage.texture = this._textures.second;
                     helperImage.readjustSize();
                     helperImage.x = 0;
                     helperImage.y = _loc6_;
                     helperImage.width = _loc4_;
                     helperImage.height = _loc7_;
                     this._batch.addImage(helperImage);
                  }
                  if(_loc5_ > 0)
                  {
                     helperImage.texture = this._textures.third;
                     helperImage.readjustSize();
                     helperImage.x = 0;
                     helperImage.y = this._height - _loc5_;
                     helperImage.width = _loc4_;
                     helperImage.height = _loc5_;
                     this._batch.addImage(helperImage);
                  }
               }
            }
            else
            {
               _loc4_ = this._height;
               _loc1_ = _loc4_ / this._frame.height;
               _loc6_ = this._textures.firstRegionSize * _loc1_;
               _loc5_ = (this._frame.width - this._textures.firstRegionSize - this._textures.secondRegionSize) * _loc1_;
               _loc2_ = _loc6_ + _loc5_;
               if(_loc2_ > this._width)
               {
                  _loc3_ = this._width / _loc2_;
                  _loc6_ = _loc6_ * _loc3_;
                  _loc5_ = _loc5_ * _loc3_;
                  _loc2_ = _loc6_ + _loc5_;
               }
               _loc7_ = this._width - _loc2_;
               if(_loc4_ > 0)
               {
                  if(_loc6_ > 0)
                  {
                     helperImage.texture = this._textures.first;
                     helperImage.readjustSize();
                     helperImage.x = 0;
                     helperImage.y = 0;
                     helperImage.width = _loc6_;
                     helperImage.height = _loc4_;
                     this._batch.addImage(helperImage);
                  }
                  if(_loc7_ > 0)
                  {
                     helperImage.texture = this._textures.second;
                     helperImage.readjustSize();
                     helperImage.x = _loc6_;
                     helperImage.y = 0;
                     helperImage.width = _loc7_;
                     helperImage.height = _loc4_;
                     this._batch.addImage(helperImage);
                  }
                  if(_loc5_ > 0)
                  {
                     helperImage.texture = this._textures.third;
                     helperImage.readjustSize();
                     helperImage.x = _loc6_ + _loc7_;
                     helperImage.y = 0;
                     helperImage.width = _loc5_;
                     helperImage.height = _loc4_;
                     this._batch.addImage(helperImage);
                  }
               }
            }
         }
         this._propertiesChanged = false;
         this._layoutChanged = false;
         this._renderingChanged = false;
         this._isInvalid = false;
         this._isValidating = false;
      }
      
      public function readjustSize() : void
      {
         this.width = this._frame.width * this._textureScale;
         this.height = this._frame.height * this._textureScale;
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
