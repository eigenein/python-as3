package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.HitTestImage;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class GuiClipHitTestImage extends GuiClipImage
   {
       
      
      public function GuiClipHitTestImage()
      {
         super();
      }
      
      override protected function createImage(param1:Node) : Image
      {
         var _loc2_:Texture = createTexture(param1.clip);
         if(_loc2_)
         {
            _image = new HitTestImage(_loc2_,param1);
            StarlingClipNode.applyState(image,param1.state);
         }
         else
         {
            _image = new HitTestImage(AssetStorage.rsx.missing,param1);
            StarlingClipNode.applyState(image,param1.state);
            _image.width = param1.clip.bounds.width;
            _image.height = param1.clip.bounds.height;
         }
         _image.alpha = 0;
         return _image;
      }
   }
}
