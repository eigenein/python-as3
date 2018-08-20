package starling.display
{
   import flash.display.BitmapData;
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.events.EnterFrameEvent;
   import starling.filters.FragmentFilter;
   import starling.utils.MatrixUtil;
   
   [Event(name="resize",type="starling.events.ResizeEvent")]
   public class Stage extends DisplayObjectContainer
   {
      
      private static var sHelperMatrix:Matrix3D = new Matrix3D();
       
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mColor:uint;
      
      private var mFieldOfView:Number;
      
      private var mProjectionOffset:Point;
      
      private var mCameraPosition:Vector3D;
      
      private var mEnterFrameEvent:EnterFrameEvent;
      
      private var mEnterFrameListeners:Vector.<DisplayObject>;
      
      public function Stage(param1:int, param2:int, param3:uint = 0)
      {
         super();
         mWidth = param1;
         mHeight = param2;
         mColor = param3;
         mFieldOfView = 1;
         mProjectionOffset = new Point();
         mCameraPosition = new Vector3D();
         mEnterFrameEvent = new EnterFrameEvent("enterFrame",0);
         mEnterFrameListeners = new Vector.<DisplayObject>(0);
      }
      
      public function advanceTime(param1:Number) : void
      {
         mEnterFrameEvent.reset("enterFrame",false,param1);
         broadcastEvent(mEnterFrameEvent);
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(param1.x < 0 || param1.x > mWidth || param1.y < 0 || param1.y > mHeight)
         {
            return null;
         }
         var _loc3_:DisplayObject = super.hitTest(param1,param2);
         if(_loc3_ == null)
         {
            _loc3_ = this;
         }
         return _loc3_;
      }
      
      public function drawToBitmapData(param1:BitmapData = null, param2:Boolean = true) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:RenderSupport = new RenderSupport();
         var _loc3_:Starling = Starling.current;
         if(param1 == null)
         {
            _loc4_ = _loc3_.backBufferWidth * _loc3_.backBufferPixelsPerPoint;
            _loc6_ = _loc3_.backBufferHeight * _loc3_.backBufferPixelsPerPoint;
            param1 = new BitmapData(_loc4_,_loc6_,param2);
         }
         _loc5_.renderTarget = null;
         _loc5_.setProjectionMatrix(0,0,mWidth,mHeight,mWidth,mHeight,cameraPosition);
         if(param2)
         {
            _loc5_.clearInstance();
         }
         else
         {
            _loc5_.clearInstance(mColor,1);
         }
         render(_loc5_,1);
         _loc5_.finishQuadBatch();
         _loc5_.dispose();
         Starling.context.drawToBitmapData(param1);
         Starling.context.present();
         return param1;
      }
      
      public function getCameraPosition(param1:DisplayObject = null, param2:Vector3D = null) : Vector3D
      {
         getTransformationMatrix3D(param1,sHelperMatrix);
         return MatrixUtil.transformCoords3D(sHelperMatrix,mWidth / 2 + mProjectionOffset.x,mHeight / 2 + mProjectionOffset.y,-focalLength,param2);
      }
      
      function addEnterFrameListener(param1:DisplayObject) : void
      {
         mEnterFrameListeners.push(param1);
      }
      
      function removeEnterFrameListener(param1:DisplayObject) : void
      {
         var _loc2_:int = mEnterFrameListeners.indexOf(param1);
         if(_loc2_ >= 0)
         {
            mEnterFrameListeners.splice(_loc2_,1);
         }
      }
      
      override function getChildEventListeners(param1:DisplayObject, param2:String, param3:Vector.<DisplayObject>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2 == "enterFrame" && param1 == this)
         {
            _loc5_ = 0;
            _loc4_ = mEnterFrameListeners.length;
            while(_loc5_ < _loc4_)
            {
               param3[param3.length] = mEnterFrameListeners[_loc5_];
               _loc5_++;
            }
         }
         else
         {
            super.getChildEventListeners(param1,param2,param3);
         }
      }
      
      override public function set width(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot set width of stage");
      }
      
      override public function set height(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot set height of stage");
      }
      
      override public function set x(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot set x-coordinate of stage");
      }
      
      override public function set y(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot set y-coordinate of stage");
      }
      
      override public function set scaleX(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set scaleY(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot scale stage");
      }
      
      override public function set rotation(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot rotate stage");
      }
      
      override public function set skewX(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set skewY(param1:Number) : void
      {
         throw new IllegalOperationError("Cannot skew stage");
      }
      
      override public function set filter(param1:FragmentFilter) : void
      {
         throw new IllegalOperationError("Cannot add filter to stage. Add it to \'root\' instead!");
      }
      
      public function get color() : uint
      {
         return mColor;
      }
      
      public function set color(param1:uint) : void
      {
         mColor = param1;
      }
      
      public function get stageWidth() : int
      {
         return mWidth;
      }
      
      public function set stageWidth(param1:int) : void
      {
         mWidth = param1;
      }
      
      public function get stageHeight() : int
      {
         return mHeight;
      }
      
      public function set stageHeight(param1:int) : void
      {
         mHeight = param1;
      }
      
      public function get focalLength() : Number
      {
         return mWidth / (2 * Math.tan(mFieldOfView / 2));
      }
      
      public function set focalLength(param1:Number) : void
      {
         mFieldOfView = 2 * Math.atan(stageWidth / (2 * param1));
      }
      
      public function get fieldOfView() : Number
      {
         return mFieldOfView;
      }
      
      public function set fieldOfView(param1:Number) : void
      {
         mFieldOfView = param1;
      }
      
      public function get projectionOffset() : Point
      {
         return mProjectionOffset;
      }
      
      public function set projectionOffset(param1:Point) : void
      {
         mProjectionOffset.setTo(param1.x,param1.y);
      }
      
      public function get cameraPosition() : Vector3D
      {
         return getCameraPosition(null,mCameraPosition);
      }
   }
}
