package com.progrestar.framework.ares.starling
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Frame;
   import feathers.textures.Scale3Textures;
   import feathers.textures.Scale9Textures;
   import flash.geom.Rectangle;
   
   public class ClipImageTextureFactory
   {
       
      
      public function ClipImageTextureFactory()
      {
         super();
      }
      
      public static function getScale3Texture(param1:Clip, param2:Number, param3:Number, param4:String = "horizontal") : Scale3Textures
      {
         if(!param1 || !param1.timeLine || param1.timeLine.length == 0 || !(param1.timeLine[0] is Frame))
         {
            return null;
         }
         var _loc6_:Frame = param1.timeLine[0] as Frame;
         var _loc5_:String = _loc6_.image.resource.name + "`" + _loc6_.id + "`" + param2 + "`" + param3;
         if(ClipImageCache.scale3Cache[_loc5_])
         {
            return ClipImageCache.scale3Cache[_loc5_];
         }
         if(ClipImageCache.scaleCacheList[_loc6_.image.resource] == null)
         {
            ClipImageCache.scaleCacheList[_loc6_.image.resource] = new Vector.<String>();
         }
         ClipImageCache.scaleCacheList[_loc6_.image.resource].push(_loc5_);
         var _loc7_:* = new Scale3Textures(ClipImageCache.getFrameTexture(_loc6_),param2,param3,param4);
         ClipImageCache.scale3Cache[_loc5_] = _loc7_;
         return _loc7_;
      }
      
      public static function getScale9Texture(param1:Clip, param2:Rectangle) : Scale9Textures
      {
         if(!param1 || !param1.timeLine || param1.timeLine.length == 0 || !(param1.timeLine[0] is Frame))
         {
            return null;
         }
         var _loc4_:Frame = param1.timeLine[0] as Frame;
         var _loc3_:String = _loc4_.image.resource.name + "`" + _loc4_.id + "`" + param2;
         if(ClipImageCache.scale9Cache[_loc3_])
         {
            return ClipImageCache.scale9Cache[_loc3_];
         }
         if(ClipImageCache.scaleCacheList[_loc4_.image.resource] == null)
         {
            ClipImageCache.scaleCacheList[_loc4_.image.resource] = new Vector.<String>();
         }
         ClipImageCache.scaleCacheList[_loc4_.image.resource].push(_loc3_);
         var _loc5_:* = new Scale9Textures(ClipImageCache.getFrameTexture(_loc4_),param2);
         ClipImageCache.scale9Cache[_loc3_] = _loc5_;
         return _loc5_;
      }
   }
}
