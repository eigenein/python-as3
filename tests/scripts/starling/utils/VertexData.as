package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class VertexData
   {
      
      public static const ELEMENTS_PER_VERTEX:int = 8;
      
      public static const POSITION_OFFSET:int = 0;
      
      public static const COLOR_OFFSET:int = 2;
      
      public static const TEXCOORD_OFFSET:int = 6;
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
      
      private static var sHelperRect:Rectangle = new Rectangle();
       
      
      private var mRawData:Vector.<Number>;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mNumVertices:int;
      
      public function VertexData(param1:int, param2:Boolean = false)
      {
         super();
         mRawData = new Vector.<Number>(0);
         mPremultipliedAlpha = param2;
         this.numVertices = param1;
      }
      
      public function clone(param1:int = 0, param2:int = -1) : VertexData
      {
         if(param2 < 0 || param1 + param2 > mNumVertices)
         {
            param2 = mNumVertices - param1;
         }
         var _loc3_:VertexData = new VertexData(0,mPremultipliedAlpha);
         _loc3_.mNumVertices = param2;
         _loc3_.mRawData = mRawData.slice(param1 * 8,param2 * 8);
         _loc3_.mRawData.fixed = true;
         return _loc3_;
      }
      
      public function copyTo(param1:VertexData, param2:int = 0, param3:int = 0, param4:int = -1) : void
      {
         copyTransformedTo(param1,param2,null,param3,param4);
      }
      
      public function copyTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null, param4:int = 0, param5:int = -1) : void
      {
         var _loc9_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param5 < 0 || param4 + param5 > mNumVertices)
         {
            param5 = mNumVertices - param4;
         }
         var _loc10_:Vector.<Number> = param1.mRawData;
         var _loc7_:int = param2 * 8;
         var _loc11_:int = param4 * 8;
         var _loc6_:int = (param4 + param5) * 8;
         if(param3)
         {
            while(_loc11_ < _loc6_)
            {
               _loc8_ = mRawData[int(_loc11_)];
               _loc9_ = mRawData[int(_loc11_ + 1)];
               _loc10_[int(_loc7_)] = param3.a * _loc8_ + param3.c * _loc9_ + param3.tx;
               _loc10_[int(_loc7_ + 1)] = param3.d * _loc9_ + param3.b * _loc8_ + param3.ty;
               _loc10_[int(_loc7_ + 2)] = mRawData[int(_loc11_ + 2)];
               _loc10_[int(_loc7_ + 3)] = mRawData[int(_loc11_ + 3)];
               _loc10_[int(_loc7_ + 4)] = mRawData[int(_loc11_ + 4)];
               _loc10_[int(_loc7_ + 5)] = mRawData[int(_loc11_ + 5)];
               _loc10_[int(_loc7_ + 6)] = mRawData[int(_loc11_ + 6)];
               _loc10_[int(_loc7_ + 7)] = mRawData[int(_loc11_ + 7)];
               _loc11_ = _loc11_ + 8;
               _loc7_ = _loc7_ + 8;
            }
         }
         else
         {
            while(_loc11_ < _loc6_)
            {
               _loc10_[int(_loc7_)] = mRawData[int(_loc11_)];
               _loc10_[int(_loc7_ + 1)] = mRawData[int(_loc11_ + 1)];
               _loc10_[int(_loc7_ + 2)] = mRawData[int(_loc11_ + 2)];
               _loc10_[int(_loc7_ + 3)] = mRawData[int(_loc11_ + 3)];
               _loc10_[int(_loc7_ + 4)] = mRawData[int(_loc11_ + 4)];
               _loc10_[int(_loc7_ + 5)] = mRawData[int(_loc11_ + 5)];
               _loc10_[int(_loc7_ + 6)] = mRawData[int(_loc11_ + 6)];
               _loc10_[int(_loc7_ + 7)] = mRawData[int(_loc11_ + 7)];
               _loc11_ = _loc11_ + 8;
               _loc7_ = _loc7_ + 8;
            }
         }
      }
      
      public function append(param1:VertexData) : void
      {
         var _loc4_:int = 0;
         mRawData.fixed = false;
         var _loc2_:int = mRawData.length;
         var _loc5_:Vector.<Number> = param1.mRawData;
         var _loc3_:int = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_++;
            mRawData[int(_loc2_)] = _loc5_[_loc4_];
            _loc4_++;
         }
         mNumVertices = mNumVertices + param1.numVertices;
         mRawData.fixed = true;
      }
      
      public function setPosition(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:int = param1 * 8 + 0;
         mRawData[_loc4_] = param2;
         mRawData[int(_loc4_ + 1)] = param3;
      }
      
      public function getPosition(param1:int, param2:Point) : void
      {
         var _loc3_:int = param1 * 8 + 0;
         param2.x = mRawData[_loc3_];
         param2.y = mRawData[int(_loc3_ + 1)];
      }
      
      public function setColorAndAlpha(param1:int, param2:uint, param3:Number) : void
      {
         if(param3 < 0.001)
         {
            param3 = 0.001;
         }
         else if(param3 > 1)
         {
            param3 = 1;
         }
         var _loc4_:int = param1 * 8 + 2;
         var _loc5_:Number = !!mPremultipliedAlpha?param3:1;
         mRawData[_loc4_] = (param2 >> 16 & 255) / 255 * _loc5_;
         mRawData[int(_loc4_ + 1)] = (param2 >> 8 & 255) / 255 * _loc5_;
         mRawData[int(_loc4_ + 2)] = (param2 & 255) / 255 * _loc5_;
         mRawData[int(_loc4_ + 3)] = param3;
      }
      
      public function setColor(param1:int, param2:uint) : void
      {
         var _loc3_:int = param1 * 8 + 2;
         var _loc4_:Number = !!mPremultipliedAlpha?mRawData[int(_loc3_ + 3)]:1;
         mRawData[_loc3_] = (param2 >> 16 & 255) / 255 * _loc4_;
         mRawData[int(_loc3_ + 1)] = (param2 >> 8 & 255) / 255 * _loc4_;
         mRawData[int(_loc3_ + 2)] = (param2 & 255) / 255 * _loc4_;
      }
      
      public function getColor(param1:int) : uint
      {
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:int = param1 * 8 + 2;
         var _loc3_:Number = !!mPremultipliedAlpha?mRawData[int(_loc5_ + 3)]:1;
         if(_loc3_ == 0)
         {
            return 0;
         }
         _loc2_ = mRawData[_loc5_] / _loc3_;
         _loc4_ = mRawData[int(_loc5_ + 1)] / _loc3_;
         _loc6_ = mRawData[int(_loc5_ + 2)] / _loc3_;
         return int(_loc2_ * 255) << 16 | int(_loc4_ * 255) << 8 | int(_loc6_ * 255);
      }
      
      public function setAlpha(param1:int, param2:Number) : void
      {
         if(mPremultipliedAlpha)
         {
            setColorAndAlpha(param1,getColor(param1),param2);
         }
         else
         {
            mRawData[int(param1 * 8 + 2 + 3)] = param2;
         }
      }
      
      public function getAlpha(param1:int) : Number
      {
         var _loc2_:int = param1 * 8 + 2 + 3;
         return mRawData[_loc2_];
      }
      
      public function setTexCoords(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:int = param1 * 8 + 6;
         mRawData[_loc4_] = param2;
         mRawData[int(_loc4_ + 1)] = param3;
      }
      
      public function getTexCoords(param1:int, param2:Point) : void
      {
         var _loc3_:int = param1 * 8 + 6;
         param2.x = mRawData[_loc3_];
         param2.y = mRawData[int(_loc3_ + 1)];
      }
      
      public function translateVertex(param1:int, param2:Number, param3:Number) : void
      {
         var _loc4_:int = param1 * 8 + 0;
         var _loc5_:* = _loc4_;
         var _loc6_:* = mRawData[_loc5_] + param2;
         mRawData[_loc5_] = _loc6_;
         _loc6_ = int(_loc4_ + 1);
         _loc5_ = mRawData[_loc6_] + param3;
         mRawData[_loc6_] = _loc5_;
      }
      
      public function transformVertex(param1:int, param2:Matrix, param3:int = 1) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:int = 0;
         var _loc4_:int = param1 * 8 + 0;
         _loc7_ = 0;
         while(_loc7_ < param3)
         {
            _loc5_ = mRawData[_loc4_];
            _loc6_ = mRawData[int(_loc4_ + 1)];
            mRawData[_loc4_] = param2.a * _loc5_ + param2.c * _loc6_ + param2.tx;
            mRawData[int(_loc4_ + 1)] = param2.d * _loc6_ + param2.b * _loc5_ + param2.ty;
            _loc4_ = _loc4_ + 8;
            _loc7_++;
         }
      }
      
      public function setUniformColor(param1:uint) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < mNumVertices)
         {
            setColor(_loc2_,param1);
            _loc2_++;
         }
      }
      
      public function setUniformAlpha(param1:Number) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < mNumVertices)
         {
            setAlpha(_loc2_,param1);
            _loc2_++;
         }
      }
      
      public function scaleAlpha(param1:int, param2:Number, param3:int = 1) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2 == 1)
         {
            return;
         }
         if(param3 < 0 || param1 + param3 > mNumVertices)
         {
            param3 = mNumVertices - param1;
         }
         if(mPremultipliedAlpha)
         {
            _loc5_ = 0;
            while(_loc5_ < param3)
            {
               setAlpha(param1 + _loc5_,getAlpha(param1 + _loc5_) * param2);
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = param1 * 8 + 2 + 3;
            _loc5_ = 0;
            while(_loc5_ < param3)
            {
               var _loc6_:int = _loc4_ + _loc5_ * 8;
               var _loc7_:* = mRawData[_loc6_] * param2;
               mRawData[_loc6_] = _loc7_;
               _loc5_++;
            }
         }
      }
      
      public function getBounds(param1:Matrix = null, param2:int = 0, param3:int = -1, param4:Rectangle = null) : Rectangle
      {
         var _loc7_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc10_:Number = NaN;
         if(param4 == null)
         {
            param4 = new Rectangle();
         }
         if(param3 < 0 || param2 + param3 > mNumVertices)
         {
            param3 = mNumVertices - param2;
         }
         if(param3 == 0)
         {
            if(param1 == null)
            {
               param4.setEmpty();
            }
            else
            {
               MatrixUtil.transformCoords(param1,0,0,sHelperPoint);
               param4.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
            }
         }
         else
         {
            _loc7_ = 1.79769313486232e308;
            var _loc9_:* = -1.79769313486232e308;
            _loc5_ = 1.79769313486232e308;
            var _loc8_:* = -1.79769313486232e308;
            _loc6_ = param2 * 8 + 0;
            if(param1 == null)
            {
               _loc12_ = 0;
               while(_loc12_ < param3)
               {
                  _loc10_ = mRawData[_loc6_];
                  _loc11_ = mRawData[int(_loc6_ + 1)];
                  _loc6_ = _loc6_ + 8;
                  if(_loc7_ > _loc10_)
                  {
                     _loc7_ = _loc10_;
                  }
                  if(_loc9_ < _loc10_)
                  {
                     _loc9_ = _loc10_;
                  }
                  if(_loc5_ > _loc11_)
                  {
                     _loc5_ = _loc11_;
                  }
                  if(_loc8_ < _loc11_)
                  {
                     _loc8_ = _loc11_;
                  }
                  _loc12_++;
               }
            }
            else
            {
               _loc12_ = 0;
               while(_loc12_ < param3)
               {
                  _loc10_ = mRawData[_loc6_];
                  _loc11_ = mRawData[int(_loc6_ + 1)];
                  _loc6_ = _loc6_ + 8;
                  MatrixUtil.transformCoords(param1,_loc10_,_loc11_,sHelperPoint);
                  if(_loc7_ > sHelperPoint.x)
                  {
                     _loc7_ = Number(sHelperPoint.x);
                  }
                  if(_loc9_ < sHelperPoint.x)
                  {
                     _loc9_ = Number(sHelperPoint.x);
                  }
                  if(_loc5_ > sHelperPoint.y)
                  {
                     _loc5_ = Number(sHelperPoint.y);
                  }
                  if(_loc8_ < sHelperPoint.y)
                  {
                     _loc8_ = Number(sHelperPoint.y);
                  }
                  _loc12_++;
               }
            }
            param4.setTo(_loc7_,_loc5_,_loc9_ - _loc7_,_loc8_ - _loc5_);
         }
         return param4;
      }
      
      public function getBoundsProjected(param1:Matrix3D, param2:Vector3D, param3:int = 0, param4:int = -1, param5:Rectangle = null) : Rectangle
      {
         var _loc11_:* = NaN;
         var _loc10_:* = NaN;
         var _loc6_:int = 0;
         var _loc13_:Number = NaN;
         var _loc9_:int = 0;
         var _loc12_:Number = NaN;
         if(param2 == null)
         {
            throw new ArgumentError("camPos must not be null");
         }
         if(param5 == null)
         {
            param5 = new Rectangle();
         }
         if(param4 < 0 || param3 + param4 > mNumVertices)
         {
            param4 = mNumVertices - param3;
         }
         if(param4 == 0)
         {
            if(param1)
            {
               MatrixUtil.transformCoords3D(param1,0,0,0,sHelperPoint3D);
            }
            else
            {
               sHelperPoint3D.setTo(0,0,0);
            }
            MathUtil.intersectLineWithXYPlane(param2,sHelperPoint3D,sHelperPoint);
            param5.setTo(sHelperPoint.x,sHelperPoint.y,0,0);
         }
         else
         {
            _loc11_ = 1.79769313486232e308;
            var _loc8_:* = -1.79769313486232e308;
            _loc10_ = 1.79769313486232e308;
            var _loc7_:* = -1.79769313486232e308;
            _loc6_ = param3 * 8 + 0;
            _loc9_ = 0;
            while(_loc9_ < param4)
            {
               _loc12_ = mRawData[_loc6_];
               _loc13_ = mRawData[int(_loc6_ + 1)];
               _loc6_ = _loc6_ + 8;
               if(param1)
               {
                  MatrixUtil.transformCoords3D(param1,_loc12_,_loc13_,0,sHelperPoint3D);
               }
               else
               {
                  sHelperPoint3D.setTo(_loc12_,_loc13_,0);
               }
               MathUtil.intersectLineWithXYPlane(param2,sHelperPoint3D,sHelperPoint);
               if(_loc11_ > sHelperPoint.x)
               {
                  _loc11_ = Number(sHelperPoint.x);
               }
               if(_loc8_ < sHelperPoint.x)
               {
                  _loc8_ = Number(sHelperPoint.x);
               }
               if(_loc10_ > sHelperPoint.y)
               {
                  _loc10_ = Number(sHelperPoint.y);
               }
               if(_loc7_ < sHelperPoint.y)
               {
                  _loc7_ = Number(sHelperPoint.y);
               }
               _loc9_++;
            }
            param5.setTo(_loc11_,_loc10_,_loc8_ - _loc11_,_loc7_ - _loc10_);
         }
         return param5;
      }
      
      public function toString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = "[VertexData \n";
         var _loc3_:Point = new Point();
         var _loc4_:Point = new Point();
         _loc2_ = 0;
         while(_loc2_ < numVertices)
         {
            getPosition(_loc2_,_loc3_);
            getTexCoords(_loc2_,_loc4_);
            _loc1_ = _loc1_ + ("  [Vertex " + _loc2_ + ": " + "x=" + _loc3_.x.toFixed(1) + ", " + "y=" + _loc3_.y.toFixed(1) + ", " + "rgb=" + getColor(_loc2_).toString(16) + ", " + "a=" + getAlpha(_loc2_).toFixed(2) + ", " + "u=" + _loc4_.x.toFixed(4) + ", " + "v=" + _loc4_.y.toFixed(4) + "]" + (_loc2_ == numVertices - 1?"\n":",\n"));
            _loc2_++;
         }
         return _loc1_ + "]";
      }
      
      public function get tinted() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 2;
         _loc2_ = 0;
         while(_loc2_ < mNumVertices)
         {
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               if(mRawData[int(_loc1_ + _loc3_)] != 1)
               {
                  return true;
               }
               _loc3_++;
            }
            _loc1_ = _loc1_ + 8;
            _loc2_++;
         }
         return false;
      }
      
      public function setPremultipliedAlpha(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         if(param1 == mPremultipliedAlpha)
         {
            return;
         }
         if(param2)
         {
            _loc4_ = mNumVertices * 8;
            _loc7_ = 2;
            while(_loc7_ < _loc4_)
            {
               _loc6_ = mRawData[int(_loc7_ + 3)];
               _loc3_ = !!mPremultipliedAlpha?_loc6_:1;
               _loc5_ = !!param1?_loc6_:1;
               if(_loc3_ != 0)
               {
                  mRawData[_loc7_] = mRawData[_loc7_] / _loc3_ * _loc5_;
                  mRawData[int(_loc7_ + 1)] = mRawData[int(_loc7_ + 1)] / _loc3_ * _loc5_;
                  mRawData[int(_loc7_ + 2)] = mRawData[int(_loc7_ + 2)] / _loc3_ * _loc5_;
               }
               _loc7_ = _loc7_ + 8;
            }
         }
         mPremultipliedAlpha = param1;
      }
      
      public function get premultipliedAlpha() : Boolean
      {
         return mPremultipliedAlpha;
      }
      
      public function set premultipliedAlpha(param1:Boolean) : void
      {
         setPremultipliedAlpha(param1);
      }
      
      public function get numVertices() : int
      {
         return mNumVertices;
      }
      
      public function set numVertices(param1:int) : void
      {
         var _loc4_:* = 0;
         mRawData.fixed = false;
         mRawData.length = param1 * 8;
         var _loc2_:int = mNumVertices * 8 + 2 + 3;
         var _loc3_:int = mRawData.length;
         _loc4_ = _loc2_;
         while(_loc4_ < _loc3_)
         {
            mRawData[_loc4_] = 1;
            _loc4_ = int(_loc4_ + 8);
         }
         mNumVertices = param1;
         mRawData.fixed = true;
      }
      
      public function get rawData() : Vector.<Number>
      {
         return mRawData;
      }
   }
}
