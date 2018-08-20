package starling.textures
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.textures.RectangleTexture;
   import flash.display3D.textures.TextureBase;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.§core:starling_internal§.createBase;
   import starling.errors.MissingContextError;
   import starling.utils.Color;
   
   public class ConcreteTexture extends starling.textures.Texture
   {
      
      public static var memOccupied:int = 0;
      
      private static var sOrigin:Point = new Point();
       
      
      private var mBase:TextureBase;
      
      private var mFormat:String;
      
      private var mWidth:int;
      
      private var mHeight:int;
      
      private var mMipMapping:Boolean;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mOptimizedForRenderTexture:Boolean;
      
      private var mScale:Number;
      
      private var mRepeat:Boolean;
      
      private var mOnRestore:Function;
      
      private var mDataUploaded:Boolean;
      
      public function ConcreteTexture(param1:TextureBase, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Number = 1, param9:Boolean = false)
      {
         super();
         mScale = param8 <= 0?1:Number(param8);
         mBase = param1;
         mFormat = param2;
         mWidth = param3;
         mHeight = param4;
         memOccupied = memOccupied + mWidth * mHeight * 4 * 1.5;
         mMipMapping = param5;
         mPremultipliedAlpha = param6;
         mOptimizedForRenderTexture = param7;
         mRepeat = param9;
         mOnRestore = null;
         mDataUploaded = false;
      }
      
      override public function dispose() : void
      {
         if(mBase)
         {
            mBase.dispose();
         }
         this.onRestore = null;
         super.dispose();
         memOccupied = memOccupied - mWidth * mHeight * 4 * 1.5;
         TextureMemoryManager.drop(this);
      }
      
      public function uploadBitmap(param1:Bitmap) : void
      {
         uploadBitmapData(param1.bitmapData);
      }
      
      public function uploadBitmapData(param1:BitmapData) : void
      {
         var _loc9_:* = null;
         var _loc4_:* = 0;
         var _loc8_:* = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc7_:BitmapData = null;
         if(param1.width != mWidth || param1.height != mHeight)
         {
            _loc7_ = new BitmapData(mWidth,mHeight,true,0);
            _loc7_.copyPixels(param1,param1.rect,sOrigin);
            param1 = _loc7_;
         }
         if(mBase is flash.display3D.textures.Texture)
         {
            _loc9_ = mBase as flash.display3D.textures.Texture;
            _loc9_.uploadFromBitmapData(param1);
            if(mMipMapping && param1.width > 1 && param1.height > 1)
            {
               _loc4_ = param1.width >> 1;
               _loc8_ = param1.height >> 1;
               _loc5_ = 1;
               _loc2_ = new BitmapData(_loc4_,_loc8_,true,0);
               _loc3_ = new Matrix(0.5,0,0,0.5);
               _loc6_ = new Rectangle();
               while(_loc4_ >= 1 || _loc8_ >= 1)
               {
                  _loc6_.width = _loc4_;
                  _loc6_.height = _loc8_;
                  _loc2_.fillRect(_loc6_,0);
                  _loc2_.draw(param1,_loc3_,null,null,null,true);
                  _loc5_++;
                  _loc9_.uploadFromBitmapData(_loc2_,_loc5_);
                  _loc3_.scale(0.5,0.5);
                  _loc4_ = _loc4_ >> 1;
                  _loc8_ = _loc8_ >> 1;
               }
               _loc2_.dispose();
            }
         }
         else
         {
            (mBase as RectangleTexture).uploadFromBitmapData(param1);
         }
         if(_loc7_)
         {
            _loc7_.dispose();
         }
         mDataUploaded = true;
      }
      
      public function uploadAtfData(param1:ByteArray, param2:int = 0, param3:* = null) : void
      {
         data = param1;
         offset = param2;
         async = param3;
         onTextureReady = function(param1:Object):void
         {
            potTexture.removeEventListener("textureReady",onTextureReady);
            var _loc2_:Function = async as Function;
            if(_loc2_ != null)
            {
               if(_loc2_.length == 1)
               {
                  _loc2_(self);
               }
               else
               {
                  _loc2_();
               }
            }
         };
         var self:ConcreteTexture = this;
         var isAsync:Boolean = async is Function || async === true;
         var potTexture:flash.display3D.textures.Texture = mBase as flash.display3D.textures.Texture;
         if(potTexture == null)
         {
            throw new Error("This texture type does not support ATF data");
         }
         if(async is Function)
         {
            potTexture.addEventListener("textureReady",onTextureReady);
         }
         potTexture.uploadCompressedTextureFromByteArray(data,offset,isAsync);
         mDataUploaded = true;
      }
      
      private function onContextCreated() : void
      {
         createBase();
         mOnRestore();
         if(!mDataUploaded)
         {
            clear();
         }
      }
      
      function createBase() : void
      {
         var _loc1_:Context3D = Starling.context;
         if(mBase is flash.display3D.textures.Texture)
         {
            mBase = _loc1_.createTexture(mWidth,mHeight,mFormat,mOptimizedForRenderTexture);
         }
         else
         {
            mBase = _loc1_["createRectangleTexture"](mWidth,mHeight,mFormat,mOptimizedForRenderTexture);
         }
         mDataUploaded = false;
      }
      
      public function clear(param1:uint = 0, param2:Number = 0.0) : void
      {
         var _loc3_:Context3D = Starling.context;
         if(_loc3_ == null)
         {
            throw new MissingContextError();
         }
         if(mPremultipliedAlpha && param2 < 1)
         {
            param1 = Color.rgb(Color.getRed(param1) * param2,Color.getGreen(param1) * param2,Color.getBlue(param1) * param2);
         }
         _loc3_.setRenderToTexture(mBase);
         try
         {
            RenderSupport.clear(param1,param2);
         }
         catch(e:Error)
         {
         }
         _loc3_.setRenderToBackBuffer();
         mDataUploaded = true;
      }
      
      public function get optimizedForRenderTexture() : Boolean
      {
         return mOptimizedForRenderTexture;
      }
      
      public function get onRestore() : Function
      {
         return mOnRestore;
      }
      
      public function set onRestore(param1:Function) : void
      {
         Starling.current.removeEventListener("context3DCreate",onContextCreated);
         if(Starling.handleLostContext && param1 != null)
         {
            mOnRestore = param1;
            Starling.current.addEventListener("context3DCreate",onContextCreated);
         }
         else
         {
            mOnRestore = null;
         }
      }
      
      override public function get base() : TextureBase
      {
         return mBase;
      }
      
      override public function get root() : ConcreteTexture
      {
         return this;
      }
      
      override public function get format() : String
      {
         return mFormat;
      }
      
      override public function get width() : Number
      {
         return mWidth / mScale;
      }
      
      override public function get height() : Number
      {
         return mHeight / mScale;
      }
      
      override public function get nativeWidth() : Number
      {
         return mWidth;
      }
      
      override public function get nativeHeight() : Number
      {
         return mHeight;
      }
      
      override public function get scale() : Number
      {
         return mScale;
      }
      
      override public function get mipMapping() : Boolean
      {
         return mMipMapping;
      }
      
      override public function get premultipliedAlpha() : Boolean
      {
         return mPremultipliedAlpha;
      }
      
      override public function get repeat() : Boolean
      {
         return mRepeat;
      }
   }
}
