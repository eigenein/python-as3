package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.ClipImageTextureFactory;
   import feathers.display.Scale9Image;
   import feathers.textures.Scale9Textures;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class GuiClipScale9Image extends GuiClipImageBase
   {
       
      
      private var image:Scale9Image;
      
      private var grid:Rectangle;
      
      public function GuiClipScale9Image(param1:Rectangle = null)
      {
         super();
         this.grid = param1;
      }
      
      override public function get graphics() : DisplayObject
      {
         return image;
      }
      
      override public function get container() : DisplayObjectContainer
      {
         return null;
      }
      
      public function get scale9Image() : Scale9Image
      {
         return image;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:* = null;
         if(!grid)
         {
            grid = GuiClipFactoryBase.getScale9Grid(param1.clip);
         }
         if(grid)
         {
            _loc2_ = createTextures(param1.clip,grid);
         }
         if(_loc2_)
         {
            image = new Scale9Image(_loc2_);
         }
         else
         {
            image = new Scale9Image(AssetStorage.rsx.missingScale9);
         }
         image.useSeparateBatch = false;
         super.setNode(param1);
      }
      
      protected function createTextures(param1:Clip, param2:Rectangle) : Scale9Textures
      {
         param2 = param2.clone();
         param2.x = param2.x / param1.invertedResolution;
         param2.y = param2.y / param1.invertedResolution;
         param2.width = param2.width / param1.invertedResolution;
         param2.height = param2.height / param1.invertedResolution;
         return ClipImageTextureFactory.getScale9Texture(param1,param2);
      }
   }
}
