package game.view.gui.components
{
   import engine.context.GameContext;
   import engine.core.assets.file.ImageFile;
   import game.assets.storage.AssetStorage;
   
   public class FramedImageClipLoader extends FramedImageClip
   {
       
      
      public function FramedImageClipLoader()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function load(param1:String) : void
      {
         graphics.visible = false;
         var _loc2_:ImageFile = GameContext.instance.assetIndex.getAssetFile(param1) as ImageFile;
         if(_loc2_)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc2_,handler_assetLoaded);
         }
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         graphics.visible = true;
         image.image.texture = param1.texture;
      }
   }
}
