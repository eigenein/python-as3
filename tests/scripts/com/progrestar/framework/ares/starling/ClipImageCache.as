package com.progrestar.framework.ares.starling
{
   import com.progrestar.common.util.collections.IIterator;
   import com.progrestar.common.util.collections.set.ISet;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.core.Frame;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class ClipImageCache
   {
      
      public static var errorHandler:Function;
      
      private static const tempMatrix:Matrix = new Matrix();
      
      private static const point0:Point = new Point();
      
      private static var tempRect:Rectangle = new Rectangle();
      
      private static var tempRect2:Rectangle = new Rectangle();
      
      private static var clipsCache:Dictionary = new Dictionary();
      
      private static var texturesPerImage:Dictionary = new Dictionary();
      
      private static var texturesPerResource:Dictionary = new Dictionary();
      
      static var scale3Cache:Dictionary = new Dictionary();
      
      static var scale9Cache:Dictionary = new Dictionary();
      
      static var scaleCacheList:Dictionary = new Dictionary();
      
      public static var disposedAssetsList:Vector.<String> = new Vector.<String>();
      
      public static var firstError:Boolean = true;
       
      
      public function ClipImageCache()
      {
         super();
      }
      
      public static function disposedClipError(param1:String, param2:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(firstError)
         {
            firstError = false;
            _loc3_ = new Error("Texture Error #1009");
            _loc4_ = (param1 + "\n" + param2 + "\n" + "[" + ClipImageCache.disposedAssetsList + "]").slice(0,4000);
            if(errorHandler)
            {
               errorHandler(_loc3_,_loc4_);
            }
            else
            {
               throw _loc3_;
            }
         }
      }
      
      static function get nativeDictionary() : Dictionary
      {
         return clipsCache;
      }
      
      static function createTexturesFromImage(param1:ClipImage, param2:Texture = null, param3:int = 0, param4:int = 0) : Vector.<ClipFrame>
      {
         var _loc9_:* = NaN;
         var _loc6_:* = null;
         var _loc7_:* = undefined;
         var _loc5_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = null;
         try
         {
            if(param1.resource == null)
            {
               disposedClipError("ClipImageCache",param1.name);
               var _loc13_:* = new Vector.<ClipFrame>();
               return _loc13_;
            }
            _loc9_ = 1;
            if(param1.resource.invertedResolution != 0 && param1.resource.invertedResolution == param1.resource.invertedResolution)
            {
               _loc9_ = Number(1 / param1.resource.invertedResolution);
            }
            if(param2 == null)
            {
               _loc6_ = getTexture(param1,_loc9_);
               TextureMemoryManager.add(_loc6_,param1.resource.name);
            }
            else
            {
               _loc6_ = param2;
            }
            texturesPerImage[param1] = _loc6_;
            _loc7_ = texturesPerResource[param1.resource];
            if(_loc7_ == null)
            {
               var _loc14_:* = new Vector.<ClipFrame>(param1.resource.frames.length);
               texturesPerResource[param1.resource] = _loc14_;
               _loc7_ = _loc14_;
            }
            var _loc16_:* = 0;
            for each(var _loc10_ in param1.frames)
            {
               _loc5_ = _loc10_.area;
               tempRect2.x = param3 + _loc5_.x / _loc9_;
               tempRect2.y = param4 + _loc5_.y / _loc9_;
               tempRect2.width = _loc5_.width / _loc9_;
               tempRect2.height = _loc5_.height / _loc9_;
               _loc5_ = tempRect2;
               _loc11_ = _loc10_.frame;
               if(_loc11_ != null)
               {
                  tempRect.x = _loc11_.x / _loc9_;
                  tempRect.y = _loc11_.y / _loc9_;
                  tempRect.width = _loc11_.width / _loc9_;
                  tempRect.height = _loc11_.height / _loc9_;
                  _loc11_ = tempRect;
               }
               _loc8_ = new SubTexture(_loc6_,_loc5_,false,_loc11_,false);
               _loc8_.name = _loc10_.image.name;
               if(_loc10_.frame)
               {
                  _loc7_[_loc10_.id] = new ClipFrame(_loc8_,_loc10_.doubleOffsetX / _loc9_ - _loc11_.x * 2,_loc10_.doubleOffsetY / _loc9_ - _loc11_.y * 2);
               }
               else
               {
                  _loc7_[_loc10_.id] = new ClipFrame(_loc8_,_loc10_.doubleOffsetX / _loc9_,_loc10_.doubleOffsetY / _loc9_);
               }
            }
            _loc14_ = _loc7_;
            return _loc14_;
            return;
         }
         catch(e:Error)
         {
            disposedClipError("ClipImageCache",param1.name);
            _loc16_ = new Vector.<ClipFrame>();
            return _loc16_;
         }
      }
      
      public static function getClipBitmapData(param1:Clip) : BitmapData
      {
         if(!param1 || !param1.timeLine || param1.timeLine.length == 0 || !(param1.timeLine[0] is Frame))
         {
            return null;
         }
         return getFrameBitmapData(param1.timeLine[0] as Frame);
      }
      
      public static function getClipTexture(param1:Clip) : Texture
      {
         if(!param1 || !param1.timeLine || param1.timeLine.length == 0 || !(param1.timeLine[0] is Frame))
         {
            return null;
         }
         return getFrameTexture(param1.timeLine[0] as Frame);
      }
      
      public static function getFrameTexture(param1:Frame) : Texture
      {
         var _loc2_:Vector.<ClipFrame> = clipsCache[param1.image];
         if(_loc2_ == null)
         {
            var _loc3_:* = createTexturesFromImage(param1.image);
            clipsCache[param1.image] = _loc3_;
            _loc2_ = _loc3_;
         }
         return _loc2_.length > param1.id?_loc2_[param1.id].texture:null;
      }
      
      public static function getImageTextures(param1:ClipImage) : Vector.<ClipFrame>
      {
         if(clipsCache[param1])
         {
            return clipsCache[param1];
         }
         var _loc2_:* = createTexturesFromImage(param1);
         clipsCache[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function initImageTextures(param1:ClipImage, param2:Texture = null, param3:int = 0, param4:int = 0) : Vector.<ClipFrame>
      {
         var _loc5_:* = createTexturesFromImage(param1,param2,param3,param4);
         clipsCache[param1] = _loc5_;
         return _loc5_;
      }
      
      public static function dropUnusedTextures(param1:ISet) : void
      {
         var _loc2_:IIterator = param1.getIterator();
         while(_loc2_.hasNext())
         {
            dropUnusedTexture(_loc2_.getNext() as ClipAsset);
         }
      }
      
      public static function dropScaleCache() : void
      {
         scale3Cache = new Dictionary();
         scale9Cache = new Dictionary();
      }
      
      public static function dropUnusedTexture(param1:ClipAsset) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = undefined;
         trace("ClipImageCache::dropUnusedTexture"," key=",param1.name);
         delete texturesPerResource[param1];
         _loc5_ = 0;
         while(_loc5_ < param1.images.length)
         {
            _loc2_ = param1.images[_loc5_];
            trace("ClipImageCache::dropUnusedTexture"," image.name=",_loc2_.name);
            delete clipsCache[_loc2_];
            _loc4_ = texturesPerImage[_loc2_] as Texture;
            if(_loc4_ != null)
            {
               _loc4_.dispose();
            }
            delete texturesPerImage[_loc2_];
            _loc5_++;
         }
         if(scaleCacheList[param1])
         {
            _loc3_ = scaleCacheList[param1];
            var _loc8_:int = 0;
            var _loc7_:* = _loc3_;
            for each(var _loc6_ in _loc3_)
            {
               delete scale3Cache[_loc6_];
               delete scale9Cache[_loc6_];
            }
            delete scaleCacheList[param1];
         }
      }
      
      protected static function getFrameBitmapData(param1:Frame) : BitmapData
      {
         var _loc2_:BitmapData = new BitmapData(param1.area.width,param1.area.height,true,4289352960);
         _loc2_.copyPixels(param1.image.bitmapData,param1.area,point0);
         return _loc2_;
      }
      
      private static function getTexture(param1:ClipImage, param2:Number) : Texture
      {
         if(param1.bitmapData != null)
         {
            return Texture.fromBitmapData(param1.bitmapData,false,false,param2);
         }
         if(param1.atfData != null)
         {
            return Texture.fromAtfData(param1.atfData,param2,false);
         }
         return null;
      }
   }
}
