package starling.custom
{
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureSmoothing;
   
   public class Image extends ByteQuad
   {
      
      private static var sTexCoords:Point = new Point();
      
      private static var sMatrix:Matrix = new Matrix();
       
      
      protected var mTexture:Texture;
      
      protected var mSmoothing:String;
      
      protected var _u0:Number;
      
      protected var _u1:Number;
      
      protected var _u2:Number;
      
      protected var _v0:Number;
      
      protected var _v1:Number;
      
      protected var _v2:Number;
      
      public function Image(param1:Texture)
      {
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Boolean = false;
         if(param1)
         {
            _loc4_ = param1.frame;
            _loc3_ = !!_loc4_?_loc4_.width:Number(param1.width);
            _loc5_ = !!_loc4_?_loc4_.height:Number(param1.height);
            _loc2_ = param1.premultipliedAlpha;
            super(_loc3_,_loc5_,4294967295,_loc2_);
            _u0 = 0;
            _u2 = 1;
            _u1 = 1;
            _v1 = 0;
            _v0 = 0;
            _v2 = 1;
            mTexture = param1;
            mSmoothing = "bilinear";
            readjustSize();
            return;
         }
         throw new ArgumentError("Texture cannot be null");
      }
      
      override public function copyVertexDataTransformedTo(param1:DomainMemoryByteArray, param2:int = 0, param3:Matrix = null, param4:Number = 1, param5:String = null) : void
      {
         var _loc6_:* = 0;
         var _loc12_:* = null;
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
         var _loc7_:Number = param3.tx;
         var _loc8_:Number = param3.ty;
         var _loc9_:Number = _width;
         var _loc10_:Number = _height;
         if(texture && texture.frame)
         {
            _loc12_ = texture.frame;
            _loc7_ = _loc7_ - (param3.a * _loc12_.x + param3.c * _loc12_.y);
            _loc8_ = _loc8_ - (param3.b * _loc12_.x + param3.d * _loc12_.y);
            _loc9_ = texture.width;
            _loc10_ = texture.height;
         }
         var _loc11_:int = param1.p + param2 * 80;
         sf32(_loc7_,_loc11_ + 0);
         sf32(_loc8_,_loc11_ + 4);
         si32(_loc6_,_loc11_ + 8);
         sf32(_u0,_loc11_ + 12);
         sf32(_v0,_loc11_ + 16);
         sf32(param3.a * _loc9_ + _loc7_,_loc11_ + 20);
         sf32(param3.b * _loc9_ + _loc8_,_loc11_ + 24);
         si32(_loc6_,_loc11_ + 28);
         sf32(_u0 + _u1,_loc11_ + 32);
         sf32(_v0 + _v1,_loc11_ + 36);
         sf32(param3.c * _loc10_ + _loc7_,_loc11_ + 40);
         sf32(param3.d * _loc10_ + _loc8_,_loc11_ + 44);
         si32(_loc6_,_loc11_ + 48);
         sf32(_u0 + _u2,_loc11_ + 52);
         sf32(_v0 + _v2,_loc11_ + 56);
         sf32(param3.a * _loc9_ + param3.c * _loc10_ + _loc7_,_loc11_ + 60);
         sf32(param3.d * _loc10_ + param3.b * _loc9_ + _loc8_,_loc11_ + 64);
         si32(_loc6_,_loc11_ + 68);
         sf32(_u0 + _u1 + _u2,_loc11_ + 72);
         sf32(_v0 + _v1 + _v2,_loc11_ + 76);
      }
      
      public function readjustSize() : void
      {
         var _loc1_:Rectangle = mTexture.frame;
         _width = !!_loc1_?_loc1_.width:Number(mTexture.width);
         _height = !!_loc1_?_loc1_.height:Number(mTexture.height);
         adjustTexCoords();
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
      
      public function set texture(param1:Texture) : void
      {
         if(param1 == null)
         {
            throw new ArgumentError("Texture cannot be null");
         }
         if(param1 != mTexture)
         {
            mTexture = param1;
            _premultipliedAlpha = mTexture.premultipliedAlpha;
            adjustTexCoords();
         }
      }
      
      public function get smoothing() : String
      {
         return mSmoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(TextureSmoothing.isValid(param1))
         {
            mSmoothing = param1;
            return;
         }
         throw new ArgumentError("Invalid smoothing mode: " + param1);
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         param1.batchByteQuad(this,param2,mTexture,mSmoothing);
      }
      
      protected function adjustTexCoords() : void
      {
         sMatrix.identity();
         var _loc1_:SubTexture = mTexture as SubTexture;
         while(_loc1_)
         {
            sMatrix.concat(_loc1_.transformationMatrix);
            _loc1_ = _loc1_.parent as SubTexture;
         }
         _u0 = sMatrix.tx;
         _v0 = sMatrix.ty;
         _u1 = sMatrix.a;
         _v1 = sMatrix.b;
         _u2 = sMatrix.c;
         _v2 = sMatrix.d;
      }
   }
}
