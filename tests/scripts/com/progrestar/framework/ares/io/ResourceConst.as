package com.progrestar.framework.ares.io
{
   public class ResourceConst
   {
      
      public static const HEADER:String = "RE$X";
      
      public static const VERSION1:uint = 538183465;
      
      public static const IMAGE_FORMAT_JPEGXR:uint = 1;
      
      public static const IMAGE_FORMAT_PNG:uint = 3;
      
      public static const IMAGE_FORMAT_ATF:uint = 4;
      
      public static const IMAGE_FORMAT_PNG_BLOODY:uint = 5;
      
      public static const IMAGE_FORMAT_PNG_CAMERON314:uint = 6;
      
      public static const IMAGE_FORMAT_PNG_ADOBE:uint = 7;
      
      public static const IMAGE_FORMAT_PNG_BASE64:uint = 8;
      
      public static const IMAGE_FORMAT_EXTERNAL:uint = 9;
      
      public static const EMPTY_CONTENT:uint = 16;
      
      public static const FRAME_CONTENT:uint = 17;
      
      public static const CONTAINER_CONTENT:uint = 18;
      
      public static const CONTAINER_CONTENT32:uint = 19;
      
      public static const IDENTITY_MATRIX:uint = 32;
      
      public static const CUSTOM_MATRIX:uint = 33;
      
      public static const COMPRESSED_CHUNK:uint = 2;
      
      public static const IMAGE_CHUNK:uint = 256;
      
      public static const FRAME_CHUNK:uint = 512;
      
      public static const FRAME_CHUNK_WITH_FRAME:uint = 513;
      
      public static const CLIP_CHUNK:uint = 768;
      
      public static const NODE_CHUNK:uint = 1024;
      
      public static const NODE32_CHUNK:uint = 4352;
      
      public static const VERSION2:uint = 538183984;
      
      public static const NAMES_CHUNK:uint = 1280;
      
      public static const VERSION3:uint = 538185749;
      
      public static const RESOLUTIONS_CHUNK:uint = 1536;
      
      public static const RESOURCE_RESOLUTION_CHUNK:uint = 2304;
      
      public static const VERSION4:uint = 538186016;
      
      public static const VERSION5:uint = 538247719;
      
      public static const VERSION6:uint = 538248455;
      
      static const AREAS_CHUNK:uint = 1792;
      
      public static const VERSION7:uint = 538248480;
      
      public static const VERSION8:uint = 538251539;
      
      static const DATE_CHUNK:uint = 2048;
      
      public static const EXTENSIONS_CHUNK:uint = 4096;
       
      
      public function ResourceConst()
      {
         super();
      }
      
      public static function getChunkName(param1:uint) : String
      {
         var _loc2_:* = param1;
         if(2 !== _loc2_)
         {
            if(256 !== _loc2_)
            {
               if(512 !== _loc2_)
               {
                  if(513 !== _loc2_)
                  {
                     if(768 !== _loc2_)
                     {
                        if(1024 !== _loc2_)
                        {
                           if(4352 !== _loc2_)
                           {
                              if(1280 !== _loc2_)
                              {
                                 if(4096 !== _loc2_)
                                 {
                                    return "chunk " + param1.toString(16) + "";
                                 }
                                 return "extensions chunk";
                              }
                              return "names chunk";
                           }
                           return "node32 chunk";
                        }
                        return "node chunk";
                     }
                     return "clip chunk";
                  }
                  return "frame with frame chunk";
               }
               return "frame chunk";
            }
            return "image chunk";
         }
         return "compressed chunk";
      }
   }
}
