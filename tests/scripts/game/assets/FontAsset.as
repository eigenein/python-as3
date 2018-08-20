package game.assets
{
   import engine.core.assets.AssetProvider;
   import engine.core.assets.file.AssetFileURL;
   import engine.core.assets.file.RawDataFile;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   
   public class FontAsset extends GameAsset
   {
       
      
      protected var fntXml:RawDataFile;
      
      protected var texture:String;
      
      protected var guiAssetAtlas:String;
      
      public var font:BitmapFont;
      
      public function FontAsset(param1:*)
      {
         super(param1);
         fntXml = getDataFile(param1.xml);
         texture = param1.texture;
         guiAssetAtlas = param1.guiAssetAtlas;
      }
      
      public static function create(param1:*) : FontAsset
      {
         var _loc2_:* = null;
         if(param1.texture)
         {
            _loc2_ = AssetFileURL.getExtension(param1.texture);
            var _loc3_:* = _loc2_;
            if("png" !== _loc3_)
            {
               if("jpg" !== _loc3_)
               {
                  return new FontAsset(param1);
               }
            }
            return new SingleImageFontAsset(param1);
         }
         return new FontAsset(param1);
      }
      
      public function dispose() : void
      {
         fntXml.free();
         font = null;
      }
      
      public function get atlas() : String
      {
         return guiAssetAtlas;
      }
      
      override public function get completed() : Boolean
      {
         return font;
      }
      
      override public function complete() : void
      {
         var _loc1_:* = null;
         fntXml.capture();
         if(guiAssetAtlas)
         {
            _loc1_ = (AssetStorage.rsx.getByName(guiAssetAtlas) as RsxGuiAsset).getTexture(this.texture);
            font = new BitmapFont(_loc1_,XML(fntXml.bytes));
         }
      }
      
      public function completeWithExternalTexture(param1:Texture) : void
      {
         fntXml.capture();
         font = new BitmapFont(param1,XML(fntXml.bytes));
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,fntXml,AssetStorage.rsx.getByName(guiAssetAtlas));
      }
      
      public function fontCopy() : BitmapFont
      {
         return new BitmapFont(font.texture,XML(fntXml.bytes));
      }
   }
}
