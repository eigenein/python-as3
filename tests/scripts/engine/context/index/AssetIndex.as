package engine.context.index
{
   import com.progrestar.common.Logger;
   import engine.core.assets.file.AssetFile;
   import engine.core.assets.file.AssetPath;
   import engine.core.assets.file.RawDataFile;
   import flash.utils.Dictionary;
   import game.assets.storage.DevAssetRemaping;
   
   public class AssetIndex
   {
       
      
      private const logger:Logger = Logger.getLogger(AssetIndex);
      
      private var dict:Dictionary;
      
      private var libData:Object;
      
      private var static_url:String;
      
      private var _version:String;
      
      private var _libAssetData:Object;
      
      public function AssetIndex()
      {
         super();
      }
      
      public function get libAssetData() : Object
      {
         return _libAssetData;
      }
      
      public function get version() : String
      {
         return _version;
      }
      
      public function getRootURL() : String
      {
         return static_url;
      }
      
      public function getLibFile() : RawDataFile
      {
         return dict["lib.json.gz"] as RawDataFile;
      }
      
      public function getLocaleURL(param1:String) : String
      {
         return (dict[param1 + ".json.gz"] as AssetFile).url;
      }
      
      public function getAssetFile(param1:String) : AssetFile
      {
         if(!dict[param1])
         {
            logger.error("no AssetFile found, id:",param1);
         }
         return dict[param1];
      }
      
      public function init(param1:Object, param2:String) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = undefined;
         dict = new Dictionary();
         this.static_url = param2;
         var _loc3_:AssetPath = new AssetPath(param2);
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for(var _loc7_ in param1)
         {
            _loc4_ = _loc7_.split("/");
            _loc5_ = _loc4_[_loc4_.length - 1].split("?")[0];
            _loc6_ = param1[_loc7_];
            dict[_loc5_] = AssetFile.create(_loc5_,_loc6_.path,_loc3_,_loc6_.size);
         }
      }
      
      public function initLibStaticData(param1:Object) : void
      {
         this._libAssetData = param1;
      }
      
      public function setupIndexVersion(param1:String) : void
      {
         try
         {
            _version = param1.match(/index\.v(\d+)\.json/)[1];
            return;
         }
         catch(e:*)
         {
            _version = "none";
            return;
         }
      }
      
      public function getMandatoryAssets() : Vector.<AssetFile>
      {
         var _loc3_:* = null;
         var _loc6_:* = null;
         if(!dict)
         {
            throw new Error("no file index data");
         }
         var _loc2_:Vector.<AssetFile> = new Vector.<AssetFile>();
         var _loc5_:Array = ["texture","atlas","skeleton","xml","asset"];
         var _loc13_:int = 0;
         var _loc12_:* = libAssetData;
         for each(var _loc7_ in libAssetData)
         {
            var _loc11_:int = 0;
            var _loc10_:* = _loc7_;
            for each(var _loc1_ in _loc7_)
            {
               if(_loc1_.mandatory)
               {
                  var _loc9_:int = 0;
                  var _loc8_:* = _loc5_;
                  for each(var _loc4_ in _loc5_)
                  {
                     if(_loc1_[_loc4_])
                     {
                        _loc3_ = _loc1_[_loc4_];
                        if(DevAssetRemaping.map && DevAssetRemaping.map[_loc3_])
                        {
                           _loc3_ = DevAssetRemaping.map[_loc3_];
                        }
                        _loc6_ = dict[_loc3_];
                        if(_loc6_)
                        {
                           _loc6_.mandatory = _loc1_.mandatory;
                           _loc6_.mobile_priority = _loc1_.mobile_priority;
                           _loc2_[_loc2_.length] = _loc6_;
                        }
                        else
                        {
                           logger.error(_loc1_.ident,"missing",_loc4_,"url",_loc1_[_loc4_]);
                        }
                     }
                  }
                  continue;
               }
            }
         }
         return _loc2_;
      }
   }
}
