package starling.textures
{
   import starling.core.Starling;
   
   public class TextureOptions
   {
       
      
      private var mScale:Number;
      
      private var mFormat:String;
      
      private var mMipMapping:Boolean;
      
      private var mOptimizeForRenderToTexture:Boolean = false;
      
      private var mOnReady:Function = null;
      
      private var mRepeat:Boolean = false;
      
      public function TextureOptions(param1:Number = 1.0, param2:Boolean = false, param3:String = "bgra", param4:Boolean = false)
      {
         super();
         mScale = param1;
         mFormat = param3;
         mMipMapping = param2;
         mRepeat = param4;
      }
      
      public function clone() : TextureOptions
      {
         var _loc1_:TextureOptions = new TextureOptions(mScale,mMipMapping,mFormat,mRepeat);
         _loc1_.mOptimizeForRenderToTexture = mOptimizeForRenderToTexture;
         _loc1_.mOnReady = mOnReady;
         return _loc1_;
      }
      
      public function get scale() : Number
      {
         return mScale;
      }
      
      public function set scale(param1:Number) : void
      {
         mScale = param1 > 0?param1:Number(Starling.contentScaleFactor);
      }
      
      public function get format() : String
      {
         return mFormat;
      }
      
      public function set format(param1:String) : void
      {
         mFormat = param1;
      }
      
      public function get mipMapping() : Boolean
      {
         return mMipMapping;
      }
      
      public function set mipMapping(param1:Boolean) : void
      {
         mMipMapping = param1;
      }
      
      public function get optimizeForRenderToTexture() : Boolean
      {
         return mOptimizeForRenderToTexture;
      }
      
      public function set optimizeForRenderToTexture(param1:Boolean) : void
      {
         mOptimizeForRenderToTexture = param1;
      }
      
      public function get repeat() : Boolean
      {
         return mRepeat;
      }
      
      public function set repeat(param1:Boolean) : void
      {
         mRepeat = param1;
      }
      
      public function get onReady() : Function
      {
         return mOnReady;
      }
      
      public function set onReady(param1:Function) : void
      {
         mOnReady = param1;
      }
   }
}
