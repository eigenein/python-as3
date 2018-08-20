package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.context.GameContext;
   import engine.core.assets.file.ImageFile;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorage;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class HeroPopupEpicArtFrameClip extends GuiClipNestedContainer
   {
       
      
      private var file:ImageFile;
      
      public var image:GuiClipImage;
      
      public var frame:GuiClipScale3Image;
      
      public function HeroPopupEpicArtFrameClip()
      {
         image = new GuiClipImage();
         frame = new GuiClipScale3Image(46,1,"vertical");
         super();
      }
      
      public function commitData(param1:PlayerHeroEntry) : void
      {
         image.graphics.visible = false;
         file = GameContext.instance.assetIndex.getAssetFile(param1.hero.epicArtAsset) as ImageFile;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(file,handler_assetLoaded);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         image.graphics.width = Math.round(image.graphics.width);
         image.graphics.height = Math.round(image.graphics.height);
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         if(param1 == file)
         {
            image.graphics.visible = true;
            image.image.texture = param1.texture;
         }
      }
   }
}
