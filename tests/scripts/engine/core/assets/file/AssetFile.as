package engine.core.assets.file
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.assert;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.PrimaryAsset;
   import engine.core.assets.RequestableAsset;
   import engine.core.assets.loading.AssetLoaderItem;
   import engine.core.utils.AbstractMethodError;
   
   public class AssetFile extends AssetFileURL implements RequestableAsset, PrimaryAsset
   {
      
      public static const ASSETS:RegExp = /assets\//g;
       
      
      private var occurrences:int;
      
      public function AssetFile(param1:String, param2:String, param3:AssetPath, param4:int)
      {
         super(param1,param2,param3,param4);
         occurrences = 0;
         assert(getQualifiedClassName(this) != getQualifiedClassName(AssetFile));
      }
      
      public static function sortByPriority(param1:AssetFile, param2:AssetFile) : int
      {
         return param2.mobile_priority * 1000 + (!!param2.mandatory?1:0) - (param1.mobile_priority * 1000 + (!!param1.mandatory?1:0));
      }
      
      public static function create(param1:String, param2:String, param3:AssetPath, param4:int) : AssetFile
      {
         var _loc5_:String = AssetFileURL.getExtension(param1);
         var _loc6_:* = _loc5_;
         if("png" !== _loc6_)
         {
            if("jpg" !== _loc6_)
            {
               if("swf" !== _loc6_)
               {
                  if("rsx" !== _loc6_)
                  {
                     return new RawDataFile(param1,param2,param3,param4);
                  }
                  return new RsxFile(param1,param2,param3,param4);
               }
               return new SwfFile(param1,param2,param3,param4);
            }
         }
         return new ImageFile(param1,param2,param3,param4);
      }
      
      public function dispose() : void
      {
         throw new AbstractMethodError();
      }
      
      public function get completed() : Boolean
      {
         throw new AbstractMethodError();
      }
      
      public function complete() : void
      {
      }
      
      public function completeAsync(param1:AssetLoaderItem) : void
      {
      }
      
      public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,this);
      }
      
      public final function capture() : void
      {
         occurrences = Number(occurrences) + 1;
      }
      
      public final function free() : void
      {
         occurrences = occurrences - 1;
         if(occurrences - 1 == 0)
         {
            dispose();
         }
      }
      
      public function getLoader() : AssetLoaderItem
      {
         throw new AbstractMethodError();
      }
   }
}
