package game.assets.storage.rsx
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import engine.core.clipgui.GuiClipFactory;
   import engine.core.clipgui.IGuiClip;
   import feathers.textures.Scale3Textures;
   import feathers.textures.Scale9Textures;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import starling.textures.Texture;
   
   public class RsxGuiAsset extends RsxGameAsset
   {
       
      
      protected var _factory:GuiClipFactory;
      
      public function RsxGuiAsset(param1:*)
      {
         super(param1);
         _factory = new GuiClipFactory();
      }
      
      public function get factory() : GuiClipFactory
      {
         return _factory;
      }
      
      override public function getTexture(param1:String) : Texture
      {
         param1 = param1 || "";
         var _loc2_:Clip = data.getClipByName(param1);
         if(_loc2_)
         {
            return ClipImageCache.getClipTexture(_loc2_);
         }
         return AssetStorage.rsx.popup_theme.missing_texture;
      }
      
      public function getUnsafeTexture(param1:String) : Texture
      {
         var _loc2_:Clip = data.getClipByName(param1);
         if(_loc2_)
         {
            return ClipImageCache.getClipTexture(_loc2_);
         }
         return null;
      }
      
      public function getScale3Textures(param1:String, param2:int, param3:int) : Scale3Textures
      {
         return ClipImageTextureFactory.getScale3Texture(data.getClipByName(param1),param2,param3);
      }
      
      public function getScale3TexturesVertical(param1:String, param2:int, param3:int) : Scale3Textures
      {
         return ClipImageTextureFactory.getScale3Texture(data.getClipByName(param1),param2,param3,"vertical");
      }
      
      public function getScale9Textures(param1:String, param2:Rectangle) : Scale9Textures
      {
         return ClipImageTextureFactory.getScale9Texture(data.getClipByName(param1),param2);
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         return ClipImageCache.getClipBitmapData(data.getClipByName(param1));
      }
      
      public function create(param1:Class, param2:String) : *
      {
         var _loc3_:* = new param1();
         _factory.create(_loc3_,data.getClipByName(param2));
         return _loc3_;
      }
      
      public function initGuiClip(param1:IGuiClip, param2:String) : void
      {
         _factory.create(param1,data.getClipByName(param2));
      }
   }
}
