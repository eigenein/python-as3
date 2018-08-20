package game.assets
{
   import game.assets.storage.AssetStorage;
   import org.osflash.signals.Signal;
   
   public class HeroAssetProvider
   {
       
      
      private var asset:HeroRsxAssetDisposable;
      
      private var _complete:Boolean;
      
      public const signal_asset:Signal = new Signal(HeroRsxAssetDisposable);
      
      public function HeroAssetProvider(param1:Function = null)
      {
         super();
         if(param1)
         {
            signal_asset.add(param1);
         }
      }
      
      public function dispose() : void
      {
         if(asset)
         {
            if(!_complete)
            {
               AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
            }
            asset.dropUsage();
            asset = null;
         }
         _complete = false;
         signal_asset.removeAll();
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function request(param1:int, param2:int = 0, param3:Number = 1) : void
      {
         if(asset)
         {
            if(!_complete)
            {
               AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
            }
            asset.dropUsage();
         }
         _complete = false;
         asset = AssetStorage.hero.getClipProvider(param1,param2,param3);
         asset.addUsage();
         AssetStorage.instance.globalLoader.requestAssetWithCallback(asset,handler_assetLoaded);
      }
      
      private function handler_assetLoaded(param1:HeroRsxAssetDisposable) : void
      {
         _complete = true;
         signal_asset.dispatch(param1);
      }
   }
}
