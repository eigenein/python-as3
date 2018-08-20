package starling.display
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.utils.VertexData;
   
   public class Quad extends DisplayObject
   {
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
       
      
      private var mTinted:Boolean;
      
      protected var mVertexData:VertexData;
      
      public function Quad(param1:Number, param2:Number, param3:uint = 16777215, param4:Boolean = true)
      {
         super();
         if(param1 == 0 || param2 == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         mTinted = param3 != 16777215;
         mVertexData = new VertexData(4,param4);
         mVertexData.setPosition(0,0,0);
         mVertexData.setPosition(1,param1,0);
         mVertexData.setPosition(2,0,param2);
         mVertexData.setPosition(3,param1,param2);
         mVertexData.setUniformColor(param3);
         onVertexDataChanged();
      }
      
      protected function onVertexDataChanged() : void
      {
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param2 == null)
         {
            param2 = new Rectangle();
         }
         if(param1 == this)
         {
            mVertexData.getPosition(3,sHelperPoint);
            param2.setTo(0,0,sHelperPoint.x,sHelperPoint.y);
         }
         else if(param1 == parent && rotation == 0)
         {
            _loc3_ = this.scaleX;
            _loc4_ = this.scaleY;
            mVertexData.getPosition(3,sHelperPoint);
            param2.setTo(x - pivotX * _loc3_,y - pivotY * _loc4_,sHelperPoint.x * _loc3_,sHelperPoint.y * _loc4_);
            if(_loc3_ < 0)
            {
               param2.width = param2.width * -1;
               param2.x = param2.x - param2.width;
            }
            if(_loc4_ < 0)
            {
               param2.height = param2.height * -1;
               param2.y = param2.y - param2.height;
            }
         }
         else if(is3D && stage)
         {
            stage.getCameraPosition(param1,sHelperPoint3D);
            getTransformationMatrix3D(param1,sHelperMatrix3D);
            mVertexData.getBoundsProjected(sHelperMatrix3D,sHelperPoint3D,0,4,param2);
         }
         else
         {
            getTransformationMatrix(param1,sHelperMatrix);
            mVertexData.getBounds(sHelperMatrix,0,4,param2);
         }
         return param2;
      }
      
      public function getVertexColor(param1:int) : uint
      {
         return mVertexData.getColor(param1);
      }
      
      public function setVertexColor(param1:int, param2:uint) : void
      {
         mVertexData.setColor(param1,param2);
         onVertexDataChanged();
         if(param2 != 16777215)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function getVertexAlpha(param1:int) : Number
      {
         return mVertexData.getAlpha(param1);
      }
      
      public function setVertexAlpha(param1:int, param2:Number) : void
      {
         mVertexData.setAlpha(param1,param2);
         onVertexDataChanged();
         if(param2 != 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function get color() : uint
      {
         return mVertexData.getColor(0);
      }
      
      public function set color(param1:uint) : void
      {
         mVertexData.setUniformColor(param1);
         onVertexDataChanged();
         if(param1 != 16777215 || alpha != 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      override public function set alpha(param1:Number) : void
      {
         .super.alpha = param1;
         if(param1 < 1)
         {
            mTinted = true;
         }
         else
         {
            mTinted = mVertexData.tinted;
         }
      }
      
      public function copyVertexDataTo(param1:VertexData, param2:int = 0) : void
      {
         mVertexData.copyTo(param1,param2);
      }
      
      public function copyVertexDataTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null) : void
      {
         mVertexData.copyTransformedTo(param1,param2,param3,0,4);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         param1.batchQuad(this,param2);
      }
      
      public function get tinted() : Boolean
      {
         return mTinted;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return mVertexData.premultipliedAlpha;
      }
   }
}
