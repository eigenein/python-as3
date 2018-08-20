package starling.display
{
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import flash.system.Capabilities;
   import flash.ui.Mouse;
   import flash.utils.getQualifiedClassName;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.errors.AbstractClassError;
   import starling.errors.AbstractMethodError;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   import starling.events.TouchEvent;
   import starling.filters.FragmentFilter;
   import starling.utils.MathUtil;
   import starling.utils.MatrixUtil;
   
   [Event(name="added",type="starling.events.Event")]
   [Event(name="addedToStage",type="starling.events.Event")]
   [Event(name="removed",type="starling.events.Event")]
   [Event(name="removedFromStage",type="starling.events.Event")]
   [Event(name="enterFrame",type="starling.events.EnterFrameEvent")]
   [Event(name="touch",type="starling.events.TouchEvent")]
   [Event(name="keyUp",type="starling.events.KeyboardEvent")]
   [Event(name="keyDown",type="starling.events.KeyboardEvent")]
   public class DisplayObject extends EventDispatcher
   {
      
      private static var sAncestors:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperRect:Rectangle = new Rectangle();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrixAlt:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
      
      private static var sHelperMatrixAlt3D:Matrix3D = new Matrix3D();
       
      
      private var mX:Number;
      
      private var mY:Number;
      
      private var mPivotX:Number;
      
      private var mPivotY:Number;
      
      private var mScaleX:Number;
      
      private var mScaleY:Number;
      
      private var mSkewX:Number;
      
      private var mSkewY:Number;
      
      private var mRotation:Number;
      
      private var mAlpha:Number;
      
      private var mVisible:Boolean;
      
      private var mTouchable:Boolean;
      
      private var mBlendMode:String;
      
      private var mName:String;
      
      private var mUseHandCursor:Boolean;
      
      private var mParent:DisplayObjectContainer;
      
      private var mTransformationMatrix:Matrix;
      
      private var mTransformationMatrix3D:Matrix3D;
      
      private var mOrientationChanged:Boolean;
      
      private var mFilter:FragmentFilter;
      
      private var mIs3D:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function DisplayObject()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.display::DisplayObject")
         {
            throw new AbstractClassError();
         }
         mSkewY = 0;
         mSkewX = 0;
         mRotation = 0;
         mPivotY = 0;
         mPivotX = 0;
         mY = 0;
         mX = 0;
         mAlpha = 1;
         mScaleY = 1;
         mScaleX = 1;
         mTouchable = true;
         mVisible = true;
         mBlendMode = "auto";
         mTransformationMatrix = new Matrix();
         mUseHandCursor = false;
         mOrientationChanged = false;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(mFilter)
         {
            mFilter.dispose();
            mFilter = null;
         }
         _disposed = true;
         removeEventListeners();
      }
      
      public function removeFromParent(param1:Boolean = false) : void
      {
         if(mParent)
         {
            mParent.removeChild(this,param1);
         }
         else if(param1)
         {
            this.dispose();
         }
      }
      
      public function getTransformationMatrix(param1:DisplayObject, param2:Matrix = null) : Matrix
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2)
         {
            param2.identity();
         }
         else
         {
            param2 = new Matrix();
         }
         if(param1 == this)
         {
            return param2;
         }
         if(param1 == mParent || param1 == null && mParent == null)
         {
            param2.copyFrom(transformationMatrix);
            return param2;
         }
         if(param1 == null || param1 == base)
         {
            _loc4_ = this;
            while(_loc4_ != param1)
            {
               param2.concat(_loc4_.transformationMatrix);
               _loc4_ = _loc4_.mParent;
            }
            return param2;
         }
         if(param1.mParent == this)
         {
            param1.getTransformationMatrix(this,param2);
            param2.invert();
            return param2;
         }
         _loc3_ = findCommonParent(this,param1);
         _loc4_ = this;
         while(_loc4_ != _loc3_)
         {
            param2.concat(_loc4_.transformationMatrix);
            _loc4_ = _loc4_.mParent;
         }
         if(_loc3_ == param1)
         {
            return param2;
         }
         sHelperMatrix.identity();
         _loc4_ = param1;
         while(_loc4_ != _loc3_)
         {
            sHelperMatrix.concat(_loc4_.transformationMatrix);
            _loc4_ = _loc4_.mParent;
         }
         sHelperMatrix.invert();
         param2.concat(sHelperMatrix);
         return param2;
      }
      
      public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         throw new AbstractMethodError();
      }
      
      public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!mVisible || !mTouchable))
         {
            return null;
         }
         if(getBounds(this,sHelperRect).containsPoint(param1))
         {
            return this;
         }
         return null;
      }
      
      public function localToGlobal(param1:Point, param2:Point = null) : Point
      {
         if(is3D)
         {
            sHelperPoint3D.setTo(param1.x,param1.y,0);
            return local3DToGlobal(sHelperPoint3D,param2);
         }
         getTransformationMatrix(base,sHelperMatrixAlt);
         return MatrixUtil.transformPoint(sHelperMatrixAlt,param1,param2);
      }
      
      public function globalToLocal(param1:Point, param2:Point = null) : Point
      {
         if(is3D)
         {
            globalToLocal3D(param1,sHelperPoint3D);
            return MathUtil.intersectLineWithXYPlane(stage.cameraPosition,sHelperPoint3D,param2);
         }
         getTransformationMatrix(base,sHelperMatrixAlt);
         sHelperMatrixAlt.invert();
         return MatrixUtil.transformPoint(sHelperMatrixAlt,param1,param2);
      }
      
      public function render(param1:RenderSupport, param2:Number) : void
      {
         throw new AbstractMethodError();
      }
      
      public function get hasVisibleArea() : Boolean
      {
         return mAlpha != 0 && mVisible && mScaleX != 0 && mScaleY != 0;
      }
      
      public function alignPivot(param1:String = "center", param2:String = "center") : void
      {
         var _loc3_:Rectangle = getBounds(this);
         mOrientationChanged = true;
         if(param1 == "left")
         {
            mPivotX = _loc3_.x;
         }
         else if(param1 == "center")
         {
            mPivotX = _loc3_.x + _loc3_.width / 2;
         }
         else if(param1 == "right")
         {
            mPivotX = _loc3_.x + _loc3_.width;
         }
         else
         {
            throw new ArgumentError("Invalid horizontal alignment: " + param1);
         }
         if(param2 == "top")
         {
            mPivotY = _loc3_.y;
         }
         else if(param2 == "center")
         {
            mPivotY = _loc3_.y + _loc3_.height / 2;
         }
         else if(param2 == "bottom")
         {
            mPivotY = _loc3_.y + _loc3_.height;
         }
         else
         {
            throw new ArgumentError("Invalid vertical alignment: " + param2);
         }
      }
      
      public function getTransformationMatrix3D(param1:DisplayObject, param2:Matrix3D = null) : Matrix3D
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param2)
         {
            param2.identity();
         }
         else
         {
            param2 = new Matrix3D();
         }
         if(param1 == this)
         {
            return param2;
         }
         if(param1 == mParent || param1 == null && mParent == null)
         {
            param2.copyFrom(transformationMatrix3D);
            return param2;
         }
         if(param1 == null || param1 == base)
         {
            _loc4_ = this;
            while(_loc4_ != param1)
            {
               param2.append(_loc4_.transformationMatrix3D);
               _loc4_ = _loc4_.mParent;
            }
            return param2;
         }
         if(param1.mParent == this)
         {
            param1.getTransformationMatrix3D(this,param2);
            param2.invert();
            return param2;
         }
         _loc3_ = findCommonParent(this,param1);
         _loc4_ = this;
         while(_loc4_ != _loc3_)
         {
            param2.append(_loc4_.transformationMatrix3D);
            _loc4_ = _loc4_.mParent;
         }
         if(_loc3_ == param1)
         {
            return param2;
         }
         sHelperMatrix3D.identity();
         _loc4_ = param1;
         while(_loc4_ != _loc3_)
         {
            sHelperMatrix3D.append(_loc4_.transformationMatrix3D);
            _loc4_ = _loc4_.mParent;
         }
         sHelperMatrix3D.invert();
         param2.append(sHelperMatrix3D);
         return param2;
      }
      
      public function local3DToGlobal(param1:Vector3D, param2:Point = null) : Point
      {
         var _loc3_:Stage = this.stage;
         if(_loc3_ == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         getTransformationMatrix3D(_loc3_,sHelperMatrixAlt3D);
         MatrixUtil.transformPoint3D(sHelperMatrixAlt3D,param1,sHelperPoint3D);
         return MathUtil.intersectLineWithXYPlane(_loc3_.cameraPosition,sHelperPoint3D,param2);
      }
      
      public function globalToLocal3D(param1:Point, param2:Vector3D = null) : Vector3D
      {
         var _loc3_:Stage = this.stage;
         if(_loc3_ == null)
         {
            throw new IllegalOperationError("Object not connected to stage");
         }
         getTransformationMatrix3D(_loc3_,sHelperMatrixAlt3D);
         sHelperMatrixAlt3D.invert();
         return MatrixUtil.transformCoords3D(sHelperMatrixAlt3D,param1.x,param1.y,0,param2);
      }
      
      function setParent(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObject = param1;
         while(_loc2_ != this && _loc2_ != null)
         {
            _loc2_ = _loc2_.mParent;
         }
         if(_loc2_ == this)
         {
            throw new ArgumentError("An object cannot be added as a child to itself or one of its children (or children\'s children, etc.)");
         }
         mParent = param1;
      }
      
      function setIs3D(param1:Boolean) : void
      {
         mIs3D = param1;
      }
      
      private final function isEquivalent(param1:Number, param2:Number, param3:Number = 1.0E-4) : Boolean
      {
         return param1 - param3 < param2 && param1 + param3 > param2;
      }
      
      private final function findCommonParent(param1:DisplayObject, param2:DisplayObject) : DisplayObject
      {
         var _loc3_:* = param1;
         while(_loc3_)
         {
            sAncestors[sAncestors.length] = _loc3_;
            _loc3_ = _loc3_.mParent;
         }
         _loc3_ = param2;
         while(_loc3_ && sAncestors.indexOf(_loc3_) == -1)
         {
            _loc3_ = _loc3_.mParent;
         }
         sAncestors.length = 0;
         if(_loc3_)
         {
            return _loc3_;
         }
         throw new ArgumentError("Object not connected to target");
      }
      
      override public function dispatchEvent(param1:Event) : void
      {
         if(param1.type == "removedFromStage" && stage == null)
         {
            return;
         }
         super.dispatchEvent(param1);
      }
      
      override public function addEventListener(param1:String, param2:Function) : void
      {
         if(param1 == "enterFrame" && !hasEventListener(param1))
         {
            addEventListener("addedToStage",addEnterFrameListenerToStage);
            addEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            if(this.stage)
            {
               addEnterFrameListenerToStage();
            }
         }
         super.addEventListener(param1,param2);
      }
      
      override public function removeEventListener(param1:String, param2:Function) : void
      {
         super.removeEventListener(param1,param2);
         if(param1 == "enterFrame" && !hasEventListener(param1))
         {
            removeEventListener("addedToStage",addEnterFrameListenerToStage);
            removeEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            removeEnterFrameListenerFromStage();
         }
      }
      
      override public function removeEventListeners(param1:String = null) : void
      {
         if((param1 == null || param1 == "enterFrame") && hasEventListener("enterFrame"))
         {
            removeEventListener("addedToStage",addEnterFrameListenerToStage);
            removeEventListener("removedFromStage",removeEnterFrameListenerFromStage);
            removeEnterFrameListenerFromStage();
         }
         super.removeEventListeners(param1);
      }
      
      private function addEnterFrameListenerToStage() : void
      {
         Starling.current.stage.addEnterFrameListener(this);
      }
      
      private function removeEnterFrameListenerFromStage() : void
      {
         Starling.current.stage.removeEnterFrameListener(this);
      }
      
      public function get transformationMatrix() : Matrix
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(mOrientationChanged)
         {
            mOrientationChanged = false;
            if(mSkewX == 0 && mSkewY == 0)
            {
               if(mRotation == 0)
               {
                  mTransformationMatrix.setTo(mScaleX,0,0,mScaleY,mX - mPivotX * mScaleX,mY - mPivotY * mScaleY);
               }
               else
               {
                  _loc7_ = Math.cos(mRotation);
                  _loc8_ = Math.sin(mRotation);
                  _loc1_ = mScaleX * _loc7_;
                  _loc2_ = mScaleX * _loc8_;
                  _loc3_ = mScaleY * -_loc8_;
                  _loc4_ = mScaleY * _loc7_;
                  _loc5_ = mX - mPivotX * _loc1_ - mPivotY * _loc3_;
                  _loc6_ = mY - mPivotX * _loc2_ - mPivotY * _loc4_;
                  mTransformationMatrix.setTo(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
               }
            }
            else
            {
               mTransformationMatrix.identity();
               mTransformationMatrix.scale(mScaleX,mScaleY);
               MatrixUtil.skew(mTransformationMatrix,mSkewX + mRotation,mSkewY + mRotation);
               mTransformationMatrix.translate(mX,mY);
               if(mPivotX != 0 || mPivotY != 0)
               {
                  mTransformationMatrix.tx = mX - mTransformationMatrix.a * mPivotX - mTransformationMatrix.c * mPivotY;
                  mTransformationMatrix.ty = mY - mTransformationMatrix.b * mPivotX - mTransformationMatrix.d * mPivotY;
               }
            }
         }
         return mTransformationMatrix;
      }
      
      public function set transformationMatrix(param1:Matrix) : void
      {
         var _loc2_:* = NaN;
         _loc2_ = 0.785398163397448;
         mOrientationChanged = false;
         mTransformationMatrix.a = param1.a;
         mTransformationMatrix.b = param1.b;
         mTransformationMatrix.c = param1.c;
         mTransformationMatrix.d = param1.d;
         mTransformationMatrix.tx = param1.tx;
         mTransformationMatrix.ty = param1.ty;
         mPivotY = 0;
         mPivotX = 0;
         mX = param1.tx;
         mY = param1.ty;
         mSkewX = Math.atan(-param1.c / param1.d);
         mSkewY = Math.atan(param1.b / param1.a);
         if(mSkewX != mSkewX)
         {
            mSkewX = 0;
         }
         if(mSkewY != mSkewY)
         {
            mSkewY = 0;
         }
         mScaleY = mSkewX > -0.785398163397448 && mSkewX < 0.785398163397448?param1.d / Math.cos(mSkewX):Number(-param1.c / Math.sin(mSkewX));
         mScaleX = mSkewY > -0.785398163397448 && mSkewY < 0.785398163397448?param1.a / Math.cos(mSkewY):Number(param1.b / Math.sin(mSkewY));
         if(isEquivalent(mSkewX,mSkewY))
         {
            mRotation = mSkewX;
            mSkewY = 0;
            mSkewX = 0;
         }
         else
         {
            mRotation = 0;
         }
      }
      
      public function get transformationMatrix3D() : Matrix3D
      {
         if(mTransformationMatrix3D == null)
         {
            mTransformationMatrix3D = new Matrix3D();
         }
         return MatrixUtil.convertTo3D(transformationMatrix,mTransformationMatrix3D);
      }
      
      public function get is3D() : Boolean
      {
         return mIs3D;
      }
      
      public function get useHandCursor() : Boolean
      {
         return mUseHandCursor;
      }
      
      public function set useHandCursor(param1:Boolean) : void
      {
         if(param1 == mUseHandCursor)
         {
            return;
         }
         mUseHandCursor = param1;
         if(mUseHandCursor)
         {
            addEventListener("touch",__onTouch);
         }
         else
         {
            removeEventListener("touch",__onTouch);
         }
      }
      
      private function __onTouch(param1:TouchEvent) : void
      {
         Mouse.cursor = !!param1.interactsWith(this)?"button":"auto";
      }
      
      public function get bounds() : Rectangle
      {
         return getBounds(mParent);
      }
      
      public function get width() : Number
      {
         return getBounds(mParent,sHelperRect).width;
      }
      
      public function set width(param1:Number) : void
      {
         scaleX = 1;
         var _loc2_:Number = width;
         if(_loc2_ != 0)
         {
            scaleX = param1 / _loc2_;
         }
      }
      
      public function get height() : Number
      {
         return getBounds(mParent,sHelperRect).height;
      }
      
      public function set height(param1:Number) : void
      {
         scaleY = 1;
         var _loc2_:Number = height;
         if(_loc2_ != 0)
         {
            scaleY = param1 / _loc2_;
         }
      }
      
      public function get x() : Number
      {
         return mX;
      }
      
      public function set x(param1:Number) : void
      {
         if(mX != param1)
         {
            mX = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get y() : Number
      {
         return mY;
      }
      
      public function set y(param1:Number) : void
      {
         if(mY != param1)
         {
            mY = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get pivotX() : Number
      {
         return mPivotX;
      }
      
      public function set pivotX(param1:Number) : void
      {
         if(mPivotX != param1)
         {
            mPivotX = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get pivotY() : Number
      {
         return mPivotY;
      }
      
      public function set pivotY(param1:Number) : void
      {
         if(mPivotY != param1)
         {
            mPivotY = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get scaleX() : Number
      {
         return mScaleX;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(mScaleX != param1)
         {
            mScaleX = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get scaleY() : Number
      {
         return mScaleY;
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(mScaleY != param1)
         {
            mScaleY = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get skewX() : Number
      {
         return mSkewX;
      }
      
      public function set skewX(param1:Number) : void
      {
         param1 = MathUtil.normalizeAngle(param1);
         if(mSkewX != param1)
         {
            mSkewX = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get skewY() : Number
      {
         return mSkewY;
      }
      
      public function set skewY(param1:Number) : void
      {
         param1 = MathUtil.normalizeAngle(param1);
         if(mSkewY != param1)
         {
            mSkewY = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get rotation() : Number
      {
         return mRotation;
      }
      
      public function set rotation(param1:Number) : void
      {
         param1 = MathUtil.normalizeAngle(param1);
         if(mRotation != param1)
         {
            mRotation = param1;
            mOrientationChanged = true;
         }
      }
      
      public function get alpha() : Number
      {
         return mAlpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         mAlpha = param1 < 0?0:Number(param1 > 1?1:Number(param1));
      }
      
      public function get visible() : Boolean
      {
         return mVisible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         mVisible = param1;
      }
      
      public function get touchable() : Boolean
      {
         return mTouchable;
      }
      
      public function set touchable(param1:Boolean) : void
      {
         mTouchable = param1;
      }
      
      public function get blendMode() : String
      {
         return mBlendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         mBlendMode = param1;
      }
      
      public function get name() : String
      {
         return mName;
      }
      
      public function set name(param1:String) : void
      {
         mName = param1;
      }
      
      public function get filter() : FragmentFilter
      {
         return mFilter;
      }
      
      public function set filter(param1:FragmentFilter) : void
      {
         mFilter = param1;
         if(mFilter)
         {
            mFilter.target = this;
         }
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return mParent;
      }
      
      public function get base() : DisplayObject
      {
         var _loc1_:* = this;
         while(_loc1_.mParent)
         {
            _loc1_ = _loc1_.mParent;
         }
         return _loc1_;
      }
      
      public function get root() : DisplayObject
      {
         var _loc1_:* = this;
         while(_loc1_.mParent)
         {
            if(_loc1_.mParent is Stage)
            {
               return _loc1_;
            }
            _loc1_ = _loc1_.parent;
         }
         return null;
      }
      
      public function get stage() : Stage
      {
         return this.base as Stage;
      }
   }
}
