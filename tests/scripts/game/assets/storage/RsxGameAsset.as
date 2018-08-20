package game.assets.storage
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.utils.ClipUtils;
   import engine.context.GameContext;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.RequestableAsset;
   import engine.core.assets.file.RsxFile;
   import game.assets.GameAsset;
   import starling.textures.Texture;
   
   public class RsxGameAsset extends GameAsset implements RequestableAsset
   {
       
      
      protected var file:RsxFile;
      
      private var permanent:Boolean;
      
      protected var defaultClipProvider:ClipAssetDataProvider;
      
      public var data:ClipAsset;
      
      public function RsxGameAsset(param1:*)
      {
         super(param1);
         if(!(param1 is String))
         {
            init(param1);
         }
      }
      
      public function dispose() : void
      {
         if(AssetDisposingWatcher.DEBUG_ASSET_DISPOSING)
         {
            var _loc4_:int = 0;
            var _loc3_:* = file.data.images;
            for each(var _loc1_ in file.data.images)
            {
               _loc1_.resource = null;
               AssetDisposingWatcher.watch(_loc1_,"image " + file.fileName + ":" + _loc1_.name);
            }
            var _loc6_:int = 0;
            var _loc5_:* = file.data.clips;
            for each(var _loc2_ in file.data.clips)
            {
               _loc2_.resource = null;
               _loc2_.timeLine = null;
               AssetDisposingWatcher.watch(_loc2_,"clip " + file.fileName + ":" + _loc2_.className);
            }
            AssetDisposingWatcher.watch(file.data,"clipAsset " + file.fileName);
         }
         file.dispose();
         data = null;
      }
      
      override public function get completed() : Boolean
      {
         return data != null;
      }
      
      public function get mandatory() : Boolean
      {
         return file != null && file.mandatory;
      }
      
      public function get samplingScale() : Number
      {
         return 1;
      }
      
      override public function complete() : void
      {
         if(file)
         {
            data = file.data;
         }
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,file);
      }
      
      public function init(param1:Object) : void
      {
         this.file = getRsxFile(param1.asset);
         if(file == null && GameContext.instance.consoleEnabled)
         {
            trace("File not found: " + param1.asset);
         }
         this.permanent = param1.permanent;
      }
      
      public function getTexture(param1:String) : Texture
      {
         var _loc2_:Clip = data.getClipByName(param1);
         if(_loc2_)
         {
            return ClipImageCache.getClipTexture(_loc2_);
         }
         return null;
      }
      
      public function getSound(param1:String) : ClipSound
      {
         return ClipUtils.getSoundByName(data,param1);
      }
      
      public function getDefaultClipProvider() : ClipAssetDataProvider
      {
         if(defaultClipProvider == null)
         {
            defaultClipProvider = new ClipAssetDataProvider(data,samplingScale);
         }
         return defaultClipProvider;
      }
      
      override public function addUsage() : void
      {
         super.addUsage();
         AssetStorage.rsx.allowAssetToBeDisposed(this);
      }
      
      override public function dropUsage() : void
      {
         super.dropUsage();
      }
   }
}
