package game.assets
{
   import engine.core.assets.AssetProvider;
   import engine.core.assets.file.ImageFile;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class SingleImageFontAsset extends FontAsset
   {
       
      
      private var image:ImageFile;
      
      public function SingleImageFontAsset(param1:*)
      {
         super(param1);
         image = getImageFile(param1.texture);
      }
      
      override public function complete() : void
      {
         var _loc1_:Texture = Texture.fromBitmapData(image.bitmapData,false);
         TextureMemoryManager.add(_loc1_,"font:" + ident);
         font = new BitmapFont(_loc1_,XML(fntXml.bytes));
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,fntXml,image);
      }
   }
}
