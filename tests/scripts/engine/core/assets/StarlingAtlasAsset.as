package engine.core.assets
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.file.ImageFile;
   import engine.core.assets.file.RawDataFile;
   import game.assets.GameAsset;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.textures.TextureMemoryManager;
   
   public class StarlingAtlasAsset extends GameAsset
   {
       
      
      protected var xml:RawDataFile;
      
      protected var image:ImageFile;
      
      public var atlas:TextureAtlas;
      
      public function StarlingAtlasAsset(param1:*)
      {
         super(param1);
         if(param1.atlas)
         {
            xml = getDataFile(param1.atlas);
         }
         image = getImageFile(param1.texture);
      }
      
      override public function get completed() : Boolean
      {
         return atlas;
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,xml,image);
      }
      
      override public function complete() : void
      {
         assert(xml && image);
         var _loc1_:Texture = Texture.fromBitmapData(image.bitmapData,false);
         TextureMemoryManager.add(_loc1_,image.fileName);
         atlas = new TextureAtlas(_loc1_,XML(xml.bytes));
         assert(atlas.getTextures("").length > 0);
      }
   }
}
