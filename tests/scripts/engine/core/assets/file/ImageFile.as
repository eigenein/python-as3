package engine.core.assets.file
{
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.assets.loading.BitmapDataAssetLoader;
   import engine.core.assets.loading.ByteArrayAssetLoader;
   import flash.display.BitmapData;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class ImageFile extends AssetFile
   {
       
      
      public var bitmapData:BitmapData;
      
      private var _texture:Texture;
      
      public function ImageFile(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         bitmapData = null;
      }
      
      override public function get completed() : Boolean
      {
         return bitmapData;
      }
      
      public function get texture() : Texture
      {
         if(!_texture)
         {
            _texture = Texture.fromBitmapData(bitmapData,false);
            TextureMemoryManager.add(_texture,fileName);
         }
         return _texture;
      }
      
      override public function completeAsync(param1:AssetLoaderItem) : void
      {
         if(param1 is BitmapDataAssetLoader)
         {
            bitmapData = (param1 as BitmapDataAssetLoader).bitmapData;
         }
      }
      
      override public function getLoader() : AssetLoaderItem
      {
         return new BitmapDataAssetLoader(new ByteArrayAssetLoader(this));
      }
   }
}
