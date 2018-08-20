package starling.custom
{
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   import starling.core.RenderSupport;
   import starling.display.DisplayObject;
   
   public class ByteQuad extends DisplayObject
   {
      
      public static const BYTE_SIZE:uint = 80;
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sHelperMatrix3D:Matrix3D = new Matrix3D();
       
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _color:uint;
      
      protected var _premultipliedAlpha:Boolean;
      
      public function ByteQuad(param1:Number, param2:Number, param3:uint = 4294967295, param4:Boolean = true)
      {
         super();
         if(param1 == 0 || param2 == 0)
         {
            throw new ArgumentError("Invalid size: width and height must not be zero");
         }
         _width = param1;
         _height = param2;
         _color = param3;
         _premultipliedAlpha = param4;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return _premultipliedAlpha;
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
            param2.setTo(0,0,_width,_height);
         }
         else if(param1 == parent && rotation == 0)
         {
            _loc3_ = this.scaleX;
            _loc4_ = this.scaleY;
            param2.setTo(x - pivotX * _loc3_,y - pivotY * _loc4_,_width * _loc3_,_height * _loc4_);
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
            RectBounds.getBoundsProjected(_width,_height,sHelperMatrix3D,sHelperPoint3D,param2);
         }
         else
         {
            getTransformationMatrix(param1,sHelperMatrix);
            RectBounds.getBounds(_width,_height,sHelperMatrix,param2);
         }
         return param2;
      }
      
      public function copyVertexDataTransformedTo(param1:DomainMemoryByteArray, param2:int = 0, param3:Matrix = null, param4:Number = 1, param5:String = null) : void
      {
         var _loc6_:* = 0;
         if(_premultipliedAlpha)
         {
            if(param5 == "add")
            {
               _loc6_ = uint(0 | int((_color >> 16 & 255) * param4) | int((_color >> 8 & 255) * param4) << 8 | int((_color & 255) * param4) << 16);
            }
            else
            {
               _loc6_ = uint(int((_color >>> 24) * param4) << 24 | int((_color >> 16 & 255) * param4) | int((_color >> 8 & 255) * param4) << 8 | int((_color & 255) * param4) << 16);
            }
         }
         else
         {
            _loc6_ = uint(int((_color >>> 24) * param4) << 24 | _color >> 16 & 255 | (_color >> 8 & 255) << 8 | (_color & 255) << 16);
         }
         var _loc7_:int = param1.p + param2 * 80;
         sf32(param3.tx,_loc7_ + 0);
         sf32(param3.ty,_loc7_ + 4);
         si32(_loc6_,_loc7_ + 8);
         sf32(param3.a * _width + param3.tx,_loc7_ + 20);
         sf32(param3.b * _width + param3.ty,_loc7_ + 24);
         si32(_loc6_,_loc7_ + 28);
         sf32(param3.c * _height + param3.tx,_loc7_ + 40);
         sf32(param3.d * _height + param3.ty,_loc7_ + 44);
         si32(_loc6_,_loc7_ + 48);
         sf32(param3.a * _width + param3.c * _height + param3.tx,_loc7_ + 60);
         sf32(param3.d * _height + param3.b * _width + param3.ty,_loc7_ + 64);
         si32(_loc6_,_loc7_ + 68);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         param1.batchByteQuad(this,param2);
      }
   }
}
