package game.assets
{
   import com.progrestar.common.util.assert;
   import engine.core.assets.FileDependentAsset;
   import engine.core.assets.file.ImageFile;
   import engine.core.assets.file.RawDataFile;
   import engine.core.assets.file.RsxFile;
   import engine.core.assets.file.SwfFile;
   import game.assets.storage.AssetStorage;
   
   public class GameAsset extends FileDependentAsset
   {
       
      
      public var ident:String;
      
      private var _used:int = 0;
      
      public function GameAsset(param1:*)
      {
         super();
         if(param1 is String)
         {
            ident = param1;
         }
         else if(param1.id)
         {
            ident = param1.id;
         }
         else if(param1.ident)
         {
            ident = param1.ident;
         }
         assert(ident);
      }
      
      protected static function getImageFile(param1:String) : ImageFile
      {
         return AssetStorage.instance.getAssetFile(param1) as ImageFile;
      }
      
      protected static function getSwfFile(param1:String) : SwfFile
      {
         return AssetStorage.instance.getAssetFile(param1) as SwfFile;
      }
      
      protected static function getRsxFile(param1:String) : RsxFile
      {
         return AssetStorage.instance.getAssetFile(param1) as RsxFile;
      }
      
      protected static function getDataFile(param1:String) : RawDataFile
      {
         return AssetStorage.instance.getAssetFile(param1) as RawDataFile;
      }
      
      public function get used() : int
      {
         return _used;
      }
      
      public function addUsage() : void
      {
         _used = Number(_used) + 1;
      }
      
      public function dropUsage() : void
      {
         _used = Number(_used) - 1;
      }
   }
}
