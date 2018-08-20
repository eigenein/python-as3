package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import feathers.display.Scale3Image;
   import feathers.textures.Scale3Textures;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class GuiClipScale3ImageBase extends GuiClipImageBase
   {
       
      
      private var _image:Scale3Image;
      
      public function GuiClipScale3ImageBase()
      {
         super();
      }
      
      override public function get graphics() : DisplayObject
      {
         return _image;
      }
      
      override public function get container() : DisplayObjectContainer
      {
         return null;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:Scale3Textures = createTextures(param1.clip);
         if(_loc2_)
         {
            _image = new Scale3Image(_loc2_);
         }
         else
         {
            _image = new Scale3Image(AssetStorage.rsx.missingScale3);
         }
         _image.useSeparateBatch = false;
         super.setNode(param1);
      }
      
      protected function createTextures(param1:Clip) : Scale3Textures
      {
         return ClipImageTextureFactory.getScale3Texture(param1,1,2);
      }
   }
}
